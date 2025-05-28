import 'dart:io';
import 'package:flutter/material.dart';
import '../models/image_data.dart';

class ImageListScreen extends StatelessWidget {
  final List<ImageData> images;

  const ImageListScreen({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Gambar')),
      body: ListView.builder(
        itemCount: images.length,
        itemBuilder: (context, index) {
          final img = images[index];
          return ListTile(
            leading: Image.file(File(img.path), width: 50, height: 50, fit: BoxFit.cover),
            title: Text('Lat: ${img.latitude}, Long: ${img.longitude}'),
          );
        },
      ),
    );
  }
}
