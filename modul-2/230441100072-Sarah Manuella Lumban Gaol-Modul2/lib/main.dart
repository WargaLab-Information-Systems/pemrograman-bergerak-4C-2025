import 'package:wisataalam/detailpage.dart';
import 'package:wisataalam/homepage.dart';
import 'package:wisataalam/tambahwisata.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LayoutPage(),
      routes: {
        '/layoutpage': (context) => LayoutPage(),
        '/form': (context) => FormPage(),
      },
    ),
  );
}
