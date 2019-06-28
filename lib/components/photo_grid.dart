import 'package:flutter/material.dart';
import 'package:sharing_codelab/components/app_bar.dart';
import 'package:sharing_codelab/components/images.dart';
import 'package:sharing_codelab/photos_library_api/media_item.dart';

class PhotoGrid extends StatelessWidget {
  const PhotoGrid({ this.photos });

  final List<MediaItem> photos;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(24),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final photo = photos[index];

            return ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: GestureDetector(
                child: CachedImage('${photo.baseUrl}=w256'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => PhotoPage(photo),
                    ),
                  );
                }
              ),
            );
          },
          childCount: photos.length,
        ),
      ),
    );
  }
}

class PhotoPage extends StatelessWidget {
  const PhotoPage(this.photo);

  final MediaItem photo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: plainAppBar(),
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: CachedImage(photo.baseUrl, fit: BoxFit.contain),
          ),
          Container(
            color: Colors.black,
            child: SafeArea(
              minimum: const EdgeInsets.all(24),
              child: Text(
                photo.description ?? '',
                textAlign: TextAlign.right,
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}