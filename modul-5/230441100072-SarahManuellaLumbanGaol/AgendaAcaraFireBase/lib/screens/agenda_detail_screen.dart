import 'package:flutter/material.dart';
import '../models/agenda.dart';

class AgendaDetailScreen extends StatelessWidget {
  final Agenda agenda;

  AgendaDetailScreen({required this.agenda});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detail Agenda')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nama Agenda', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(agenda.nama, style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            Text('Detail', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(agenda.detail, style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            Text('Tanggal', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(agenda.tanggal, style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            Text('Lokasi', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(agenda.lokasi, style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
