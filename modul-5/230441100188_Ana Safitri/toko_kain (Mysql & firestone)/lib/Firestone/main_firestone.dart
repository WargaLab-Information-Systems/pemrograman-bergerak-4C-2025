import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:toko_kain/firebase_options.dart'; // ini dari flutterfire configure
import 'home_firestone.dart'; // ganti sesuai file awal kamu

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Toko Kain',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeFirestore(), // pakai halaman kamu
    );
  }
}
