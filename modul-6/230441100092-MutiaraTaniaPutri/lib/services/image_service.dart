import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

class ImageService {
  static Future<File?> pickImage() async {
    final picker = ImagePicker();

    // Minta izin
    final permission = await Permission.camera.request();
    final storagePermission = await Permission.photos.request(); 

    if (!permission.isGranted || !storagePermission.isGranted) {
      print("Izin kamera atau galeri ditolak.");
      return null;
    }

    // Ambil gambar dari kamera
    print("Membuka kamera...");
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile == null) {
      print("Tidak ada gambar dipilih.");
      return null;
    }

    final file = File(pickedFile.path);
    print("Gambar diambil: ${file.path}");

    // Simpan langsung via ImageGallerySaver
    final result = await ImageGallerySaver.saveFile(file.path);
    print("Hasil simpan: $result");

    return file;
  }
}
