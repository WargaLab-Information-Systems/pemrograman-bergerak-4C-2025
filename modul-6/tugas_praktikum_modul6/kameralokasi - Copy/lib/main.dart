import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:io';
import 'daftar_gambar.dart';
import 'connectivity.dart';
import 'notification.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initNotification(); 

  if (await Permission.notification.isDenied) {
    await Permission.notification.request();
  }

  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Akses Kamera & Galeri + Lokasi',
      debugShowCheckedModeBanner: false,
      home: ImagePickerExample(),
    );
  }
}

class ImageWithLocation {
  final File imageFile;
  final double latitude;
  final double longitude;

  ImageWithLocation(this.imageFile, this.latitude, this.longitude);
}

class ImagePickerExample extends StatefulWidget {
  @override
  _ImagePickerExampleState createState() => _ImagePickerExampleState();
}

class _ImagePickerExampleState extends State<ImagePickerExample> {
  final ImagePicker picker = ImagePicker();
  List<ImageWithLocation> _imageList = [];

  @override
  void initState() {
    super.initState();
    _loadSavedImages();
  }

  Future<void> _loadSavedImages() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? savedData = prefs.getStringList('saved_images');

    if (savedData != null) {
      List<ImageWithLocation> loadedImages = savedData.map((item) {
        final Map<String, dynamic> data = json.decode(item);
        final base64Image = data['image'] as String;
        final latitude = data['latitude'] as double;
        final longitude = data['longitude'] as double;

        final bytes = base64Decode(base64Image);
        final tempDir = Directory.systemTemp;
        final tempFile = File('${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.png');
        tempFile.writeAsBytesSync(bytes);

        return ImageWithLocation(tempFile, latitude, longitude);
      }).toList();

      setState(() {
        _imageList = loadedImages;
      });
    }
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

  Future<void> _getImage(ImageSource source) async {
    bool permissionGranted = false;

    if (source == ImageSource.camera) {
      final status = await Permission.camera.request();
      permissionGranted = status.isGranted;
    } else {
      if (Platform.isAndroid) {
        final photoStatus = await Permission.photos.request();
        final storageStatus = await Permission.storage.request();
        permissionGranted = photoStatus.isGranted || storageStatus.isGranted;
      } else if (Platform.isIOS) {
        final status = await Permission.photos.request();
        permissionGranted = status.isGranted;
      }
    }

    if (!permissionGranted) {
      await showNotification('Akses Ditolak', 'Tidak dapat mengakses media.');
      return;
    }

    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      final File image = File(pickedFile.path);

      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        await showNotification('Layanan Lokasi', 'Layanan lokasi tidak aktif.');
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.deniedForever || permission == LocationPermission.denied) {
          await showNotification('Izin Lokasi Ditolak', 'Tidak dapat mengakses lokasi.');
          return;
        }
      }

      Position position = await Geolocator.getCurrentPosition();

      setState(() {
        _imageList.add(ImageWithLocation(image, position.latitude, position.longitude));
      });

      await _saveImages(); 

      await showNotification('Gambar Disimpan', 'Berhasil menambahkan gambar dengan lokasi.');
    }
  }

  void _bukaHalamanGambar() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DaftarGambarPage(imageList: _imageList),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ambil Gambar & Lokasi')),
      body: Center(
        child: ElevatedButton(
          onPressed: _bukaHalamanGambar,
          child: Text('Lihat Gambar'),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'kamera',
            onPressed: () => _getImage(ImageSource.camera),
            tooltip: 'Ambil dari Kamera',
            child: Icon(Icons.camera_alt),
          ),
          SizedBox(height: 16),
          FloatingActionButton(
            heroTag: 'galeri',
            onPressed: () => _getImage(ImageSource.gallery),
            tooltip: 'Ambil dari Galeri',
            child: Icon(Icons.photo_library),
          ),
          SizedBox(height: 16),
          FloatingActionButton(
            heroTag: 'cek_koneksi',
            onPressed: () async {
              String status = await cekKoneksiInternet();
              await showNotification('Status Koneksi', status);
            },
            child: Icon(Icons.wifi),
            tooltip: 'Cek Koneksi Internet',
          ),
        ],
      ),
    );
  }
}

