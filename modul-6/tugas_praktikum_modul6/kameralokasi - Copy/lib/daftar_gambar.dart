import 'package:flutter/material.dart';
import 'main.dart'; 
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class DaftarGambarPage extends StatefulWidget {
  final List<ImageWithLocation> imageList;

  DaftarGambarPage({required this.imageList});

  @override
  _DaftarGambarPageState createState() => _DaftarGambarPageState();
}

class _DaftarGambarPageState extends State<DaftarGambarPage> {
  late List<ImageWithLocation> _imageList;

  @override
  void initState() {
    super.initState();
    _imageList = List.from(widget.imageList);
  }

  Future<void> _saveImages() async {
    final prefs = await SharedPreferences.getInstance();

    List<String> dataToSave = _imageList.map((item) {
      final bytes = item.imageFile.readAsBytesSync();
      final base64Image = base64Encode(bytes);

      return json.encode({
        'image': base64Image,
        'latitude': item.latitude,
        'longitude': item.longitude,
      });
    }).toList();

    await prefs.setStringList('saved_images', dataToSave);
  }

  void _hapusGambar(int index) async {
    setState(() {
      _imageList.removeAt(index);
    });
    await _saveImages();
  }

  Widget _buildGridItem(ImageWithLocation data, int index) {
    return Stack(
      children: [
        Card(
          child: Column(
            children: [
              Expanded(
                child: Image.file(
                  data.imageFile,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  'Lat: ${data.latitude.toStringAsFixed(4)}\nLng: ${data.longitude.toStringAsFixed(4)}',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: 4,
          top: 4,
          child: GestureDetector(
            onTap: () => _hapusGambar(index),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black54,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.delete, color: Colors.white, size: 20),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Daftar Gambar')),
      body: _imageList.isEmpty
          ? Center(child: Text('Belum ada gambar'))
          : GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: _imageList.length,
              itemBuilder: (context, index) {
                return _buildGridItem(_imageList[index], index);
              },
            ),
    );
  }
}
