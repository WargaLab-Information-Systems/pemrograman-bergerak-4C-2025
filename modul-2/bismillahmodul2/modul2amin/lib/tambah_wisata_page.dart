import 'package:flutter/material.dart';

class TambahWisataPage extends StatefulWidget {
  const TambahWisataPage({super.key});

  @override
  State<TambahWisataPage> createState() => _TambahWisataPageState();
}

class _TambahWisataPageState extends State<TambahWisataPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController namaController = TextEditingController();
  final TextEditingController lokasiController = TextEditingController();
  final TextEditingController hargaController = TextEditingController();
  final TextEditingController deskripsiController = TextEditingController();
  String? jenisWisata;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah Wisata"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Upload Image Placeholder
              Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 210, 203, 203),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.add_photo_alternate, size: 50, color: Colors.grey),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  // Tambahkan logika upload image di sini
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 87, 87, 180),
                ),
                child: const Text("Upload Image",style: TextStyle(color: Colors.white),),
              ),
              const SizedBox(height: 16),

              buildTextFormField("Nama Wisata", namaController),
              const SizedBox(height: 10),
              buildTextFormField("Lokasi Wisata", lokasiController),
              const SizedBox(height: 10),

              DropdownButtonFormField<String>(
                value: jenisWisata,
                decoration: const InputDecoration(
                  labelText: "Jenis Wisata",
                  border: OutlineInputBorder(),
                ),
                items: [
                  'Alam',
                  'Budaya',
                  'Religi',
                  'Edukasi',
                ].map((jenis) {
                  return DropdownMenuItem(
                    value: jenis,
                    child: Text(jenis),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    jenisWisata = value;
                  });
                },
                validator: (value) => value == null ? 'Jenis wisata harus dipilih' : null,
              ),
              const SizedBox(height: 10),

              buildTextFormField("Harga Tiket", hargaController,
                  keyboardType: TextInputType.number),
              const SizedBox(height: 10),
              buildTextFormField("Deskripsi", deskripsiController, maxLines: 3),
              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Semua validasi lolos
                    // Simpan data di sini
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Data berhasil disimpan')),
                    );
                  } else {
                    // Ada field yang belum valid
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Mohon lengkapi semua data')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 135, 49, 210),
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                ),
                child: const Text("Simpan",style: TextStyle(color: Colors.white),),
              
              ),
              TextButton(
                onPressed: () {
                  namaController.clear();
                  lokasiController.clear();
                  hargaController.clear();
                  deskripsiController.clear();
                  setState(() => jenisWisata = null);
                  _formKey.currentState?.reset();
                },
                child: const Text("Reset", style: TextStyle(color: Colors.indigo)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextFormField(String label, TextEditingController controller,
      {TextInputType keyboardType = TextInputType.text, int maxLines = 1}) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return '$label tidak boleh kosong';
        }
        return null;
      },
    );
  }
}
