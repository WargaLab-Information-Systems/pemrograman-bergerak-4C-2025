import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:html' as html; // Untuk Web

class AddTravelPage extends StatefulWidget {
  final Function(Map<String, dynamic>) onTambah;

  const AddTravelPage({super.key, required this.onTambah});

  @override
  _AddTravelPageState createState() => _AddTravelPageState();
}

class _AddTravelPageState extends State<AddTravelPage> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _lokasiController = TextEditingController();
  final TextEditingController _hargaController = TextEditingController();
  final TextEditingController _deskripsiController = TextEditingController();

  String? _selectedJenis;
  String? _imagePath;
  String? _imageWebUrl;
  dynamic _imageFile;

  final List<String> _jenisList = [
    'Wisata Alam',
    'Wisata Budaya',
    'Wisata Belanja',
    'Wisata Kuliner',
  ];
  final ImagePicker _picker = ImagePicker();

  Future<void> _pilihGambar() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
      );
      if (pickedFile != null) {
        setState(() {
          _imagePath = pickedFile.path;
          if (kIsWeb) {
            _imageFile = pickedFile;
          } else {
            _imageFile = File(pickedFile.path);
          }
        });

        // Tambahkan URL gambar untuk Web
        if (kIsWeb) {
          final bytes = await pickedFile.readAsBytes();
          final blob = html.Blob([bytes]);
          final url = html.Url.createObjectUrlFromBlob(blob);
          setState(() {
            _imageWebUrl = url;
          });
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
    }
  }

  void _resetForm() {
    _namaController.clear();
    _lokasiController.clear();
    _hargaController.clear();
    _deskripsiController.clear();
    setState(() {
      _selectedJenis = null;
      _imagePath = null;
      _imageFile = null;
      _imageWebUrl = null;
    });
  }

  Future<String> _handleImagePath() async {
    if (_imageFile == null) {
      return 'assets/default_image.jpg';
    }

    if (kIsWeb) {
      return _imageWebUrl ?? 'assets/images/default_image.jpg';
    } else {
      return _imagePath ?? 'assets/images/default_image.jpg';
    }
  }

  void _simpanData() async {
    if (_namaController.text.isEmpty ||
        _lokasiController.text.isEmpty ||
        _selectedJenis == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Isi semua field wajib!')));
      return;
    }

    final wisataBaru = {
      'nama': _namaController.text,
      'lokasi': _lokasiController.text,
      'jenis': _selectedJenis!,
      'harga': _hargaController.text,
      'deskripsi': _deskripsiController.text,
      'gambar':
          kIsWeb
              ? _imageWebUrl
              : _imagePath ?? 'assets/images/default_image.jpg',
    };

    widget.onTambah(wisataBaru);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tambah Wisata',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: _pilihGambar,
              child: Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child:
                    _imageFile == null
                        ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.add_photo_alternate_outlined,
                              size: 50,
                              color: Colors.grey,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Upload Image',
                              style: GoogleFonts.poppins(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        )
                        : ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child:
                              kIsWeb
                                  ? (_imageWebUrl != null
                                      ? Image.network(
                                        _imageWebUrl!,
                                        fit: BoxFit.cover,
                                      )
                                      : const Center(
                                        child: CircularProgressIndicator(),
                                      ))
                                  : Image.file(
                                    File(_imagePath!),
                                    fit: BoxFit.cover,
                                  ),
                        ),
              ),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: _pilihGambar,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                minimumSize: const Size(double.infinity, 40),
              ),
              child: Text(
                'Upload Image',
                style: GoogleFonts.poppins(fontSize: 16, color: Colors.white),
              ),
            ),
            const SizedBox(height: 25),
            _buildLabel('Nama Wisata :'),
            _buildTextField(_namaController, 'Masukkan Nama Wisata Disini'),
            const SizedBox(height: 10),
            _buildLabel('Lokasi Wisata :'),
            _buildTextField(_lokasiController, 'Masukkan Lokasi Wisata Disini'),
            const SizedBox(height: 10),
            _buildLabel('Jenis Wisata :'),
            _buildJenisDropdown(),
            const SizedBox(height: 10),
            _buildLabel('Harga Tiket :'),
            _buildTextField(
              _hargaController,
              'Masukkan Harga Tiket Disini',
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            _buildLabel('Deskripsi :'),
            _buildTextField(
              _deskripsiController,
              'Masukkan Deskripsi Disini',
              maxLines: 4,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _simpanData,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: Text(
                'Simpan',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: TextButton(
                onPressed: _resetForm,
                child: Text(
                  'Reset',
                  style: GoogleFonts.poppins(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String hintText, {
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 12,
        ),
      ),
    );
  }

  Widget _buildJenisDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedJenis,
      items:
          _jenisList.map((jenis) {
            return DropdownMenuItem(value: jenis, child: Text(jenis));
          }).toList(),
      onChanged: (value) {
        setState(() {
          _selectedJenis = value;
        });
      },
      decoration: InputDecoration(
        hintText: 'Pilih Jenis Wisata',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 12,
        ),
      ),
    );
  }
}
