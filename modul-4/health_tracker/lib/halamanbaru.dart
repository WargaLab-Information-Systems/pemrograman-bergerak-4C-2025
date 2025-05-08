import 'package:flutter/material.dart';
import 'main.dart';

class HalPage extends StatelessWidget {
  const HalPage ({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: const Text('halaman berikutnya')),
      body: Center(
        child: ElevatedButton(
          onPressed: (){
            Navigator.pushReplacement(
            context, 
            MaterialPageRoute(builder: (_) => const HealthTrackerPage()),
            );
          },
          child: const Text ('halaman'),
          
          ),
      ),

    );
  }
}

