import 'dart:typed_data'; // Untuk gambar
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart'; // Untuk upload gambar

void main() {
  runApp(const MaterialApp(
    home: TambahWisataPage(),
    debugShowCheckedModeBanner: false,
  ));
}

class TambahWisataPage extends StatefulWidget {
  const TambahWisataPage({Key? key}) : super(key: key);

  @override
  State<TambahWisataPage> createState() => _TambahWisataPageState();
}

class _TambahWisataPageState extends State<TambahWisataPage> {
  final _formKey = GlobalKey<FormState>();
  final _namaCtrl = TextEditingController();
  final _lokasiCtrl = TextEditingController();
  final _hargaCtrl = TextEditingController();
  final _deskripsiCtrl = TextEditingController();

  String? _jenisWisata;
  final List<String> _jenisOptions = [
    'Pantai',
    'Pegunungan',
    'Taman Hiburan',
    'Budaya',
    'Kuliner'
  ];

  Uint8List? _imageBytes;
  bool _imageError = false; // Tambahan: untuk validasi gambar

  Future<void> _pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      withData: true,
    );
    if (result != null) {
      setState(() {
        _imageBytes = result.files.first.bytes;
        _imageError = false; // Reset error jika gambar dipilih
      });
    }
  }

  void _reset() {
    _formKey.currentState?.reset();
    _namaCtrl.clear();
    _lokasiCtrl.clear();
    _hargaCtrl.clear();
    _deskripsiCtrl.clear();
    setState(() {
      _jenisWisata = null;
      _imageBytes = null;
      _imageError = false;
    });
  }

  void _submit() {
    setState(() {
      _imageError = _imageBytes == null;
    });

    if (_formKey.currentState!.validate() && !_imageError) {
      String namaWisata = _namaCtrl.text;
      String lokasiWisata = _lokasiCtrl.text;
      String hargaTiket = _hargaCtrl.text;
      String deskripsi = _deskripsiCtrl.text;
      String jenisWisata = _jenisWisata ?? "Tidak Diketahui";

      Navigator.pop(context, {
        'namaWisata': namaWisata,
        'lokasiWisata': lokasiWisata,
        'hargaTiket': hargaTiket,
        'deskripsi': deskripsi,
        'jenisWisata': jenisWisata,
        'imageBytes': _imageBytes,
      });

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Wisata berhasil disimpan'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE5E5E5),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Tambah Wisata', style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // === AREA GAMBAR DENGAN VALIDASI ===
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 140,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: _imageError ? Colors.red : Colors.transparent,
                        width: 1,
                      ),
                    ),
                    child: _imageBytes != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.memory(
                              _imageBytes!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          )
                        : const Center(
                            child: Icon(Icons.add_photo_alternate,
                                size: 56, color: Colors.grey),
                          ),
                  ),
                  if (_imageError)
                    const Padding(
                      padding: EdgeInsets.only(top: 4, left: 4),
                      child: Text(
                        'Gambar harus diunggah',
                        style: TextStyle(color: Colors.red, fontSize: 12),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 6, 6, 247)),
                onPressed: _pickImage,
                child: const Text('Upload Image',
                    style: TextStyle(color: Color.fromARGB(255, 249, 249, 252))),
              ),
              const SizedBox(height: 16),
              _buildLabel('Nama Wisata :'),
              _buildTextField(_namaCtrl, 'Masukkan Nama Wisata Disini'),
              const SizedBox(height: 12),
              _buildLabel('Lokasi Wisata :'),
              _buildTextField(_lokasiCtrl, 'Masukkan Lokasi Wisata Disini'),
              const SizedBox(height: 12),
              _buildLabel('Jenis Wisata :'),
              DropdownButtonFormField<String>(
                decoration: _inputDecoration(),
                value: _jenisWisata,
                hint: const Text('Pilih Jenis Wisata'),
                items: _jenisOptions
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (v) => setState(() => _jenisWisata = v),
                validator: (v) => v == null ? 'Pilih jenis wisata' : null,
              ),
              const SizedBox(height: 12),
              _buildLabel('Harga Tiket :'),
              _buildTextField(_hargaCtrl, 'Masukkan Harga Tiket Disini',
                  keyboardType: TextInputType.number),
              const SizedBox(height: 12),
              _buildLabel('Deskripsi :'),
              _buildTextField(_deskripsiCtrl, 'Masukkan Deskripsi Disini',
                  maxLines: 4),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(48),
                    backgroundColor: const Color.fromARGB(255, 9, 9, 229)),
                onPressed: _submit,
                child: const Text('Simpan',
                    style: TextStyle(color: Color.fromARGB(255, 249, 249, 252))),
              ),
              const SizedBox(height: 8),
              Center(
                child: TextButton(
                  onPressed: _reset,
                  child: const Text('Reset',
                      style: TextStyle(color: Color(0xFF1F22A6))),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: Text(text, style: const TextStyle(fontWeight: FontWeight.w600)),
      );

  Widget _buildTextField(TextEditingController ctrl, String hint,
          {TextInputType keyboardType = TextInputType.text, int maxLines = 1}) =>
      TextFormField(
        controller: ctrl,
        maxLines: maxLines,
        keyboardType: keyboardType,
        decoration: _inputDecoration(hint: hint),
        validator: (v) => (v == null || v.isEmpty) ? 'Field tidak boleh kosong' : null,
      );

  InputDecoration _inputDecoration({String? hint}) => InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide.none,
        ),
      );
}
