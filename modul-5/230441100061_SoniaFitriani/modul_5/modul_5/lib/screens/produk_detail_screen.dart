import 'package:flutter/material.dart';
import '../models/produk_model.dart';

class ProdukDetailScreen extends StatelessWidget {
  final Produk produk;

  const ProdukDetailScreen({Key? key, required this.produk}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(produk.namaProduk),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nama Produk: ${produk.namaProduk}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('Kategori: ${produk.kategori}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            Text('Harga: Rp ${produk.harga}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            
          ],
        ),
      ),
    );
  }
}
