import 'package:flutter/material.dart';
import 'package:sharing_codelab/photos_library_api/album.dart';
import 'package:sharing_codelab/components/images.dart';
import 'package:sharing_codelab/components/stacked_card.dart';

const _shareIcon = Padding(
  padding: EdgeInsets.only(right: 8),
  child: Icon(
    Icons.folder_shared,
    color: Colors.black38,
  ),
);

class TripCard extends StatelessWidget {
  TripCard({ @required this.album, this.onTap })
    : super(key: Key(album.id));

  final Album album;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return StackedCard(
      onTap: onTap,
      background: Hero(
        tag: 'cover-${album.id}',
        child: CachedImage(
          album.coverPhotoBaseUrl,
          overlay: ImageOverlay.soft,
          showDefaultIf: album.isEmpty,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (album.shareInfo != null)
            _shareIcon
          else
            const SizedBox(),
          Text(
            album.title ?? '[no title]',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ]
      ),
    );
  }
}
