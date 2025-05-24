import 'package:flutter/material.dart';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailPage extends StatelessWidget {
  final String heroTag;
  final Map<String, dynamic> wisata;

  const DetailPage({super.key, required this.heroTag, required this.wisata});

  @override
  Widget build(BuildContext context) {
    final String nama = wisata['nama'] ?? 'Nama tidak tersedia';
    final String lokasi = wisata['lokasi'] ?? 'Lokasi tidak tersedia';
    final String jenis = wisata['jenis'] ?? 'Jenis tidak tersedia';
    final String harga = wisata['harga'] ?? 'Harga tidak tersedia';
    final String deskripsi = wisata['deskripsi'] ?? 'Deskripsi tidak tersedia';
    final String gambar = wisata['gambar'] ?? '';

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          nama,
          style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 206, 206, 205),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Hero(
            tag: heroTag,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: _buildImageWidget(gambar),
            ),
          ),
          const SizedBox(height: 15),
          Text(
            nama,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color.fromARGB(255, 255, 255, 255),
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(Icons.category, size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        jenis,
                        style: GoogleFonts.poppins(fontSize: 14),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        lokasi,
                        style: GoogleFonts.poppins(fontSize: 14),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.confirmation_number, size: 18),
                    const SizedBox(width: 8),
                    const Spacer(),
                    Text(
                      'Rp $harga',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text(
            deskripsi,
            textAlign: TextAlign.justify,
            style: GoogleFonts.poppins(fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildImageWidget(String gambar) {
    if (gambar.startsWith('http') || gambar.startsWith('https')) {
      return CachedNetworkImage(
        imageUrl: gambar,
        height: 250,
        width: double.infinity,
        fit: BoxFit.cover,
        placeholder:
            (context, url) => Container(
              height: 250,
              color: Colors.grey[300],
              child: const Center(child: CircularProgressIndicator()),
            ),
        errorWidget: (context, url, error) => _buildErrorImage(),
      );
    } else if (gambar.startsWith('assets/')) {
      return Image.asset(
        gambar,
        height: 250,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _buildErrorImage(),
      );
    } else if (!kIsWeb && File(gambar).existsSync()) {
      return Image.file(
        File(gambar),
        height: 250,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _buildErrorImage(),
      );
    } else if (kIsWeb && gambar.startsWith('blob:')) {
      return Image.network(
        gambar,
        height: 250,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _buildErrorImage(),
      );
    } else {
      return _buildErrorImage();
    }
  }

  Widget _buildErrorImage() {
    return Container(
      height: 250,
      width: double.infinity,
      color: Colors.grey[300],
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error, color: Colors.red, size: 40),
          Text('Tidak Ada Gambar.', style: TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
