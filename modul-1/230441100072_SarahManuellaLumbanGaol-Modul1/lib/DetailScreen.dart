import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('National Park Yosemite'),
      ),
      body: Column(
        children: [
          Image.asset('assets/images/Gmbr01.jpg'),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Lorem ipsum est donec non interdum amet phasellus egestas...',

              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
    );
  }
}
