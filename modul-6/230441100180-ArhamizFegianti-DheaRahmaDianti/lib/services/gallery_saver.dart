// import 'dart:io';
// import 'dart:typed_data';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:flutter/material.dart';

// Future<void> saveImageToGallery(File imageFile, BuildContext context) async {
//   // Minta izin terlebih dahulu
//   final permissionStatus = await Permission.storage.request();
//   if (!permissionStatus.isGranted) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('Izin penyimpanan ditolak')),
//     );
//     return;
//   }

//   // Convert ke Uint8List
//   final Uint8List bytes = await imageFile.readAsBytes();

//   // Simpan ke galeri
//   final result = await ImageGallerySaver.saveImage(bytes, quality: 100, name: "camera_image_${DateTime.now().millisecondsSinceEpoch}");

//   // Tampilkan notifikasi
//   if (result['isSuccess'] == true || result['isSuccess'] == 1) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('Gambar berhasil disimpan ke galeri')),
//     );
//   } else {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('Gagal menyimpan gambar')),
//     );
//   }
// }
