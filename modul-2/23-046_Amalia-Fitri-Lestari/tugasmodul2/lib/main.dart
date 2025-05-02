import 'package:flutter/material.dart';
import 'package:tugasmodul1/halaman1.dart';

void main() => runApp(const MyApp());
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Praktikum_modul2',
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}