import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sharing_codelab/components/buttons.dart';

class StyledDialog extends StatelessWidget {
  const StyledDialog({ this.child });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: child,
      ),
    );
  }
}

class TextDialog extends StatelessWidget {
  const TextDialog({ this.text, this.title });

  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(child: Text(text, softWrap: true)),
          SecondaryButton(
            label: const Text('Copy'),
            onPressed: () => Clipboard.setData(ClipboardData(text: text)),
          )
        ],
      ),
      actions: <Widget>[
        SecondaryButton(
          label: const Text('Close'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

class FormDialog extends StatefulWidget {
  const FormDialog({
    this.hintText,
    this.descriptionText,
    this.buttonLabel,
    this.onSubmit,
  });

  final String hintText;
  final String descriptionText;
  final Widget buttonLabel;
  final FutureOr<void> Function(String) onSubmit;

  @override
  _FormDialogState createState() => _FormDialogState();
}

class _FormDialogState extends State<FormDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _submit(BuildContext context) async {
    // Display the loading indicator.
    setState(() => _isLoading = true);

    await widget.onSubmit(_controller.text);

    // Hide the loading indicator.
    setState(() => _isLoading = false);
    Navigator.pop(context);
  }

  Widget get _child {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
        heightFactor: 4,
      );
    }
    
    return Form(key: _formKey, child: _buildForm(context));
  }

  @override
  Widget build(BuildContext context) {
    // final child = _isLoading
    //     ? const Center(
    //         child: CircularProgressIndicator(),
    //         heightFactor: 4,
    //       )
    //     : Form(
    //         key: _formKey,
    //         child: _buildForm(context),
    //       );

    return StyledDialog(
      child: _child,
    );
  }

  Widget _buildForm(BuildContext context) => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      TextFormField(
        controller: _controller,
        autocorrect: true,
        decoration: InputDecoration(
          hintText: widget.hintText,
        ),
      ),
      Container(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 0,
        ),
        child: Text(
          widget.descriptionText,
          style: const TextStyle(
            color: Colors.grey,
          ),
        ),
      ),
      Center(
        child: PrimaryRaisedButton(
          onPressed: () => _submit(context),
          label: widget.buttonLabel,
        ),
      ),
    ],
  );
}
