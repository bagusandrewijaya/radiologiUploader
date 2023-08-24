import 'package:mime/mime.dart';

enum ImageMimeType { image, video, other }

class ImageUtils {
  //

  static ImageMimeType checkMimeType(String path) {
    final mime = lookupMimeType(path);

    if (mime.startsWith('image/')) {
      return ImageMimeType.image;
    }
    if (mime.startsWith('video/')) {
      return ImageMimeType.video;
    }
    return ImageMimeType.other;
  }

  static String imgeByMimeType(String path) {
    final mimeType = checkMimeType(path);
    if (mimeType == ImageMimeType.video) {
      return 'images/VIDEO.png';
    }
    if (mimeType == ImageMimeType.image) {
      return 'images/png.png';
    }

    return 'images/jpg.png';
  }
}
