import 'package:flutter/material.dart';
import 'package:sharing_codelab/components/dialogs.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:sharing_codelab/model/photos_library_api_model.dart';
import '../util/to_be_implemented.dart';

class JoinTripDialog extends StatelessWidget {
  const JoinTripDialog();

  @override
  Widget build(BuildContext context) {
    return FormDialog(
      hintText: 'Paste the share token',
      descriptionText: 'This will join an album in your '
                        'Google Photos account',
      buttonLabel: const Text('Join Trip'),
      onSubmit: (String shareToken) async {
        // TODO(codelab): Implement this call
        ToBeImplemented.showMessage();

        // Call the API to join an album with the entered share token
        // return ScopedModel.of<PhotosLibraryApiModel>(context)
        //     .joinSharedAlbum(shareToken);
      },
    );
  }
}
