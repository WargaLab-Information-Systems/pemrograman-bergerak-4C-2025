import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/image_loc.dart';
import 'package:modul_6/services/internet.dart';
import 'package:modul_6/services/noitification.dart';
import 'gallery.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:flutter/services.dart'; // Untuk ByteData


class ImagePickerExample extends StatefulWidget {
  @override
  _ImagePickerExampleState createState() => _ImagePickerExampleState();
}

class _ImagePickerExampleState extends State<ImagePickerExample> {
  final ImagePicker picker = ImagePicker();
  List<ImageWithLocation> _imagesWithLocations = [];

  @override
  void initState() {
    super.initState();
    _loadImagesFromPrefs();
  }

  Future<void> _getImage(ImageSource source) async {
    bool permissionGranted = false;

    if (source == ImageSource.camera) {
      final status = await Permission.camera.request();
      final storageStatus = await Permission.storage.request();
      permissionGranted = status.isGranted && storageStatus.isGranted;
    } else {
      if (Platform.isAndroid) {
        final status = await Permission.photos.request();
        final statusLegacy = await Permission.storage.request();
        permissionGranted = status.isGranted || statusLegacy.isGranted;
      }
    }

    if (!permissionGranted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Izin tidak diberikan')),
      );
      return;
    }

    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);

      // ✅ Simpan ke galeri
      final bytes = await imageFile.readAsBytes();
      final result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(bytes),
        quality: 100,
        name: "modul6_${DateTime.now().millisecondsSinceEpoch}",
      );

      print("Hasil simpan ke galeri: $result");

      String? location = await _fetchLocation();

      final newItem = ImageWithLocation(
        imagePath: imageFile.path,
        locationText: location,
      );

      setState(() {
        _imagesWithLocations.add(newItem);
      });

      await _saveImagesToPrefs();

      showNotification('Berhasil', 'Gambar berhasil disimpan & masuk galeri!');
    }
  }

  Future<String?> _fetchLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return null;
    }
    if (permission == LocationPermission.deniedForever) return null;

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return 'Lokasi diambil: ${position.latitude}, ${position.longitude}';
  }

  Future<void> _saveImagesToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded =
        _imagesWithLocations.map((e) => json.encode(e.toJson())).toList();
    await prefs.setStringList('images', encoded);
  }

  Future<void> _loadImagesFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? data = prefs.getStringList('images');
    if (data != null) {
      setState(() {
        _imagesWithLocations = data
            .map((e) => ImageWithLocation.fromJson(json.decode(e)))
            .toList();
      });
    }
  }

  Future<void> _updateGallery(List<ImageWithLocation> updated) async {
    setState(() {
      _imagesWithLocations = updated;
    });
    await _saveImagesToPrefs();
  }

  @override
  Widget build(BuildContext context) {
    final lastImage = _imagesWithLocations.isNotEmpty
        ? _imagesWithLocations.last
        : null;

    return Scaffold(
      appBar: AppBar(title: Text('Akses Kamera & Galeri')),
      body: Center(
        child: lastImage == null
            ? Text('Belum ada gambar')
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.file(
                    File(lastImage.imagePath),
                    height: 300,
                  ),
                  if (lastImage.locationText != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Text(
                        lastImage.locationText!,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                ],
              ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => _getImage(ImageSource.camera),
            tooltip: 'Ambil dari Kamera',
            child: Icon(Icons.camera_alt),
          ),
          SizedBox(height: 16),
          FloatingActionButton(
            onPressed: () => _getImage(ImageSource.gallery),
            tooltip: 'Ambil dari Galeri',
            child: Icon(Icons.photo_library),
          ),
          SizedBox(height: 16),
          FloatingActionButton(
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GalleryPage(
                    images: _imagesWithLocations,
                    onDelete: _updateGallery,
                  ),
                ),
              );
            },
            tooltip: 'Lihat Galeri',
            child: Icon(Icons.browse_gallery),
          ),
          SizedBox(height: 16),
          FloatingActionButton(
            onPressed: () => checkInternet(context),
            tooltip: 'Cek Internet',
            child: Icon(Icons.wifi),
          ),
          SizedBox(height: 16),
          FloatingActionButton(
            onPressed: () {
              showNotification('Hai 👋', 'Ini adalah notifikasi lokal!');
            },
            tooltip: 'Notifikasi Tes',
            child: Icon(Icons.notifications),
          ),
        ],
      ),
    );
  }
}
