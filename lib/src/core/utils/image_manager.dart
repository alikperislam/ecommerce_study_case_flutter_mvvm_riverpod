import 'package:flutter_svg/flutter_svg.dart';

class ImageManager {
  //? logo designs
  static String appLogo = "assets/image/logo.svg";

  //* pre-load [SVG] images
  static void svgPrecacheImage() {
    var cacheSvgImages = [
      ImageManager.appLogo,
    ];
    for (String element in cacheSvgImages) {
      var loader = SvgAssetLoader(element);
      svg.cache.putIfAbsent(
        loader.cacheKey(null),
        () => loader.loadBytes(
          null,
        ),
      );
    }
  }
}
