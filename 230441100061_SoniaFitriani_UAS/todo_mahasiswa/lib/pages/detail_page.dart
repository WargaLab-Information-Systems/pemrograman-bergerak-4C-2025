import 'package:flutter/material.dart';
import '../models/task_model.dart';

class DetailPage extends StatelessWidget {
  final Tugas tugas;
  const DetailPage({super.key, required this.tugas});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Detail Tugas")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            buildDetail("Judul Tugas", tugas.judul),
            buildDetail("Kategori", tugas.kategori),
            buildDetail("Deadline", tugas.deadline),
            buildDetail("Keterangan", tugas.selesai ? "Sudah Selesai" : "Belum Selesai"),
            const SizedBox(height: 10),
            const Text("Gambar Pendukung:"),
            const SizedBox(height: 10),
            Image.asset("assets/static_image.png", height: 120), // Gambar statis
          ],
        ),
      ),
    );
  }

  Widget buildDetail(String label, String value) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade200,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text("$label :\n$value", style: const TextStyle(fontSize: 16)),
    );
  }
}
