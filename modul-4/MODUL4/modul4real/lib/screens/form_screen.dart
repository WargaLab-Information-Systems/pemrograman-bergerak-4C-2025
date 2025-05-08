import 'package:flutter/material.dart';
import '../model/barang.dart';
import '../services/barang_service.dart';

class FormScreen extends StatefulWidget {
  final Barang? barang;
  const FormScreen({super.key, this.barang});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController namaController;
  late TextEditingController hargaController;
  late TextEditingController stokController;

  @override
  void initState() {
    super.initState();
    namaController = TextEditingController(text: widget.barang?.namaBarang ?? '');
    hargaController = TextEditingController(text: widget.barang?.harga ?? '');
    stokController = TextEditingController(text: widget.barang?.stok ?? '');
  }

  void saveData() async {
    if (_formKey.currentState!.validate()) {
      Barang newBarang = Barang(
        id: widget.barang?.id,
        namaBarang: namaController.text,
        harga: hargaController.text,
        stok: stokController.text,
      );

      if (widget.barang == null) {
        await BarangService.addBarang(newBarang);
      } else {
        await BarangService.updateBarang(newBarang);
      }

      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    namaController.dispose();
    hargaController.dispose();
    stokController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.barang == null ? 'Tambah Barang' : 'Edit Barang')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: namaController,
                decoration: InputDecoration(labelText: 'Nama Barang'),
                validator: (value) => value!.isEmpty ? 'Tidak boleh kosong' : null,
              ),
              TextFormField(
                controller: hargaController,
                decoration: InputDecoration(labelText: 'Harga'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Tidak boleh kosong' : null,
              ),
              TextFormField(
                controller: stokController,
                decoration: InputDecoration(labelText: 'Stok'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Tidak boleh kosong' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: saveData,
                child: Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
