import 'package:flutter/material.dart';
import '../models/aksesoris_models.dart';
import '../service/aksesoris_service.dart';

class FormPage extends StatefulWidget {
  final Aksesoris? aksesoris;
  const FormPage({super.key, this.aksesoris});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController namaController;
  late TextEditingController hargaController;
  late TextEditingController stokController;

  @override
  void initState() {
    super.initState();
    namaController = TextEditingController(text: widget.aksesoris?.nama_aksesoris ?? '');
    hargaController = TextEditingController(text: widget.aksesoris?.harga ?? '');
    stokController = TextEditingController(text: widget.aksesoris?.stok ?? '');
  }

  void simpanData() async {
    if (_formKey.currentState!.validate()) {
      final baru = Aksesoris(
        id_aksesoris: widget.aksesoris?.id_aksesoris ?? '',
        nama_aksesoris: namaController.text,
        harga: hargaController.text,
        stok: stokController.text,
      );

      if (widget.aksesoris == null) {
        await AksesorisService.addAksesoris(baru);
      } else {
        await AksesorisService.updateAksesoris(baru);
      }

      Navigator.pop(context);
    }
  }
// membersihnkn controller untuk menghindari kebocoran memori
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
      appBar: AppBar(
        title: Text(widget.aksesoris == null ? 'Tambah Aksesoris' : 'Edit Aksesoris'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
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
                onPressed: simpanData,
                child: Text('Simpan'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
