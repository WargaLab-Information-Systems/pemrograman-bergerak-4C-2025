import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:uuid/uuid.dart';
import '../widgets/input_field.dart';
import '../widgets/kategori_dropdown.dart';

class TambahPage extends StatefulWidget {
  const TambahPage({super.key});

  @override
  State<TambahPage> createState() => _TambahPageState();
}

class _TambahPageState extends State<TambahPage> {
  final _judulController = TextEditingController();
  final _deadlineController = TextEditingController();
  String kategori = 'Kuliah';

  final ref = FirebaseDatabase.instance.ref().child('tugas');

  void _simpanKeFirebase() {
    final id = const Uuid().v4();
    ref.child(id).set({
      'judul': _judulController.text,
      'kategori': kategori,
      'deadline': _deadlineController.text,
      'selesai': false,
    }).then((_) => Navigator.pop(context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tambah Data")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            InputField(
              controller: _judulController,
              labelText: "Judul Tugas",
            ),
            const SizedBox(height: 10),
            KategoriDropdown(
              value: kategori,
              onChanged: (val) => setState(() => kategori = val),
            ),
            const SizedBox(height: 10),
            InputField(
              controller: _deadlineController,
              labelText: "Deadline",
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _simpanKeFirebase,
              child: const Text("Simpan"),
            ),
          ],
        ),
      ),
    );
  }
}
