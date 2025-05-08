import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPage();
}

class _FormPage extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();
  Uint8List? _imageBytes;
  final picker = ImagePicker();

  String? _nama;
  String? _lokasi;
  String? _harga;
  String? _deskripsi;
  String? _jenisWisata;

  final List<String> jenisWisataList = [
    'Wisata Alam',
    'Wisata Sejarah',
    'Wisata Keluarga',
    'Wisata Edukasi',
    'Wisata Kuliner',
  ];

  Future<void> _getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      setState(() {
        _imageBytes = bytes;
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate() && _imageBytes != null) {
      _formKey.currentState!.save();

      Navigator.pop(context, {
        'nama': _nama,
        'lokasi': _lokasi,
        'harga': _harga,
        'deskripsi': _deskripsi,
        'jenis': _jenisWisata,
        'gambar': _imageBytes,
      });

      _formKey.currentState!.reset();
      setState(() {
        _imageBytes = null;
        _jenisWisata = null;
      });
    } else if (_imageBytes == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Gambar wajib diunggah."),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  void _resetForm() {
    _formKey.currentState!.reset();
    setState(() {
      _imageBytes = null;
      _jenisWisata = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          'Tambah Wisata',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.grey[100],
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Container(
                height: 202,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 225, 225, 225),
                  borderRadius: BorderRadius.circular(8),
                ),
                child:
                    _imageBytes == null
                        ? const Center(
                          child: Icon(
                            Icons.add_a_photo,
                            size: 90,
                            color: Colors.grey,
                          ),
                        )
                        : ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.memory(_imageBytes!, fit: BoxFit.cover),
                        ),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: _getImage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[800],
                  foregroundColor: Colors.white,
                  minimumSize: const Size.fromHeight(40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text("Upload Image"),
              ),
              const SizedBox(height: 16),
              const Text(
                "Nama Wisata:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              _buildTextFormField(
                label: "Masukkan Nama Wisata",
                onSaved: (val) => _nama = val,
                validator:
                    (val) => val == null || val.isEmpty ? "Wajib diisi" : null,
              ),
              const SizedBox(height: 12),
              const Text(
                "Lokasi Wisata:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              _buildTextFormField(
                label: "Masukkan Lokasi Wisata",
                onSaved: (val) => _lokasi = val,
                validator:
                    (val) => val == null || val.isEmpty ? "Wajib diisi" : null,
              ),
              const SizedBox(height: 12),
              const Text(
                "Jenis Wisata:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              _buildDropdown(),
              const SizedBox(height: 12),
              const Text(
                "Harga Tiket:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              _buildTextFormField(
                label: "Masukkan Harga Tiket",
                keyboardType: TextInputType.number,
                onSaved: (val) => _harga = val,
                validator:
                    (val) => val == null || val.isEmpty ? "Wajib diisi" : null,
              ),
              const SizedBox(height: 12),
              const Text(
                "Deskripsi:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              _buildTextFormField(
                label: "Deskripsi",
                maxLines: 3,
                onSaved: (val) => _deskripsi = val,
                validator:
                    (val) => val == null || val.isEmpty ? "Wajib diisi" : null,
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[800],
                  foregroundColor: Colors.white,
                  minimumSize: const Size.fromHeight(40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text("Simpan"),
              ),

              const SizedBox(height: 6),
              TextButton(
                onPressed: _resetForm,
                child: const Text(
                  "Reset",
                  style: TextStyle(color: Colors.indigo, fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required String label,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
    void Function(String?)? onSaved,
  }) {
    return TextFormField(
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: label,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ),
      ),
      validator: validator,
      onSaved: onSaved,
    );
  }

  Widget _buildDropdown() {
    return DropdownButtonFormField<String>(
      value: _jenisWisata,
      decoration: InputDecoration(
        hintText: "Pilih Jenis Wisata",
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
      dropdownColor: Colors.white,
      isExpanded: true,
      items:
          jenisWisataList.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value, style: const TextStyle(color: Colors.black)),
            );
          }).toList(),
      onChanged: (val) {
        setState(() {
          _jenisWisata = val!;
        });
      },
      onSaved: (val) => _jenisWisata = val,
      validator: (val) => val == null ? "Pilih salah satu jenis wisata" : null,
    );
  }
}
