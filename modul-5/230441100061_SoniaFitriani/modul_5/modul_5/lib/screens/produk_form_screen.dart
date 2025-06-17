import 'package:flutter/material.dart';
import '../models/produk_model.dart';
import 'package:modul_5/services/produk_service.dart';

class ProdukFormScreen extends StatefulWidget {
  final Produk? produk;

  const ProdukFormScreen({super.key, this.produk});

  @override
  State<ProdukFormScreen> createState() => _ProdukFormScreenState();
}

class _ProdukFormScreenState extends State<ProdukFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _kategoriController = TextEditingController();
  final _hargaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.produk != null) {
      _namaController.text = widget.produk!.namaProduk;
      _kategoriController.text = widget.produk!.kategori;
      _hargaController.text = widget.produk!.harga.toString();
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final nama = _namaController.text.trim();
    final kategori = _kategoriController.text.trim();
    final harga = int.tryParse(_hargaController.text.trim()) ?? -1;

    if (harga < 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Harga harus berupa angka positif')),
      );
      return;
    }

    final produkBaru = Produk(
      idProduk: widget.produk?.idProduk ?? 0,
      namaProduk: nama,
      kategori: kategori,
      harga: harga,
    );

    try {
      if (widget.produk == null) {
        final newId = await ProdukService.tambahProduk(produkBaru);
        print('Produk berhasil ditambahkan dengan ID: $newId');
      } else {
        await ProdukService.perbaruiProduk(produkBaru);
        print('Produk berhasil diperbarui');
      }

      Navigator.pop(context, true);
    } catch (e) {
      print('Error detail: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Gagal menyimpan data: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.produk == null ? 'Tambah Produk' : 'Edit Produk'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _namaController,
                decoration: const InputDecoration(
                  labelText: 'Nama Produk',
                  hintText: 'Masukkan nama produk',
                ),
                textInputAction: TextInputAction.next,
                validator:
                    (value) =>
                        value == null || value.isEmpty ? 'Wajib diisi' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _kategoriController,
                decoration: const InputDecoration(
                  labelText: 'Kategori',
                  hintText: 'Masukkan kategori produk',
                ),
                textInputAction: TextInputAction.next,
                validator:
                    (value) =>
                        value == null || value.isEmpty ? 'Wajib diisi' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _hargaController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Harga',
                  hintText: 'Contoh: 10000',
                ),
                textInputAction: TextInputAction.done,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Wajib diisi';
                  final parsed = int.tryParse(value);
                  if (parsed == null || parsed < 0) {
                    return 'Harga harus berupa angka positif';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submit,
                child: Text(widget.produk == null ? 'Simpan' : 'Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
