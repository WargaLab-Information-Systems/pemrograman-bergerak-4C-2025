// main.dart
import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/add_place_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Wisata',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const HomePage(),
      routes: {
        '/add': (context) => const AddPlacePage(),
      },
    );
  }
}
