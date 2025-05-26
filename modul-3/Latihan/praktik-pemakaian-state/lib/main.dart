import 'package:flutter/material.dart';
import 'package:trial_state/SecondScreen.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  int nilai = 5;

  void _navigateToSecondScreen(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => SecondScreen(totalNilai: nilai)));
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text('Penambahan Angka')),

        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Nilai Awal : $nilai'),
              SizedBox(height: 10,),
              ElevatedButton(
                onPressed: () {
                  setState((){
                     nilai += 1;
                  });
                 
                },
                child: Text('Tambah 1'),
              ),
              SizedBox(height: 10,),
              ElevatedButton(
                onPressed: () {
                  setState((){
                     nilai -= 1;
                  });
                },
                child: Text(
                  'Kurangi 1'
                ),
              ),
              SizedBox(height: 10,),
              ElevatedButton(
                onPressed: () => _navigateToSecondScreen(context),
                child: Text("ke halaman kedua")
                )
            ],
          ),
        ),
      ),
    );
  }
}