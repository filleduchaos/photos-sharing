import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:cached_network_image/cached_network_image.dart';

enum ImageOverlay {
  hard,
  soft,
  none,
}

class CachedImage extends StatelessWidget {
  const CachedImage(this.url, {
      this.overlay = ImageOverlay.none,
      this.showDefaultIf = false,
      this.fit = BoxFit.cover,
  });

  Color get _color {
    switch (overlay) {
      case ImageOverlay.hard:
        return Colors.black.withOpacity(.5);
      case ImageOverlay.soft:
        return Colors.black.withOpacity(.25);
      default:
        return Colors.black.withOpacity(.05);
    }
  }

  final String url;
  final ImageOverlay overlay;
  final bool showDefaultIf;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    if (showDefaultIf) {
      return const DefaultThumbnail();
    }

    return CachedNetworkImage(
      imageUrl: url,
      placeholder: (BuildContext context, String url) =>
          const Center(child: CircularProgressIndicator()),
      errorWidget: (BuildContext context, String url, Object error) {
        print(error);
        return const Center(child: Icon(Icons.error));
      },
      fit: fit,
      color: _color,
      colorBlendMode: BlendMode.srcATop,
    );
  }
}

const _gradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    Color(0xff7953d2),
    Color(0xff000070),
  ],
);

class DefaultThumbnail extends StatelessWidget {
  const DefaultThumbnail();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: _gradient,
      ),
      padding: const EdgeInsets.all(5),
      child: SvgPicture.asset(
        'assets/ic_fieldTrippa.svg',
        color: Colors.grey[300].withOpacity(.75),
        height: 48,
        width: 48,
      ),
    );
  }
}
