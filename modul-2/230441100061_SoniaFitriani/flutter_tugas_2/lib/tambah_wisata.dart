import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:html' as html; // Untuk Web

class TambahWisataPage extends StatefulWidget {
  final Function(Map<String, dynamic>) onTambah;

  const TambahWisataPage({super.key, required this.onTambah});

  @override
  _TambahWisataPageState createState() => _TambahWisataPageState();
}

class _TambahWisataPageState extends State<TambahWisataPage> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _lokasiController = TextEditingController();
  final TextEditingController _hargaController = TextEditingController();
  final TextEditingController _deskripsiController = TextEditingController();

  String? _selectedJenis;
  String? _imagePath;
  String? _imageWebUrl; // Tambahan untuk URL gambar di Web
  dynamic _imageFile;

  final List<String> _jenisList = ['Alam', 'Budaya', 'Belanja', 'Kuliner'];
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

  // Di dalam _TambahWisataPageState


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
          kIsWeb ? _imageWebUrl : _imagePath ?? 'assets/default_image.jpg',
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
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            GestureDetector(
              onTap: _pilihGambar,
              child: Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(color: Colors.blue, width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child:
                    _imageFile == null
                        ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.camera_alt,
                              size: 50,
                              color: Colors.blue,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Tap untuk memilih gambar',
                              style: GoogleFonts.poppins(color: Colors.blue),
                            ),
                          ],
                        )
                        : ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child:
                              kIsWeb
                                  ? (_imageWebUrl != null
                                      ? Image.network(
                                        _imageWebUrl!,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (ctx, error, stackTrace) =>
                                                const Icon(
                                                  Icons.error,
                                                  color: Colors.red,
                                                ),
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
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: _pilihGambar,
              icon: const Icon(Icons.upload),
              label: Text(
                'Upload Gambar',
                style: GoogleFonts.poppins(fontSize: 16),
              ),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 40),
              ),
            ),
            const SizedBox(height: 20),
            _buildTextField(_namaController, 'Nama Wisata', Icons.place),
            _buildTextField(_lokasiController, 'Lokasi', Icons.location_on),
            _buildJenisDropdown(),
            _buildTextField(
              _hargaController,
              'Harga Tiket',
              Icons.attach_money,
              keyboardType: TextInputType.number,
            ),
            _buildTextField(
              _deskripsiController,
              'Deskripsi',
              null,
              maxLines: 4,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _simpanData,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(0, 50),
                    ),
                    child: Text(
                      'Simpan',
                      style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: OutlinedButton(
                    onPressed: _resetForm,
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.red),
                      minimumSize: const Size(0, 50),
                    ),
                    child: Text(
                      'Reset',
                      style: GoogleFonts.poppins(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label,
    IconData? icon, {
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: icon != null ? Icon(icon) : null,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
        maxLines: maxLines,
        keyboardType: keyboardType,
      ),
    );
  }

  Widget _buildJenisDropdown() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: DropdownButtonFormField<String>(
        value: _selectedJenis,
        items:
            _jenisList
                .map(
                  (jenis) => DropdownMenuItem(value: jenis, child: Text(jenis)),
                )
                .toList(),
        onChanged: (value) => setState(() => _selectedJenis = value),
        decoration: InputDecoration(
          labelText: 'Jenis Wisata',
          prefixIcon: const Icon(Icons.category),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}
