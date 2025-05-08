import 'dart:typed_data';
import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final String nama;
  final String lokasi;
  final String deskripsi;
  final String harga;
  final String jenis;
  final Uint8List? gambar;

  const DetailPage({
    super.key,
    required this.nama,
    required this.lokasi,
    required this.deskripsi,
    required this.harga,
    required this.jenis,
    required this.gambar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(nama),
        foregroundColor: Colors.black,
        backgroundColor: Colors.grey[100],
        elevation: 0,
        leading: const BackButton(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child:
                  gambar != null
                      ? Image.memory(
                        gambar!,
                        width: 353,
                        height: 202,
                        fit: BoxFit.cover,
                      )
                      : Image.asset(
                        'assets/1.jpg',
                        width: 353,
                        height: 202,
                        fit: BoxFit.cover,
                      ),
            ),
            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.category_outlined,
                          size: 18,
                          color: Colors.grey[800],
                        ),
                        const SizedBox(width: 6),
                        Text(
                          jenis,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.place_outlined,
                          size: 18,
                          color: Colors.grey[800],
                        ),
                        const SizedBox(width: 6),
                        Text(
                          lokasi,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                Row(
                  children: [
                    Icon(
                      Icons.confirmation_num_outlined,
                      size: 16,
                      color: Colors.grey[700],
                    ),
                    const SizedBox(width: 4),
                    Text(
                      harga,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 16),

            Text(
              deskripsi,
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 16,
                height: 1.5,
                color: Colors.grey[800],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
