import 'package:flutter/material.dart';
import 'package:sharing_codelab/components/dialogs.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:sharing_codelab/model/photos_library_api_model.dart';
import '../util/to_be_implemented.dart';

class CreateTripDialog extends StatelessWidget {
  const CreateTripDialog();

  @override
  Widget build(BuildContext context) {
    return FormDialog(
      hintText: 'Trip name',
      descriptionText: 'This will create a shared album in your '
                        'Google Photos account',
      buttonLabel: const Text('Create Trip'),
      onSubmit: (String name) {
        // TODO(codelab): Implement call to PhotosLibraryApiModel scope here.
        ToBeImplemented.showMessage();

        // return ScopedModel.of<PhotosLibraryApiModel>(context).createAlbum(name);
      },
    );
  }
}
