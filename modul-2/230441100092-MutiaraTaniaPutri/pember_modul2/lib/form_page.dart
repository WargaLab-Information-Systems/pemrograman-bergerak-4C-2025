import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: FormPage(),
  ));
}


class FormPage extends StatefulWidget {
  const FormPage({Key? key}) : super(key: key);

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  File? _selectedImage;
  final picker = ImagePicker();

  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _lokasiController = TextEditingController();
  final TextEditingController _hargaController = TextEditingController();
  final TextEditingController _deskripsiController = TextEditingController();
  String? _selectedJenis;

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path); // convert XFile to File
      });
    }
  }


  void _simpanData() {
    if (_namaController.text.isEmpty ||
        _lokasiController.text.isEmpty ||
        _hargaController.text.isEmpty ||
        _deskripsiController.text.isEmpty ||
        _selectedJenis == null ||
        _selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Semua data harus diisi!')),
      );
      return;
    }

    final Map<String, dynamic> newData = {
      'nama': _namaController.text,
      'lokasi': _lokasiController.text,
      'harga': _hargaController.text,
      'deskripsi': _deskripsiController.text,
      'jenis': _selectedJenis,
      'image': _selectedImage!.path, 
    };

    Navigator.pop(context, newData);
  }

  void _resetForm() {
    setState(() {
      _namaController.clear();
      _lokasiController.clear();
      _hargaController.clear();
      _deskripsiController.clear();
      _selectedJenis = null;
      _selectedImage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Tambah Wisata',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Upload Gambar
            Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12),
              ),
              child: _selectedImage != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.file(
                        _selectedImage!,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Center(
                      child: Image.asset(
                        'image/upimg.png',
                        width: 80,
                        height: 80,
                        fit: BoxFit.contain,
                      ),
                    ),
            ),
            const SizedBox(height: 10),

            // Tombol Upload
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _pickImage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[800],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Upload Image',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Form Fields
            _CustomTextField(label: 'Nama Wisata', hint: 'Masukkan Nama Wisata', controller: _namaController),
            _CustomTextField(label: 'Lokasi Wisata', hint: 'Masukkan Lokasi Wisata', controller: _lokasiController),

            // Dropdown Jenis Wisata
            _CustomDropdown(
              selectedValue: _selectedJenis,
              onChanged: (value) {
                setState(() {
                  _selectedJenis = value;
                });
              },
            ),

            _CustomTextField(label: 'Harga Tiket', hint: 'Masukkan Harga Tiket', controller: _hargaController),
            _CustomTextField(
              label: 'Deskripsi',
              hint: 'Masukkan Deskripsi',
              controller: _deskripsiController,
              maxLines: 3,
            ),

            const SizedBox(height: 20),

            // Tombol Simpan
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _simpanData,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[800],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Simpan',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),

            const SizedBox(height: 10),

            // Reset
            Center(
              child: TextButton(
                onPressed: _resetForm,
                child: const Text(
                  'Reset',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// Widget TextField Custom
class _CustomTextField extends StatelessWidget {
  final String label;
  final String hint;
  final int maxLines;
  final TextEditingController controller;

  const _CustomTextField({
    required this.label,
    required this.hint,
    required this.controller,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$label :'),
        const SizedBox(height: 5),
        TextField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}

// Widget Dropdown Custom
class _CustomDropdown extends StatelessWidget {
  final String? selectedValue;
  final Function(String?) onChanged;

  const _CustomDropdown({
    required this.selectedValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Jenis Wisata :'),
        const SizedBox(height: 5),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButtonFormField<String>(
            value: selectedValue,
            decoration: const InputDecoration(
              border: InputBorder.none,
            ),
            hint: const Text('Pilih Jenis Wisata'),
            items: const [
              DropdownMenuItem(value: 'Pantai', child: Text('Pantai')),
              DropdownMenuItem(value: 'Gunung', child: Text('Gunung')),
              DropdownMenuItem(value: 'Taman', child: Text('Taman')),
              DropdownMenuItem(value: 'Museum', child: Text('Museum')),
            ],
            onChanged: onChanged,
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}
