import 'package:flutter/material.dart';
import 'package:alat_musik_tradisional/models/alat_musik.dart';
import 'package:alat_musik_tradisional/services/alat_musik_service.dart';

class AlatMusikFormScreen extends StatefulWidget {
  final AlatMusik? alatMusik;

  AlatMusikFormScreen({this.alatMusik});

  @override
  _AlatMusikFormScreenState createState() => _AlatMusikFormScreenState();
}

class _AlatMusikFormScreenState extends State<AlatMusikFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController namaController = TextEditingController();
  final TextEditingController asalController = TextEditingController();
  final TextEditingController jenisController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.alatMusik != null) {
      namaController.text = widget.alatMusik!.namaAlat;
      asalController.text = widget.alatMusik!.asalDaerah;
      jenisController.text = widget.alatMusik!.jenis;
    }
  }

  @override
  void dispose() {
    namaController.dispose();
    asalController.dispose();
    jenisController.dispose();
    super.dispose();
  }

  Future<void> submitForm() async {
    if (_formKey.currentState!.validate()) {
      final nama = namaController.text;
      final asal = asalController.text;
      final jenis = jenisController.text;

      if (widget.alatMusik == null) {
        await AlatMusikService().addAlatMusik(nama, asal, jenis);
      } else {
        await AlatMusikService().updateAlatMusik(widget.alatMusik!.id, nama, asal, jenis);
      }

      Navigator.pop(context);
    }
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Colors.blue.shade800),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blue),
        borderRadius: BorderRadius.circular(8),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          widget.alatMusik == null ? 'Tambah Alat Musik' : 'Edit Alat Musik',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: namaController,
                decoration: _inputDecoration('Nama Alat'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama alat tidak boleh kosong';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: asalController,
                decoration: _inputDecoration('Asal Daerah'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Asal daerah tidak boleh kosong';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: jenisController,
                decoration: _inputDecoration('Jenis'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Jenis tidak boleh kosong';
                  }
                  return null;
                },
              ),
              SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Text(
                    widget.alatMusik == null ? 'Tambah' : 'Simpan',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
