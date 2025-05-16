import 'package:flutter/material.dart';
import 'screens/laporan_page.dart';
import 'screens/form_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jadwal Minum Air',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (_) => const LaporanPage(),
        '/form': (_) => const FormPage(),
      },
    );
  }
}
