
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tugasmodul1/model/wisata.dart';

class DetailPage extends StatelessWidget {
  final WisataModel wisata;

  const DetailPage({super.key, required this.wisata});

  // Fungsi untuk membedakan jenis path gambar
  Widget buildImage(String path) {
    if (path.startsWith('assets/')) {
      return Image.asset(
        path,
        width: 353,
        height: 202,
        fit: BoxFit.cover,
      );
    } else {
      return Image.file(
        File(path),
        width: 353,
        height: 202,
        fit: BoxFit.cover,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey[100],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          wisata.nama,
          style: const TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: buildImage(wisata.imagePath),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.landscape, size: 20, color: Colors.green),
                        const SizedBox(width: 4),
                        Text(
                          wisata.jenis,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(Icons.location_on, size: 20, color: Colors.red),
                        const SizedBox(width: 4),
                        Text(
                          wisata.lokasi,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ],
                ),
                Text(
                  wisata.harga,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              wisata.deskripsi,
              style: const TextStyle(fontSize: 14),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
