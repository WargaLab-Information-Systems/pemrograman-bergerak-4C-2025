// Nama Lengkap: Sonia Fitriani
// NIM: 230441100061
// Kelas: Praktikum Pemograman Berbasis Web
// Nama Asprak: Devi

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:todo_mahasiswa/pages/home_page.dart'; // untuk kIsWeb

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyAMW5aAni-Gjxx9-CykrmVZVKjWX3MFVy0",
        authDomain: "api-sonia-9999c.firebaseapp.com",
        projectId: "api-sonia-9999c",
        storageBucket: "api-sonia-9999c.appspot.com",
        messagingSenderId: "523932937655",
        appId: "1:523932937655:web:xxxxxx", // GANTI dengan yang dari Firebase
        databaseURL: "https://api-sonia-9999c-default-rtdb.firebaseio.com",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do List Mahasiswa',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
