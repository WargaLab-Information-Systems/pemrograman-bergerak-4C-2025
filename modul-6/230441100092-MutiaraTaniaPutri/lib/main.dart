import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'models/image_data.dart';
import 'services/image_service.dart';
import 'services/location_service.dart';
import 'services/storage_service.dart';
import 'screens/image_list_screen.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Gambar',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ImageData> images = [];

  @override
  void initState() {
    super.initState();
    _loadSavedImages();
  }

  void _loadSavedImages() async {
    final saved = await StorageService.loadImages();
    setState(() {
      images = saved;
    });
  }

  void captureImage() async {
    final file = await ImageService.pickImage();
    if (file == null) return;

    final position = await LocationService.getCurrentLocation();

    final newImage = ImageData(
      path: file.path,
      latitude: position.latitude,
      longitude: position.longitude,
    );

    setState(() {
      images.add(newImage);
    });

    await StorageService.saveImages(images);

    flutterLocalNotificationsPlugin.show(
      0,
      'Gambar Disimpan',
      'Gambar berhasil disimpan ke galeri!',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'channel_id',
          'Notifikasi',
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
    );
  }

  Future<void> checkConnection(BuildContext context) async {
    final result = await Connectivity().checkConnectivity();
    final connected = result == ConnectivityResult.mobile || result == ConnectivityResult.wifi;

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(connected ? "Terhubung ke Internet" : "Tidak ada koneksi"),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ambil Gambar"),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              "Menu Utama",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            _buildMenuButton(
              icon: Icons.camera_alt,
              label: "Ambil Gambar",
              onPressed: captureImage,
            ),
            const SizedBox(height: 16),
            _buildMenuButton(
              icon: Icons.image,
              label: "Lihat Daftar Gambar",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ImageListScreen(images: images),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            _buildMenuButton(
              icon: Icons.wifi,
              label: "Cek Koneksi Internet",
              onPressed: () => checkConnection(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 24),
        label: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text(
            label,
            style: const TextStyle(fontSize: 18),
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.teal,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}

