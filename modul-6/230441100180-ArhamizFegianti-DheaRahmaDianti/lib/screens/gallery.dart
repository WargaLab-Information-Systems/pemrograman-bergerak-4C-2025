import 'dart:io';
import 'package:flutter/material.dart';
import '../models/image_loc.dart';


class GalleryPage extends StatefulWidget {
  final List<ImageWithLocation> images;
  final Function(List<ImageWithLocation>) onDelete;

  GalleryPage({required this.images, required this.onDelete});

  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  late List<ImageWithLocation> _localImages;

  @override
  void initState() {
    super.initState();
    _localImages = List.from(widget.images);
  }

  void _deleteImage(int index) async {
    setState(() {
      _localImages.removeAt(index);
    });
    await widget.onDelete(_localImages);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Galeri Gambar')),
      body: _localImages.isEmpty
          ? Center(child: Text('Belum ada gambar diambil'))
          : ListView.builder(
              itemCount: _localImages.length,
              itemBuilder: (context, index) {
                final item = _localImages[index];
                return Card(
                  margin: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Image.file(File(item.imagePath), height: 200),
                      if (item.locationText != null)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Lokasi: ${item.locationText!}',
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            onPressed: () => _deleteImage(index),
                            icon: Icon(Icons.delete, color: Colors.red),
                          ),
                          // IconButton(
                          //   onPressed: () => saveImageToGallery(File(item.imagePath), context),
                          //   icon: Icon(Icons.save, color: Colors.green),
                          //   tooltip: 'Simpan ke Galeri',
                          // ),
                        ],
                      ),
                    ],
                  ),
                );

              },
            ),
    );
  }
}