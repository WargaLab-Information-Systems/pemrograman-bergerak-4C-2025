import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tugasmodul1/model/wisata.dart'; 
import 'dart:io';

class TambahWisataPage extends StatefulWidget {
  @override
  _TambahWisataPageState createState() => _TambahWisataPageState();
}

class _TambahWisataPageState extends State<TambahWisataPage> {
  final _formKey = GlobalKey<FormState>();

  File? _imageFile;
  final picker = ImagePicker();

  TextEditingController namaController = TextEditingController();
  TextEditingController lokasiController = TextEditingController();
  TextEditingController hargaController = TextEditingController();
  TextEditingController deskripsiController = TextEditingController();
  
  String? selectedJenisWisata;

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

 void _submit() {
  if (_imageFile == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Mohon upload gambar terlebih dahulu')),
    );
    return; // hentikan eksekusi
  }

  if (_formKey.currentState!.validate()) {
    final newWisata = WisataModel(
      nama: namaController.text,
      lokasi: lokasiController.text,
      jenis: selectedJenisWisata ?? '',
      harga: hargaController.text,
      deskripsi: deskripsiController.text,
      imagePath: _imageFile!.path, // Aman karena sudah dicek
    );
    

    // Kembali ke halaman sebelumnya dengan membawa data
    Navigator.pop(context, newWisata);
  }
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Wisata', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // Upload Image
              Container(
                width: double.infinity,
                height: 200,
                color: Colors.grey[300],
                child: _imageFile == null
                    ? Icon(Icons.add_photo_alternate, size: 100, color: Colors.grey[700])
                    : Image.file(_imageFile!, fit: BoxFit.cover),
              ),
              SizedBox(height: 8),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[800],
                  minimumSize: Size(double.infinity, 50),
                ),
                onPressed: _pickImage,
                child: Text('Upload Image',  style: TextStyle(color: Colors.white)),
              ),

              SizedBox(height: 16),

              // Nama Wisata
              Text('Nama Wisata :', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              TextFormField(
                controller: namaController,
                decoration: InputDecoration(
                  hintText: 'Masukkan Nama Wisata Disini',
                  fillColor: Colors.grey[200],
                  filled: true,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama wisata tidak boleh kosong';
                  }
                  return null;
                },
              ),

              SizedBox(height: 16),

              // Lokasi Wisata
              Text('Lokasi Wisata :', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              TextFormField(
                controller: lokasiController,
                decoration: InputDecoration(
                  hintText: 'Masukkan Lokasi Wisata Disini',
                  fillColor: Colors.grey[200],
                  filled: true,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lokasi wisata tidak boleh kosong';
                  }
                  return null;
                },
              ),

              SizedBox(height: 16),

              // Jenis Wisata
              Text('Jenis Wisata :', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  hintText: 'Pilih Jenis Wisata',
                  fillColor: Colors.grey[200],
                  filled: true,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
                value: selectedJenisWisata,
                items: ['Alam', 'Budaya', 'Sejarah', 'Kuliner']
                    .map((jenis) => DropdownMenuItem(
                          value: jenis,
                          child: Text(jenis),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedJenisWisata = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Jenis wisata harus dipilih';
                  }
                  return null;
                },
              ),

              SizedBox(height: 16),

              // Harga Tiket
              Text('Harga Tiket :', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              TextFormField(
                controller: hargaController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Masukkan Harga Tiket Disini',
                  fillColor: Colors.grey[200],
                  filled: true,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Harga tiket tidak boleh kosong';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Harga tiket harus berupa angka';
                  }
                  return null;
                },
              ),

              SizedBox(height: 16),

              // Deskripsi
              Text('Deskripsi :', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              TextFormField(
                controller: deskripsiController,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Masukkan Deskripsi Wisata Disini',
                  fillColor: Colors.grey[200],
                  filled: true,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Deskripsi tidak boleh kosong';
                  }
                  return null;
                },
              ),

              SizedBox(height: 24),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[800],
                  minimumSize: Size(double.infinity, 50),
                ),
                onPressed: _submit,
                child: Text('Simpan',  style: TextStyle(color: Colors.white)),
              ),

              SizedBox(height: 16),

            Center(
              child: TextButton(
                onPressed: () {
                  // Reset semua inputan
                  namaController.clear();
                  lokasiController.clear();
                  hargaController.clear();
                  deskripsiController.clear();
                  setState(() {
                    selectedJenisWisata = null;
                    _imageFile = null;
                  });
                },
                child: Text(
                  'Reset',
                  style: TextStyle(
                    color: Colors.blue[800],
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
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
}
