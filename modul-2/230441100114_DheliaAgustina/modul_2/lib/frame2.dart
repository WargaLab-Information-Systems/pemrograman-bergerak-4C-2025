
import 'package:flutter/material.dart';
import 'dart:typed_data';

class DetailPage extends StatelessWidget {
  final String nama;
  final String deskripsi;
  final String lokasi;  
  final String kategori;
  final Uint8List? gambar;

  const DetailPage({
    super.key,
    required this.nama,
    required this.deskripsi,
    required this.lokasi,
    required this.kategori,
    this.gambar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // tbl kembali
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      nama,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Gambar utama
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: gambar != null
                    ? Image.memory(
                        gambar!,
                        height: 180,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        "image/home.jpg",
                        height: 180,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
              ),
              const SizedBox(height: 12),

              // Info kategori, lokasi, dan harga
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const ImageIcon(
                            AssetImage("image/wa.png"),
                             size: 16,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            kategori, // ambil dari parameter
                            style: const TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                        ],
                      ),

                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const ImageIcon(
                            AssetImage("image/pin.png"),
                            size: 16,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            lokasi,
                            style: const TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: const [
                      ImageIcon(AssetImage("image/t.png"), size: 30, color: Colors.grey),
                      SizedBox(width: 4),
                      Text(
                        "30.000,00",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Deskripsi
              Text(
                deskripsi,
                style: const TextStyle(fontSize: 14, height: 1.5),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
    );
  }
}












