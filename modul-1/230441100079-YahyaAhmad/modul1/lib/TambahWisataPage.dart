import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class TambahWisataPage extends StatefulWidget {
  const TambahWisataPage({Key? key}) : super(key: key);

  @override
  State<TambahWisataPage> createState() => _TambahWisataPageState();
}

class _TambahWisataPageState extends State<TambahWisataPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _lokasiController = TextEditingController();
  final TextEditingController _hargaController = TextEditingController();
  final TextEditingController _deskripsiController = TextEditingController();

  String? _selectedJenisWisata;
  final List<String> _jenisWisata = ['Alam', 'Budaya', 'Kuliner', 'Belanja'];

  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEFEFEF),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(0, 255, 255, 255),
        elevation: 0,
        leading: BackButton(color: Colors.black),
        title: Text('Tambah Wisata', style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Container(
                height: 180,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  image:
                      _image != null
                          ? DecorationImage(
                            image: FileImage(_image!),
                            fit: BoxFit.cover,
                          )
                          : null,
                ),
                child:
                    _image == null
                        ? Center(child: Text('Belum ada gambar'))
                        : null,
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _pickImage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF3F32D4),
                  // textStyle: TextStyle(color: Colors.white),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text("Upload Image"),
              ),
              // TextStyle(color: Colors.black),
              const SizedBox(height: 16),

              _buildTextField("Nama Wisata", _namaController),
              const SizedBox(height: 12),

              _buildTextField("Lokasi Wisata", _lokasiController),
              const SizedBox(height: 12),

              _buildDropdownJenisWisata(),
              const SizedBox(height: 12),

              _buildTextField(
                "Harga Tiket",
                _hargaController,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 12),

              _buildTextField("Deskripsi", _deskripsiController, maxLines: 4),
              const SizedBox(height: 24),

              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Data berhasil disimpan')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF3F32D4),
                  // textStyle: Color.fromARGB(255, 255, 255, 255),
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text("Simpan", style: TextStyle(fontSize: 16)),
              ),

              const SizedBox(height: 8),

              Center(
                child: GestureDetector(
                  onTap: () {
                    _formKey.currentState!.reset();
                    _namaController.clear();
                    _lokasiController.clear();
                    _hargaController.clear();
                    _deskripsiController.clear();
                    setState(() {
                      _selectedJenisWisata = null;
                      _image = null;
                    });
                  },
                  child: Text(
                    "Reset",
                    style: TextStyle(
                      color: Colors.blue.shade800,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("$label :", style: TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: "Masukkan $label Disini",
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return '$label tidak boleh kosong';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildDropdownJenisWisata() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Jenis Wisata :", style: TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 6),
        DropdownButtonFormField<String>(
          value: _selectedJenisWisata,
          hint: Text("Pilih Jenis Wisata"),
          items:
              _jenisWisata.map((String jenis) {
                return DropdownMenuItem<String>(
                  value: jenis,
                  child: Text(jenis),
                );
              }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              _selectedJenisWisata = newValue;
            });
          },
          validator: (value) {
            if (value == null) {
              return 'Pilih jenis wisata';
            }
            return null;
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ],
    );
  }
}
