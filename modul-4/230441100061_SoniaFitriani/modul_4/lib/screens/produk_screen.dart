import 'package:flutter/material.dart';
import '../models/produk_model.dart';
import '../services/produk_service.dart';
import 'produk_detail_screen.dart';


class ProdukScreen extends StatefulWidget {
  @override
  _ProdukScreenState createState() => _ProdukScreenState();
}

class _ProdukScreenState extends State<ProdukScreen> {
  final ProdukService _produkService = ProdukService();
  List<Produk> _produkList = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProduk();
  }

  Future<void> _loadProduk() async {
    setState(() => _isLoading = true);
    _produkList = await _produkService.fetchProduk();
    setState(() => _isLoading = false);
  }

  void _showForm({Produk? produk}) {
    final TextEditingController namaController = TextEditingController(text: produk?.namaProduk ?? '');
    final TextEditingController kategoriController = TextEditingController(text: produk?.kategori ?? '');
    final TextEditingController hargaController = TextEditingController(text: produk?.harga.toString() ?? '');

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(produk == null ? 'Tambah Produk' : 'Edit Produk'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: namaController, decoration: InputDecoration(labelText: 'Nama Produk')),
            TextField(controller: kategoriController, decoration: InputDecoration(labelText: 'Kategori')),
            TextField(controller: hargaController, decoration: InputDecoration(labelText: 'Harga'), keyboardType: TextInputType.number),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () async {
              final newProduk = Produk(
                id: produk?.id ?? '',
                namaProduk: namaController.text,
                kategori: kategoriController.text,
                harga: int.tryParse(hargaController.text) ?? 0,
              );

              if (produk == null) {
                await _produkService.addProduk(newProduk);
              } else {
                await _produkService.updateProduk(newProduk);
              }

              Navigator.pop(context);
              _loadProduk();
            },
            child: Text('Simpan'),
          ),
        ],
      ),
    );
  }

  void _deleteProduk(String id) async {
    await _produkService.deleteProduk(id);
    _loadProduk();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Data Produk')),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _produkList.length,
              itemBuilder: (_, i) {
                final p = _produkList[i];
                return ListTile(
                  title: Text(p.namaProduk),
                  subtitle: Text('${p.kategori} - Rp${p.harga}'),
                  onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ProdukDetailScreen(produk: p),
                        ),
                      );
                    },
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(icon: Icon(Icons.edit), onPressed: () => _showForm(produk: p)),
                      IconButton(icon: Icon(Icons.delete), onPressed: () => _deleteProduk(p.id)),
                    ],
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showForm(),
        child: Icon(Icons.add),
      ),
    );
  }
}
