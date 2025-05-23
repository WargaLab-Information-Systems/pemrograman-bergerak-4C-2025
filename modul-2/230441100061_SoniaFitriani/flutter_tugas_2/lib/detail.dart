import 'package:flutter/material.dart';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart'; // Untuk kIsWeb
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';


class DetailPage extends StatelessWidget {
  final String heroTag;
  final Map<String, dynamic> wisata;

  const DetailPage({super.key, required this.heroTag, required this.wisata});

  @override
  Widget build(BuildContext context) {
    final String nama = wisata['nama'] ?? 'Nama tidak tersedia';
    final String lokasi = wisata['lokasi'] ?? 'Lokasi tidak tersedia';
    final String jenis = wisata['jenis'] ?? 'Jenis tidak tersedia';
    final String harga = wisata['harga'] ?? '';
    final String deskripsi = wisata['deskripsi'] ?? 'Deskripsi tidak tersedia';
    final String gambar = wisata['gambar'] ?? '';

    final formatDecimal = NumberFormat.currency(locale: 'id_ID', symbol: '', decimalDigits: 2);
    final String hargaFormatted = harga.isNotEmpty ? formatDecimal.format(double.tryParse(harga) ?? 0) : '0,00';

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          nama,
          style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        children: [
          Hero(tag: heroTag, child: _buildImageWidget(gambar)),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nama,
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
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
                                                       const Icon(Icons.nature_people_outlined, size: 16),
                            const SizedBox(width: 6),
                            Text(jenis, style: GoogleFonts.poppins(fontSize: 14)),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const Icon(Icons.location_on_outlined, size: 16),
                            const SizedBox(width: 6),
                            Text(lokasi, style: GoogleFonts.poppins(fontSize: 14)),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.confirmation_num_outlined, size: 16),
                        const SizedBox(width: 6),
                        Text(
                          hargaFormatted,
                          style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  "Deskripsi",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  deskripsi,
                  style: GoogleFonts.poppins(fontSize: 14, height: 1.5),
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageWidget(String gambar) {
  Widget imageWidget;

  if (gambar.startsWith('http')) {
    imageWidget = CachedNetworkImage(
      imageUrl: gambar,
      height: 250,
      width: double.infinity,
      fit: BoxFit.cover,
      placeholder: (context, url) => Container(
        height: 250,
        color: Colors.grey[300],
        child: const Center(child: CircularProgressIndicator()),
      ),
      errorWidget: (context, url, error) => _buildErrorImage(),
    );
  } else if (gambar.startsWith('assets/')) {
    imageWidget = Image.asset(
      gambar,
      height: 250,
      width: double.infinity,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) => _buildErrorImage(),
    );
  } else if (!kIsWeb && File(gambar).existsSync()) {
    imageWidget = Image.file(
      File(gambar),
      height: 250,
      width: double.infinity,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) => _buildErrorImage(),
    );
  } else if (kIsWeb && gambar.startsWith('blob:')) {
    imageWidget = Image.network(
      gambar,
      height: 250,
      width: double.infinity,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) => _buildErrorImage(),
    );
  } else {
    imageWidget = _buildErrorImage();
  }

  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: imageWidget,
    ),
  );
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
          SizedBox(height: 8),
          Text('Gambar tidak tersedia', style: TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
