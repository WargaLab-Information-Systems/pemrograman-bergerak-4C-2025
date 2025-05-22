import 'dart:io';
import 'dart:typed_data';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class GalleryService {
  static Future<bool> saveImageToGallery(File imageFile) async {
    try {
      final status = await Permission.storage.request();
      if (status.isGranted) {
        Uint8List bytes = await imageFile.readAsBytes();
        final result = await ImageGallerySaver.saveImage(bytes);
        return result['isSuccess'] ?? false;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
