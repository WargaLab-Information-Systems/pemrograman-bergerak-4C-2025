import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: TambahWisataScreen(),
  ));
}

class TambahWisataScreen extends StatefulWidget {
  const TambahWisataScreen({super.key});

  @override
  State<TambahWisataScreen> createState() => _TambahWisataScreenState();
}

class _TambahWisataScreenState extends State<TambahWisataScreen> {
  final Color biru = const Color(0xFF261FB3);

  Uint8List? imageBytes;
  final TextEditingController namaController = TextEditingController();
  final TextEditingController lokasiController = TextEditingController();
  final TextEditingController hargaController = TextEditingController();
  final TextEditingController deskripsiController = TextEditingController();
  String? jenisWisata;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Tambah Wisata',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 180,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: imageBytes != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.memory(
                        imageBytes!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    )
                  : const Center(
                      child: Icon(Icons.add_photo_alternate_outlined,
                          size: 80, color: Colors.grey),
                    ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () async {
                FilePickerResult? result = await FilePicker.platform.pickFiles(
                  type: FileType.image,
                  withData: true,
                );
                if (result != null) {
                  setState(() {
                    imageBytes = result.files.first.bytes;
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: biru,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text('Upload Image',
                  style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 16),
            buildTextField(
              controller: namaController,
              label: 'Nama Wisata :',
              hint: 'Masukkan Nama Wisata Disini',
            ),
            buildTextField(
              controller: lokasiController,
              label: 'Lokasi Wisata :',
              hint: 'Masukkan Lokasi Wisata Disini',
            ),
            const SizedBox(height: 12),
            const Text('Jenis Wisata :',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButtonFormField<String>(
                value: jenisWisata,
                items: ['Alam', 'Budaya', 'Pantai', 'Lainnya']
                    .map((String item) {
                  return DropdownMenuItem(value: item, child: Text(item));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    jenisWisata = value;
                  });
                },
                decoration: const InputDecoration(border: InputBorder.none),
                hint: const Text('Pilih Jenis Wisata'),
              ),
            ),
            const SizedBox(height: 12),
            buildTextField(
              controller: hargaController,
              label: 'Harga Tiket :',
              hint: 'Masukkan Harga Tiket Disini',
            ),
            buildTextField(
              controller: deskripsiController,
              label: 'Deskripsi :',
              hint: 'Masukkan Deskripsi Wisata Disini',
              maxLines: 4,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (imageBytes == null ||
                    namaController.text.isEmpty ||
                    lokasiController.text.isEmpty ||
                    jenisWisata == null ||
                    hargaController.text.isEmpty ||
                    deskripsiController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Data harus diisi semua'),
                      backgroundColor: Colors.red,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                } else {
                  Navigator.pop(context, {
                    'gambar': imageBytes,
                    'nama': namaController.text,
                    'lokasi': lokasiController.text,
                    'kategori': jenisWisata,
                    'harga': hargaController.text,
                    'deskripsi': deskripsiController.text,
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: biru,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text('Simpan',
                  style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 8),
            Center(
              child: TextButton(
                onPressed: () {
                  setState(() {
                    imageBytes = null;
                    namaController.clear();
                    lokasiController.clear();
                    jenisWisata = null;
                    hargaController.clear();
                    deskripsiController.clear();
                  });
                },
                child: Text('Reset', style: TextStyle(color: biru)),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.white,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
