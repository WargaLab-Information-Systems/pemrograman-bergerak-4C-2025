import 'package:flutter/material.dart';
import '../models/produk_model.dart';

class ProdukDetailScreen extends StatelessWidget {
  final Produk produk;

  ProdukDetailScreen({required this.produk});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detail Produk')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nama Produk:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(produk.namaProduk),
            SizedBox(height: 16),
            Text('Kategori:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(produk.kategori),
            SizedBox(height: 16),
            Text('Harga:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('Rp${produk.harga}'),
          ],
        ),
      ),
    );
  }
}
