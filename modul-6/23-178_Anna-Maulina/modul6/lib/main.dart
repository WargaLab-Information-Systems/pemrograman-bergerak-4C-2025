// main.dart
import 'package:flutter/material.dart';
import 'package:modul6/screens/image_picker_example.dart'; 
import 'package:modul6/services/notification_service.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupNotification(); 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Camera & Gallery & Sensor Access',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ImagePickerExample(),
      debugShowCheckedModeBanner: false,
    );
  }
}