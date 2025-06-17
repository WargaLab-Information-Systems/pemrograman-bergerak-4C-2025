import 'package:flutter/material.dart';
import 'screens/produk_screen.dart'; // pastikan file dan path ini benar

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Manajemen Produk',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        useMaterial3: true,
      ),
      home: const DaftarProdukScreen(), // pastikan class ini ada
      debugShowCheckedModeBanner: false,
    );
  }
}
