import 'dart:io';
import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final Map<String, dynamic> data;

  const DetailPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 24,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          data['nama'],
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar utama (dari File)
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: _buildImage(data['image']),
            ),

            const SizedBox(height: 12),

            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Kiri: jenis & lokasi
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            data['image'],
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            data['jenis'],
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Image.asset(
                            'image/location.png',
                            width: 16,
                            height: 16,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            data['lokasi'],
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  // Kanan: harga
                  Row(
                    children: [
                      const Icon(Icons.confirmation_num_outlined,
                          size: 24, color: Colors.black87),
                      const SizedBox(width: 8),
                      Text(
                        data['harga'],
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Deskripsi
            Text(
              data['deskripsi'],
              style: const TextStyle(color: Color.fromARGB(255, 12, 12, 12)),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(String imagePath) {
  if (imagePath.startsWith('/')) {
    // anggap ini file lokal
    return Image.file(File(imagePath), fit: BoxFit.cover);
  } else {
    // anggap ini asset
    return Image.asset(imagePath, fit: BoxFit.cover);
  }
}

}
