import 'package:flutter/material.dart';
import 'package:alat_musik_tradisional/screens/alat_musik_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Alat Musik Tradisional',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: AlatMusikListScreen(),
    );
  }
}
