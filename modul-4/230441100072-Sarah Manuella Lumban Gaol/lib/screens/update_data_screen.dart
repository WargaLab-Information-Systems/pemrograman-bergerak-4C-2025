import 'package:flutter/material.dart';
import '../models/permintaan_magang.dart';
import '../services/firebase_service.dart';

class UpdateDataScreen extends StatefulWidget {
  final PermintaanMagang data;

  UpdateDataScreen({required this.data});

  @override
  _UpdateDataScreenState createState() => _UpdateDataScreenState();
}

class _UpdateDataScreenState extends State<UpdateDataScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firebaseService = FirebaseService();

  late TextEditingController _namaController;
  late TextEditingController _emailController;
  late TextEditingController _nomorHpController;
  late TextEditingController _nimController;
  late TextEditingController _statusController;
  late TextEditingController _perusahaanController;

  @override
  void initState() {
    super.initState();
    _namaController = TextEditingController(text: widget.data.nama);
    _emailController = TextEditingController(text: widget.data.email);
    _nomorHpController = TextEditingController(text: widget.data.nomorHp);
    _nimController = TextEditingController(text: widget.data.nim);
    _statusController = TextEditingController(text: widget.data.statusPengajuan);
    _perusahaanController = TextEditingController(text: widget.data.perusahaanTujuan);
  }

  void _submitUpdate() async {
    if (_formKey.currentState!.validate()) {
      final updatedData = PermintaanMagang(
        id: widget.data.id,
        nama: _namaController.text,
        email: _emailController.text,
        nomorHp: _nomorHpController.text,
        nim: _nimController.text,
        statusPengajuan: _statusController.text,
        perusahaanTujuan: _perusahaanController.text,
      );
      await _firebaseService.updateData(widget.data.id, updatedData);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Data"), backgroundColor: Color(0xFF90CAF9)),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(controller: _namaController, decoration: InputDecoration(labelText: "Nama"), validator: (v) => v!.isEmpty ? "Wajib diisi" : null),
              TextFormField(controller: _emailController, decoration: InputDecoration(labelText: "Email")),
              TextFormField(controller: _nomorHpController, decoration: InputDecoration(labelText: "No HP")),
              TextFormField(controller: _nimController, decoration: InputDecoration(labelText: "NIM")),
              TextFormField(controller: _statusController, decoration: InputDecoration(labelText: "Status Pengajuan")),
              TextFormField(controller: _perusahaanController, decoration: InputDecoration(labelText: "Perusahaan Tujuan")),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF42A5F5)),
                onPressed: _submitUpdate,
                child: Text("Update", style: TextStyle(color: Colors.white)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
