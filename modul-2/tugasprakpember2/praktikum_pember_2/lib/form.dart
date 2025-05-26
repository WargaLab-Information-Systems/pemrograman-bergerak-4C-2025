import 'package:flutter/material.dart';
import 'data.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class Crudpage extends StatefulWidget {
  const Crudpage({super.key});

  @override
  State<Crudpage> createState() => _CrudpageState();
}

class _CrudpageState extends State<Crudpage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController namaController = TextEditingController();
  final TextEditingController lokasiController = TextEditingController();
  final TextEditingController hargaController = TextEditingController();
  final TextEditingController deskripsiController = TextEditingController();

  String? selectedJenis;
  List<String> jenisWisata = ['Alam', 'Budaya', 'Kuliner', 'Lainnya'];
  File? _image;

  Future<void> uploadImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.grey,
      ),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(vertical: 9, horizontal: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 228, 228, 228),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Tambah Wisata',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 228, 228, 228),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child:
                    _image == null
                        ? const Center(
                          child: Icon(
                            Icons.add_photo_alternate,
                            size: 100,
                            color: Colors.grey,
                          ),
                        )
                        : ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.file(
                            _image!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
              ),

              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: uploadImage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 15, 41, 191),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Upload Image',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),

              const SizedBox(height: 12),
              const Text(
                'Nama Wisata :',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: namaController,
                decoration: _inputDecoration('Masukkan Nama Wisata Disini'),
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'Nama wajib diisi'
                            : null,
              ),

              const SizedBox(height: 10),
              const Text(
                'Lokasi Wisata :',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: lokasiController,
                decoration: _inputDecoration('Masukkan Lokasi Wisata Disini'),
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'Lokasi wajib diisi'
                            : null,
              ),

              const SizedBox(height: 10),
              const Text(
                'Jenis Wisata :',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: selectedJenis,
                items:
                    jenisWisata.map((jenis) {
                      return DropdownMenuItem(value: jenis, child: Text(jenis));
                    }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedJenis = value;
                  });
                },
                decoration: _inputDecoration('Pilih Jenis Wisata'),
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'Jenis wisata wajib dipilih'
                            : null,
              ),

              const SizedBox(height: 10),
              const Text(
                'Harga Tiket :',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: hargaController,
                keyboardType: TextInputType.number,
                decoration: _inputDecoration('Masukkan Harga Tiket Disini'),
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'Harga tiket wajib diisi'
                            : null,
              ),

              const SizedBox(height: 10),
              const Text(
                'Deskripsi :',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: deskripsiController,
                maxLines: 4,
                decoration: _inputDecoration('Masukkan Deskripsi Wisata'),
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'Deskripsi wajib diisi'
                            : null,
              ),

              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final newWisata = Wisata(
                      image: _image!,
                      nama: namaController.text,
                      lokasi: lokasiController.text,
                      jenis: selectedJenis!,
                      harga: hargaController.text,
                      deskripsi: deskripsiController.text,
                    );
                    Navigator.pop(context, newWisata);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 15, 41, 191),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Simpan',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              TextButton(
                onPressed: () {
                  _formKey.currentState!.reset();
                  namaController.clear();
                  lokasiController.clear();
                  hargaController.clear();
                  deskripsiController.clear();
                  setState(() {
                    selectedJenis = null;
                  });
                },
                child: const Text(
                  'Reset',
                  style: TextStyle(
                    color: Color.fromARGB(255, 15, 41, 191),
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    decoration: TextDecoration.underline,
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