import 'dart:io';
import 'package:path_provider/path_provider.dart';

class LocalStorageService {
  static Future<String> get _localPath async {
    final tempDir = Directory(
      'C:\\Users\\LENOVO\\AppData\\Local\\Temp\\Penyimpanan\\MyAppPhotos',
    );
    if (!await tempDir.exists()) {
      await tempDir.create(recursive: true);
    }
    return tempDir.path;
  }

  static Future<String> saveImage(File imageFile) async {
    try {
      final path = await _localPath;
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final fileName = 'photo_$timestamp.jpg';
      final savedFile = await imageFile.copy('$path\\$fileName');

      return savedFile.path;
    } catch (e) {
      print('Error saving image: $e');
      rethrow;
    }
  }

  static Future<void> openSaveFolder() async {
    final path = await _localPath;
    if (Platform.isWindows) {
      await Process.run('explorer', [path.replaceAll('/', '\\')]);
    }
  }
}
