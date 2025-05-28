import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'screens/camera_screen.dart';
import 'screens/gallery_screen.dart';
import 'screens/pick_image_screen.dart';
import 'models/captured_image.dart';

late List<CameraDescription> cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    cameras = await availableCameras();
    runApp(const MyApp());
  } catch (e) {
    debugPrint('Camera initialization failed: $e');

    runApp(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: Text('Camera initialization failed: ${e.toString()}'),
          ),
        ),
      ),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<CapturedImage> _images = [];

  void _addImage(CapturedImage image) {
    setState(() => _images.insert(0, image));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Camera GPS App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(images: _images, onNewImage: _addImage),
    );
  }
}

class HomePage extends StatelessWidget {
  final List<CapturedImage> images;
  final Function(CapturedImage) onNewImage;

  const HomePage({required this.images, required this.onNewImage, Key? key})
    : super(key: key);

  Future<void> _navigateAndAddImage(BuildContext context, Widget page) async {
    Navigator.pop(context);
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => page),
    );
    if (result is CapturedImage) {
      onNewImage(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Select an option from the menu'),
            const SizedBox(height: 20),
            Text('Total images: ${images.length}'),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text('Menu', style: TextStyle(color: Colors.white)),
            ),
            ListTile(
              leading: const Icon(Icons.camera),
              title: const Text('Camera'),
              onTap:
                  () => _navigateAndAddImage(
                    context,
                    CameraScreen(cameras: cameras),
                  ),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Gallery'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => GalleryScreen(images: images),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.image),
              title: const Text('Pick Image'),
              onTap:
                  () => _navigateAndAddImage(context, const PickImageScreen()),
            ),
          ],
        ),
      ),
    );
  }
}
