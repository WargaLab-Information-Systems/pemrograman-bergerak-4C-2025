import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:typed_data';

class AddWisataScreen extends StatefulWidget {
  final Function(Map<String, dynamic>) onAddWisata;

  const AddWisataScreen({Key? key, required this.onAddWisata}) : super(key: key);

  @override
  State<AddWisataScreen> createState() => _AddWisataScreenState();
}

class _AddWisataScreenState extends State<AddWisataScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _lokasiController = TextEditingController();
  final TextEditingController _hargaController = TextEditingController();
  final TextEditingController _deskripsiController = TextEditingController();
  String _jenisWisata = 'Alam';
  
  // Untuk menyimpan path file pada mobile
  String? _imagePath;
  // Untuk menyimpan data gambar pada web
  Uint8List? _webImage;
  bool _hasImage = false;
  
  final ImagePicker _picker = ImagePicker();

  List<String> jenisWisataOptions = ['Alam', 'Budaya', 'Kuliner', 'Sejarah', 'Pantai'];

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        if (kIsWeb) {
          
          pickedFile.readAsBytes().then((value) {
            setState(() {
              _webImage = value;
              _hasImage = true;
            });
          });
        } else {
          // Untuk mobile, simpan path file
          _imagePath = pickedFile.path;
          _hasImage = true;
        }
      });
    }
  }

  void _resetForm() {
    _namaController.clear();
    _lokasiController.clear();
    _hargaController.clear();
    _deskripsiController.clear();
    setState(() {
      _jenisWisata = 'Alam';
      _imagePath = null;
      _webImage = null;
      _hasImage = false;
    });
  }

 void _submitForm() {
  if (!_hasImage) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Silakan unggah gambar terlebih dahulu'),
        backgroundColor: Colors.red,
      ),
    );
    return;
  }

  if (_formKey.currentState!.validate()) {
    // Membuat map dengan data form
    final newWisata = {
      'nama': _namaController.text,
      'lokasi': _lokasiController.text,
      'jenis': _jenisWisata,
      'harga': _hargaController.text,
      'deskripsi': _deskripsiController.text,
      'imagePath': _imagePath ?? 'lib/images/gambar.png',
      'isCustomImage': _hasImage,
      'webImage': _webImage,
    };

    // Memanggil fungsi callback untuk menambahkan wisata baru
    widget.onAddWisata(newWisata);

    // Kembali ke halaman utama
    Navigator.pop(context);
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Tambah Wisata',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Tampilan gambar yang dipilih atau placeholder
              Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: _hasImage
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: kIsWeb
                            ? _webImage != null
                                ? Image.memory(
                                    _webImage!,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                  )
                                : Icon(
                                    Icons.image,
                                    size: 50,
                                    color: Colors.grey[600],
                                  )
                            : Image.file(
                                File(_imagePath!),
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                      )
                    : Center(
                        child: Icon(
                          Icons.add_photo_alternate,
                          size: 50,
                          color: Colors.grey[600],
                        ),
                      ),
              ),
              SizedBox(height: 16),
              
              // Tombol Upload Image
              ElevatedButton(
                onPressed: _pickImage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF3F51B5),
                  padding: EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Upload Image',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white, 
                  ),
                ),

              ),
              SizedBox(height: 16),
              
              // Field Nama Wisata
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Nama Wisata:', style: TextStyle(fontSize: 14)),
                  SizedBox(height: 4),
                  TextFormField(
                    controller: _namaController,
                    decoration: InputDecoration(
                      hintText: 'Masukkan Nama Wisata Disini',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Nama wisata tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                ],
              ),
              SizedBox(height: 16),
              
              // Field Lokasi Wisata
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Lokasi Wisata:', style: TextStyle(fontSize: 14)),
                  SizedBox(height: 4),
                  TextFormField(
                    controller: _lokasiController,
                    decoration: InputDecoration(
                      hintText: 'Masukkan Lokasi Wisata Disini',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Lokasi wisata tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                ],
              ),
              SizedBox(height: 16),
              
              // Dropdown Jenis Wisata
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Jenis Wisata:', style: TextStyle(fontSize: 14)),
                  SizedBox(height: 4),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: _jenisWisata,
                        icon: Icon(Icons.keyboard_arrow_down),
                        items: jenisWisataOptions.map((String item) {
                          return DropdownMenuItem<String>(
                            value: item,
                            child: Text(item),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            setState(() {
                              _jenisWisata = newValue;
                            });
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              
              // Field Harga Tiket
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Harga Tiket:', style: TextStyle(fontSize: 14)),
                  SizedBox(height: 4),
                  TextFormField(
                    controller: _hargaController,
                    decoration: InputDecoration(
                      hintText: 'Masukkan Harga Tiket Disini',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Harga tiket tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                ],
              ),
              SizedBox(height: 16),
              
              // Field Deskripsi
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Deskripsi:', style: TextStyle(fontSize: 14)),
                  SizedBox(height: 4),
                  TextFormField(
                    controller: _deskripsiController,
                    decoration: InputDecoration(
                      hintText: 'Masukkan Deskripsi Disini',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    ),
                    maxLines: 3,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Deskripsi tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                ],
              ),
              SizedBox(height: 24),
              
              // Tombol Simpan
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF3F51B5),
                  padding: EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Simpan',
                  style: TextStyle(fontSize: 16, color: Colors.white)
                  
                ),
              ),
              SizedBox(height: 12),
              
              // Tombol Reset
              TextButton(
                onPressed: _resetForm,
                child: Text(
                  'Reset',
                  style: TextStyle(color: Colors.grey[700], fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}