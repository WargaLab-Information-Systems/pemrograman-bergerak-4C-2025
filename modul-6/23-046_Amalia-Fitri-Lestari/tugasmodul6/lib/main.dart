import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Akses Kamera & Galeri & Sensor',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        scaffoldBackgroundColor: Colors.pink.shade50,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.pinkAccent,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.pinkAccent,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        textTheme: TextTheme(
          bodyMedium: TextStyle(color: Colors.pink.shade900, fontSize: 16),
          titleLarge: TextStyle(
              color: Colors.pink.shade900,
              fontWeight: FontWeight.bold,
              fontSize: 20),
        ),

      ),
      home: ImagePickerExample(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ImagePickerExample extends StatefulWidget {
  @override
  _ImagePickerExampleState createState() => _ImagePickerExampleState();
}

class _ImagePickerExampleState extends State<ImagePickerExample> {
  File? _image;
  final _picker = ImagePicker();
  bool _cameraPermissionGranted = false;
  bool _storagePermissionGranted = false;
  bool _locationPermissionGranted = false;
  Position? _currentPosition;
  List<ImageEntry> _imageEntries = [];

  @override
  void initState() {
    super.initState();
    _checkPermissions();
    checkConnection();
  }

  Future<void> _checkPermissions() async {
    var cameraStatus = await Permission.camera.status;
    setState(() {
      _cameraPermissionGranted = cameraStatus.isGranted;
    });

    if (Platform.isAndroid) {
      var storageStatus = await Permission.storage.status;
      setState(() {
        _storagePermissionGranted = storageStatus.isGranted;
      });
    } else if (Platform.isIOS) {
      var photosStatus = await Permission.photos.status;
      setState(() {
        _storagePermissionGranted = photosStatus.isGranted;
      });
    }

    var locationStatus = await Permission.locationWhenInUse.status;
    setState(() {
      _locationPermissionGranted = locationStatus.isGranted;
    });
  }

  Future<void> _requestPermission(
      Permission permission, String permissionName) async {
    var status = await permission.request();
    if (status.isGranted) {
      setState(() {
        if (permission == Permission.camera) _cameraPermissionGranted = true;
        if (permission == Permission.storage ||
            permission == Permission.photos) _storagePermissionGranted = true;
        if (permission == Permission.locationWhenInUse)
          _locationPermissionGranted = true;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Izin $permissionName tidak diberikan'),
          backgroundColor: Colors.pink.shade200,
        ),
      );
      setState(() {
        if (permission == Permission.camera) _cameraPermissionGranted = false;
        if (permission == Permission.storage ||
            permission == Permission.photos) _storagePermissionGranted = false;
        if (permission == Permission.locationWhenInUse)
          _locationPermissionGranted = false;
      });
    }
  }

  Future<Position?> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Layanan lokasi dinonaktifkan.'),
          backgroundColor: Colors.pink.shade200,
        ),
      );
      return null;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Izin lokasi ditolak.'),
            backgroundColor: Colors.pink.shade200,
          ),
        );
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Izin lokasi ditolak secara permanen, kami tidak dapat meminta izin.'),
          backgroundColor: Colors.pink.shade200,
        ),
      );
      return null;
    }

    try {
      return await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
    } catch (e) {
      print("Error getting location: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal mendapatkan lokasi: ${e.toString()}'),
          backgroundColor: Colors.pink.shade200,
        ),
      );
      return null;
    }
  }

  Future<void> checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    String status;

    if (connectivityResult == ConnectivityResult.mobile) {
      status = "Koneksi seluler aktif";
    } else if (connectivityResult == ConnectivityResult.wifi) {
      status = "Terhubung ke Wi-Fi";
    } else if (connectivityResult == ConnectivityResult.none) {
      status = "Tidak ada koneksi internet";
    } else {
      status = "Status koneksi tidak diketahui";
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Status Koneksi: $status'),
        backgroundColor: Colors.pink.shade300,
      ),
    );
  }

  Future<void> _getImage(ImageSource source) async {
    if (source == ImageSource.camera) {
      await _requestPermission(Permission.camera, 'kamera');
      if (!_cameraPermissionGranted) return;
    } else {
      if (Platform.isAndroid) {
        await _requestPermission(Permission.storage, 'penyimpanan');
        if (!_storagePermissionGranted) return;
      } else if (Platform.isIOS) {
        await _requestPermission(Permission.photos, 'galeri');
        if (!_storagePermissionGranted) return;
      }
    }

    await _requestPermission(Permission.locationWhenInUse, 'lokasi');
    if (_locationPermissionGranted) {
      _currentPosition = await getCurrentLocation();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text('Izin lokasi tidak diberikan, lokasi tidak akan disimpan.'),
          backgroundColor: Colors.pink.shade200,
        ),
      );
    }

    final pickedFile = await _picker.pickImage(source: source);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _imageEntries.add(ImageEntry(
          imageFile: _image!,
          location: _currentPosition,
          timestamp: DateTime.now(),
        ));
      } else {
        print('Tidak ada gambar yang dipilih.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text('Akses Kamera & Galeri & Sensor'),
        backgroundColor: Colors.pinkAccent,
        centerTitle: true,
        elevation: 5,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _image == null
                    ? Text(
                        'Belum ada gambar.',
                        style: textTheme.bodyMedium!
                            .copyWith(fontWeight: FontWeight.w500),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.file(
                          _image!,
                          height: 250,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                SizedBox(height: 24),
                _currentPosition != null
                    ? Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.pink.shade100,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'Lokasi: Lat: ${_currentPosition!.latitude.toStringAsFixed(4)}, Lon: ${_currentPosition!.longitude.toStringAsFixed(4)}',
                          style: textTheme.bodyMedium!
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                      )
                    : Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.pink.shade100,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'Lokasi tidak tersedia.',
                          style: textTheme.bodyMedium!
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                      ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    FloatingActionButton(
                      heroTag: 'camera',
                      onPressed: () {
                        _getImage(ImageSource.camera);
                      },
                      tooltip: 'Ambil dari kamera',
                      child: Icon(Icons.camera_alt),
                    ),
                    FloatingActionButton(
                      heroTag: 'gallery',
                      onPressed: () {
                        _getImage(ImageSource.gallery);
                      },
                      tooltip: 'Ambil dari galeri',
                      child: Icon(Icons.photo_library),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                ElevatedButton.icon(
                  icon: Icon(Icons.photo_album),
                  label: Text('Lihat Daftar Gambar'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ImageListScreen(
                                imageEntries: _imageEntries,
                              )),
                    );
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton.icon(
                  icon: Icon(Icons.wifi),
                  label: Text('Cek Koneksi Internet'),
                  onPressed: () => checkConnection(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ImageEntry {
  final File imageFile;
  final Position? location;
  final DateTime timestamp;

  ImageEntry({required this.imageFile, this.location, required this.timestamp});
}

class ImageListScreen extends StatelessWidget {
  final List<ImageEntry> imageEntries;

  const ImageListScreen({Key? key, required this.imageEntries}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Gambar'),
        backgroundColor: Colors.pinkAccent,
        centerTitle: true,
        elevation: 5,
      ),
      body: imageEntries.isEmpty
          ? Center(
              child: Text(
                'Belum ada gambar yang diambil.',
                style: textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.pink.shade700,
                ),
              ),
            )
          : ListView.builder(
              itemCount: imageEntries.length,
              itemBuilder: (context, index) {
                final entry = imageEntries[index];
                return Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  elevation: 4,
                  shadowColor: Colors.pink.shade100,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.file(
                            entry.imageFile,
                            height: 180,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: 12),
                        Text(
                          'Waktu: ${entry.timestamp.toLocal().toString().split('.')[0]}',
                          style: textTheme.bodyMedium!
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 6),
                        if (entry.location != null)
                          Text(
                            'Lokasi: Lat: ${entry.location!.latitude.toStringAsFixed(4)}, Lon: ${entry.location!.longitude.toStringAsFixed(4)}',
                            style: textTheme.bodyMedium,
                          ),
                        if (entry.location == null)
                          Text(
                            'Lokasi: Tidak ada informasi lokasi',
                            style: textTheme.bodyMedium,
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
