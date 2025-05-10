import 'package:flutter/material.dart';
// import 'form-page.dart';
import 'form_mahasiswa.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Ini latar kosong (bisa diganti nanti kalau mau)
        const Center(child: Text('Belum ada data')),

        // Tombol di pojok kanan bawah
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  // Menampilkan form yang berbeda anta form page latihan dan formmahasiswa
                  
                  // MaterialPageRoute(builder: (context) => const FormPage()),
                  MaterialPageRoute(builder: (context) => const FormMahasiswa()),
                );
              },
              child: const Icon(Icons.add),
            ),
          ),
        ),
      ],
    );
  }
}