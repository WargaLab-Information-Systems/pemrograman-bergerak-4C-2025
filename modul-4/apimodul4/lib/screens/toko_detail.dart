import 'package:flutter/material.dart';
import '../models/model.dart';
import 'toko_form.dart';

class DoaDetailPage extends StatelessWidget {
  final toko doa;

  const DoaDetailPage({Key? key, required this.doa}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Produk'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DoaForm(
                    doa: doa,
                    onSave: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 4,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doa.namaProduk ?? 'Tanpa Nama Produk',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Kategori: ${doa.kategori ?? "-"}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[700],
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Harga: Rp ${doa.harga ?? "-"}',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24),
            Text(
              'ID Produk',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Card(
              elevation: 2,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                child: Text(doa.id ?? '-'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
