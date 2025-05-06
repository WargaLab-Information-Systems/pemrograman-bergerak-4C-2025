import 'package:flutter/material.dart';
import 'package:flutter_api_modul4/screens/KatalogBuku_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: KatalogbukuScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
