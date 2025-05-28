import 'package:flutter/material.dart';
import 'package:toko_kain/model_barang.dart';
import 'package:uuid/uuid.dart';

class AddEditBarangPage extends StatefulWidget {
  final Barang? barang;
  final void Function(Barang) onSave;

  const AddEditBarangPage({super.key, this.barang, required this.onSave});

  @override
  State<AddEditBarangPage> createState() => _AddEditBarangPageState();
}

class _AddEditBarangPageState extends State<AddEditBarangPage> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _warnaController = TextEditingController();
  final _panjangController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.barang != null) {
      _namaController.text = widget.barang!.nama;
      _warnaController.text = widget.barang!.warna;
      _panjangController.text = widget.barang!.panjang.toString();
    }
  }

  void simpanData() {
    if (_formKey.currentState!.validate()) {
      final barang = Barang(
        id: widget.barang?.id ?? const Uuid().v4(),
        nama: _namaController.text,
        warna: _warnaController.text,
        panjang: double.tryParse(_panjangController.text) ?? 0.0,
      );
      widget.onSave(barang);
      Navigator.pop(context);
    }
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.pink[50],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.pink.shade200),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.pink.shade300, width: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF1F3),
      appBar: AppBar(
        title: Text(widget.barang == null ? "Tambah Kain" : "Edit Kain"),
        backgroundColor: Colors.pink[200],
        foregroundColor: Colors.white,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _namaController,
                decoration: _inputDecoration("Nama Kain"),
                validator: (value) => value!.isEmpty ? "Wajib diisi" : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _warnaController,
                decoration: _inputDecoration("Warna Kain"),
                validator: (value) => value!.isEmpty ? "Wajib diisi" : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _panjangController,
                keyboardType: TextInputType.number,
                decoration: _inputDecoration("Panjang Tersedia (meter)"),
                validator: (value) {
                  if (value == null || value.isEmpty) return "Wajib diisi";
                  final parsed = double.tryParse(value);
                  if (parsed == null) return "Harus berupa angka";
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink[300],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  textStyle: const TextStyle(fontSize: 16),
                ),
                onPressed: simpanData,
                child: const Text("Simpan Data"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
