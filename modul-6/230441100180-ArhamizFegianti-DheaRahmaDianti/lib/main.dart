import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'services/noitification.dart';
// import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // WidgetsFlutterBinding.ensureInitialized();

  await initializeNotifications();
  // await Firebase.initializeApp();
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Akses Kamera & Galeri',
      home: ImagePickerExample(),
      debugShowCheckedModeBanner: false,
    );
  }
}
