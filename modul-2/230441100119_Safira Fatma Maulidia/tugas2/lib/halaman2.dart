import 'package:flutter/material.dart';
import 'dart:typed_data';

class DetailScreen extends StatelessWidget {
  final Map<String, dynamic> wisata;

  const DetailScreen({super.key, required this.wisata});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          wisata['nama'] ?? 'Detail',
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: wisata['gambar'] != null
                    ? Image.memory(wisata['gambar'] as Uint8List)
                    : Image.asset('images/pemandangan.jpg'),
              ),
              const SizedBox(height: 16),

              // Info
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.asset('images/w.png', width: 20, height: 20),
                          const SizedBox(width: 6),
                          Text(
                            wisata['kategori'] ?? 'Kategori',
                            style: const TextStyle(fontSize: 14, color: Colors.black87),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Image.asset('images/lokasi.png', width: 20, height: 20),
                          const SizedBox(width: 6),
                          Text(
                            wisata['lokasi'] ?? 'Lokasi',
                            style: const TextStyle(fontSize: 14, color: Colors.black87),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Image.asset('images/ticket.png', width: 28, height: 28),
                      const SizedBox(width: 6),
                      Text(
                        wisata['harga'] ?? '0',
                        style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Deskripsi
              Text(
                wisata['deskripsi'] ?? 'Tidak ada deskripsi.',
                textAlign: TextAlign.justify,
                style: const TextStyle(fontSize: 14, color: Colors.black87),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

