import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;

class DetailScreen extends StatelessWidget {
  final Map<String, dynamic> wisata;
  
  const DetailScreen({
    super.key, 
    required this.wisata,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          wisata['nama'] ?? "Detail Wisata",
          style: TextStyle(
            fontSize: 18, 
            fontWeight: FontWeight.bold,
            color: Colors.black
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar wisata (full width)
            SizedBox(
              width: double.infinity,
              height: 240,
              child: _buildWisataImage(),
            ),
            
            // Informasi wisata
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Jenis dan Harga
                  Row(
                    children: [
                      // Jenis wisata dengan icon
                      Expanded(
                        child: Row(
                          children: [
                            Icon(Icons.category, color: Colors.grey, size: 20),
                            SizedBox(width: 8),
                            Text(
                              "Wisata ${wisata['jenis']}",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      // Harga dengan format
                      Row(
                        children: [
                          Icon(Icons.monetization_on, color: Colors.grey, size: 20),
                          SizedBox(width: 8),
                          Text(
                            _formatPrice(wisata['harga']),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  
                  SizedBox(height: 8),
                  
                  // Lokasi
                  Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.grey, size: 20),
                      SizedBox(width: 8),
                      Text(
                        wisata['lokasi'],
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: 16),
                  
                  // Deskripsi
                  Text(
                    wisata['deskripsi'],
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.5,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  
                 
                  
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  // Helper method untuk menampilkan gambar dengan benar
  Widget _buildWisataImage() {
    if (wisata['isCustomImage'] == true) {
      if (kIsWeb) {
        // Untuk web, gunakan Image.memory jika ada data gambar
        if (wisata['webImage'] != null) {
          return Image.memory(
            wisata['webImage'],
            fit: BoxFit.cover,
          );
        }
      } else {
        // Untuk mobile, gunakan Image.file
        return Image.file(
          File(wisata['imagePath']),
          fit: BoxFit.cover,
        );
      }
    }
    
    // Default atau fallback ke asset image
    return Image.asset(
      wisata['imagePath'],
      fit: BoxFit.cover,
    );
  }
  
  // Helper method untuk format harga
  String _formatPrice(String price) {
    if (price.isEmpty) return "0";
    
    // Konversi ke integer
    int priceInt = int.tryParse(price) ?? 0;
    
    // Format dengan pemisah ribuan
    String formatted = priceInt.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    );
    
    return "${formatted},00";
  }
}

