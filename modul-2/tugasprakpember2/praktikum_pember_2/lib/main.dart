import 'package:flutter/material.dart';
import 'package:praktikum_pember_1/layout_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Latihan Flutter Modul 1',
      theme: ThemeData(),
      home: const LayoutPage(),
    );
  }
}