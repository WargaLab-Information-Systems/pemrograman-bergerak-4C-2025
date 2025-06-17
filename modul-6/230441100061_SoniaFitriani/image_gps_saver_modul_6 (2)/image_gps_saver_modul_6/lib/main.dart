import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initNotifications();
  runApp(const MyApp());
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _initNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image GPS Saver',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
    );
  }
}

class CapturedImage {
  final File imageFile;
  final double latitude;
  final double longitude;

  CapturedImage({
    required this.imageFile,
    required this.latitude,
    required this.longitude,
  });
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ImagePicker _picker = ImagePicker();
  final List<CapturedImage> _images = [];
  String _connectionStatus = "Unknown";

  @override
  void initState() {
    super.initState();
    _checkConnectivity();
  }

  Future<void> _checkConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    setState(() {
      if (connectivityResult == ConnectivityResult.mobile) {
        _connectionStatus = "Mobile Data";
      } else if (connectivityResult == ConnectivityResult.wifi) {
        _connectionStatus = "WiFi";
      } else {
        _connectionStatus = "No Internet";
      }
    });
  }

  Future<void> _showNotification(String message) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('channel_id', 'channel_name',
            channelDescription: 'channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
        0, 'Image GPS Saver', message, platformChannelSpecifics,
        payload: 'item x');
  }

  Future<void> _takePicture() async {
    try {
      // Check permissions for location
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        permission = await Geolocator.requestPermission();
        if (permission != LocationPermission.always &&
            permission != LocationPermission.whileInUse) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Location permission denied')));
          return;
        }
      }

      // Take picture
      final XFile? imageFile = await _picker.pickImage(source: ImageSource.camera);
      if (imageFile == null) return;

      // Get location
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      // Read bytes from file
      final bytes = await imageFile.readAsBytes();

      // Save to gallery
      final result = await ImageGallerySaver.saveImage(Uint8List.fromList(bytes),
          quality: 100, name: 'image_${DateTime.now().millisecondsSinceEpoch}');
      if (result['isSuccess'] == true) {
        // Add to list
        setState(() {
          _images.add(CapturedImage(
              imageFile: File(imageFile.path),
              latitude: position.latitude,
              longitude: position.longitude));
        });

        // Show notification
        await _showNotification(
            'Image saved with location: ${position.latitude}, ${position.longitude}');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to save image')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image GPS Saver'),
        actions: [
          IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                _checkConnectivity();
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Internet status: $_connectionStatus')));
              }),
        ],
      ),
      body: Column(
        children: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Internet connection: $_connectionStatus')),
          ElevatedButton.icon(
            icon: const Icon(Icons.camera_alt),
            label: const Text('Take Picture'),
            onPressed: _takePicture,
          ),
          const SizedBox(height: 10),
          Expanded(
            child: _images.isEmpty
                ? const Center(child: Text('No images taken yet.'))
                : ListView.builder(
                    itemCount: _images.length,
                    itemBuilder: (context, index) {
                      final item = _images[index];
                      return Card(
                        margin: const EdgeInsets.all(8),
                        child: ListTile(
                          leading: Image.file(item.imageFile, width: 50, fit: BoxFit.cover),
                          title: Text(
                              'Lat: ${item.latitude.toStringAsFixed(5)}, Lon: ${item.longitude.toStringAsFixed(5)}'),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
