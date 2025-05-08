import 'package:flutter/material.dart';
import '../models/permintaan_magang.dart';
import '../services/firebase_service.dart';

class TambahDataScreen extends StatefulWidget {
  @override
  _TambahDataScreenState createState() => _TambahDataScreenState();
}

class _TambahDataScreenState extends State<TambahDataScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firebaseService = FirebaseService();

  final _namaController = TextEditingController();
  final _emailController = TextEditingController();
  final _nomorHpController = TextEditingController();
  final _nimController = TextEditingController();
  final _statusController = TextEditingController();
  final _perusahaanController = TextEditingController();

  void _submitData() {
    if (_formKey.currentState!.validate()) {
      final data = PermintaanMagang(
        id: '',
        nama: _namaController.text,
        email: _emailController.text,
        nomorHp: _nomorHpController.text,
        nim: _nimController.text,
        statusPengajuan: _statusController.text,
        perusahaanTujuan: _perusahaanController.text,
      );
      _firebaseService.tambahData(data).then((_) {
        Navigator.pop(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF90CAF9),
        title: Text("Tambah Data"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _namaController,
                decoration: InputDecoration(labelText: "Nama"),
                validator: (v) => v!.isEmpty ? "Wajib diisi" : null,
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: "Email"),
              ),
              TextFormField(
                controller: _nomorHpController,
                decoration: InputDecoration(labelText: "No HP"),
              ),
              TextFormField(
                controller: _nimController,
                decoration: InputDecoration(labelText: "NIM"),
              ),
              TextFormField(
                controller: _statusController,
                decoration: InputDecoration(labelText: "Status Pengajuan"),
              ),
              TextFormField(
                controller: _perusahaanController,
                decoration: InputDecoration(labelText: "Perusahaan Tujuan"),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF42A5F5),
                ),
                onPressed: _submitData,
                child: Text("Simpan", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
