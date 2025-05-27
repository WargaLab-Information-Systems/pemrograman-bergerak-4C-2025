import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

import 'models/aksesoris.dart';

class FormPage extends StatefulWidget {
  final Aksesoris? data;

  const FormPage({super.key, this.data});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController namaController;
  late TextEditingController stokController;
  late TextEditingController hargaController;
  File? _gambar;

  @override
  void initState() {
    super.initState();
    namaController = TextEditingController(text: widget.data?.nama ?? '');
    stokController = TextEditingController(
        text: widget.data != null ? widget.data!.stok.toString() : '');
    hargaController = TextEditingController(
        text: widget.data != null ? widget.data!.harga.toString() : '');
    _gambar = widget.data?.gambar;
  }

  Future<void> _pilihGambar(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source, imageQuality: 75);

    if (pickedFile != null) {
      final imageTemp = File(pickedFile.path);

      if (source == ImageSource.camera) {
        await _simpanKeGaleri(imageTemp);
      }

      setState(() {
        _gambar = imageTemp;
      });
    }
  }

  Future<void> _simpanKeGaleri(File file) async {
    await Permission.storage.request();
    await Permission.photos.request();

    final bytes = await file.readAsBytes();
    final result = await ImageGallerySaver.saveImage(bytes, quality: 80);
    if (result['isSuccess'] == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gambar berhasil disimpan ke galeri')),
      );
    }
  }

  void _simpanData() {
    if (_formKey.currentState!.validate()) {
      final newItem = Aksesoris(
        nama: namaController.text,
        stok: int.parse(stokController.text),
        harga: int.parse(hargaController.text),
        gambar: _gambar,
      );
      Navigator.pop(context, newItem);
    }
  }

  @override
  void dispose() {
    namaController.dispose();
    stokController.dispose();
    hargaController.dispose();
    super.dispose();
  }

  Widget _previewGambar() {
    return _gambar != null
        ? Image.file(_gambar!, height: 150, fit: BoxFit.cover)
        : const Text('Belum ada gambar');
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.data != null;
    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Edit Aksesoris' : 'Tambah Aksesoris'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: namaController,
                decoration: const InputDecoration(labelText: 'Nama Aksesoris'),
                validator: (value) =>
                    value!.isEmpty ? 'Masukkan nama aksesoris' : null,
              ),
              TextFormField(
                controller: stokController,
                decoration: const InputDecoration(labelText: 'Stok'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Masukkan stok' : null,
              ),
              TextFormField(
                controller: hargaController,
                decoration: const InputDecoration(labelText: 'Harga'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Masukkan harga' : null,
              ),
              const SizedBox(height: 16),
              Center(child: _previewGambar()),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    icon: const Icon(Icons.photo_library),
                    label: const Text('Galeri'),
                    onPressed: () => _pilihGambar(ImageSource.gallery),
                  ),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.camera_alt),
                    label: const Text('Kamera'),
                    onPressed: () => _pilihGambar(ImageSource.camera),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _simpanData,
                child: Text(isEdit ? 'Simpan Perubahan' : 'Tambah Data'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
