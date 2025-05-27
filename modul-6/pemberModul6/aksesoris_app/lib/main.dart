import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Minta permission penting dulu
  await [
    Permission.camera,
    Permission.photos,
    Permission.storage,
    Permission.location,
  ].request();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Toko Aksesoris',
      theme: ThemeData(primarySwatch: Colors.pink),
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
    );
  }
}
