import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cached_network_image/cached_network_image.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar(this.user);
  
  final GoogleSignInAccount user;

  bool get hasPhoto => user.photoUrl != null;

  ImageProvider get _image =>
    hasPhoto ? CachedNetworkImageProvider(user.photoUrl) : null;

  String get _placeholderChar => <String>[
    user.displayName,
    user.email,
    '-',
  ].map((str) => str?.trimLeft()).
    firstWhere((str) => str != null && str.isNotEmpty)[0].
    toUpperCase();

  Widget get _placeholder => !hasPhoto ? Text(_placeholderChar) : null;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: CircleAvatar(
        backgroundImage: _image,
        child: _placeholder,
      ),
    );
  }
}
