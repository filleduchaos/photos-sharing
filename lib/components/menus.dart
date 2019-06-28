import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:sharing_codelab/model/photos_library_api_model.dart';
import 'package:sharing_codelab/pages/login_page.dart';
import 'package:sharing_codelab/components/avatar.dart';


enum _AvatarMenuOptions {
  signout,
}

enum AlbumMenuOptions {
  shareWithAnyone,
  shareInApp,
}

class AvatarMenu extends StatelessWidget {
  const AvatarMenu();

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<PhotosLibraryApiModel>(
      builder:
          (BuildContext context, Widget child, PhotosLibraryApiModel apiModel) {
        return PopupMenuButton<_AvatarMenuOptions>(
          child: UserAvatar(apiModel.user),
          offset: const Offset(0, 48),
          onSelected: (_AvatarMenuOptions selection) {
            apiModel.signOut()
              .then((_) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => LoginPage(),
                  ),
                );
              });
          },
          itemBuilder: (BuildContext context) {
            return <PopupMenuEntry<_AvatarMenuOptions>>[
              PopupMenuItem<_AvatarMenuOptions>(
                value: _AvatarMenuOptions.signout,
                child: const Text('Sign out'),
              )
            ];
          },
        );
      }
    );
  }
}

class AlbumMenu extends StatelessWidget {
  const AlbumMenu({ this.onSelect });

  final void Function(BuildContext, AlbumMenuOptions) onSelect;

  static final _items = [
    PopupMenuItem<AlbumMenuOptions>(
      value: AlbumMenuOptions.shareWithAnyone,
      child: const Text('Share with anyone'),
    ),
    PopupMenuItem<AlbumMenuOptions>(
      value: AlbumMenuOptions.shareInApp,
      child: const Text('Share in Trippa'),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<AlbumMenuOptions>(
      icon: const Icon(Icons.more_horiz),
      offset: const Offset(0, 48),
      onSelected: (selection) => onSelect(context, selection),
      itemBuilder: (BuildContext context) => _items,
    );
  }
}
