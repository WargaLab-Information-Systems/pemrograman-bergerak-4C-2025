import 'package:flutter/material.dart';
import 'main.dart';

class HalPage extends StatelessWidget {
  const HalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Halaman Baru')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.purple,
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 60),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const HealthTrackerPage()),
            );
          },
          child: const Text(
            'Masuk ke HealthTrackerPage',
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}


