import 'package:flutter/material.dart';
import 'package:flutter_toko_kain/model_barang.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.barang == null ? "Tambah Kain" : "Edit Kain"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _namaController,
                decoration: const InputDecoration(labelText: "Nama Kain"),
                validator: (value) => value!.isEmpty ? "Wajib diisi" : null,
              ),
              TextFormField(
                controller: _warnaController,
                decoration: const InputDecoration(labelText: "Warna Kain"),
                validator: (value) => value!.isEmpty ? "Wajib diisi" : null,
              ),
              TextFormField(
                controller: _panjangController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Panjang Tersedia (meter)",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return "Wajib diisi";
                  final parsed = double.tryParse(value);
                  if (parsed == null) return "Harus berupa angka";
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: simpanData,
                child: const Text("Simpan"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
