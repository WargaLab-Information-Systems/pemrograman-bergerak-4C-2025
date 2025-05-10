import 'package:flutter/material.dart';
import 'package:flutter_api_modul4/models/katalog_buku.dart';
import 'package:flutter_api_modul4/services/KatalogBuku_service.dart';

class AddBookScreen extends StatefulWidget {
  final KatalogBuku? book; // Null jika tambah, isi jika edit

  const AddBookScreen({super.key, this.book});

  @override
  State<AddBookScreen> createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  final _formKey = GlobalKey<FormState>();

  String? _kodeBuku;
  String? _judul;
  String? _penerbit;

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(fontSize: 16),
      filled: true,
      fillColor: Colors.pink[100],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final newBook = KatalogBuku(
        docId: widget.book?.docId ?? '',
        kode_buku: _kodeBuku!,
        judul: _judul!,
        penerbit: _penerbit!,
      );

      if (widget.book == null) {
        await KatalogbukuService.createKatalogBuku(newBook);
      } else {
        await KatalogbukuService.updateKatalogBuku(newBook);
      }

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.book != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditing ? 'Edit Buku' : 'Tambah Buku',
          style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: widget.book?.kode_buku,
                decoration: _inputDecoration("Kode Buku"),
                validator: (value) => value!.isEmpty ? 'Wajib diisi' : null,
                onSaved: (value) => _kodeBuku = value,
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: widget.book?.judul,
                decoration: _inputDecoration("Judul"),
                validator: (value) => value!.isEmpty ? 'Wajib diisi' : null,
                onSaved: (value) => _judul = value,
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: widget.book?.penerbit,
                decoration: _inputDecoration("Penerbit"),
                validator: (value) => value!.isEmpty ? 'Wajib diisi' : null,
                onSaved: (value) => _penerbit = value,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text(
                  isEditing ? 'Update' : 'Simpan',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink[400],
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
