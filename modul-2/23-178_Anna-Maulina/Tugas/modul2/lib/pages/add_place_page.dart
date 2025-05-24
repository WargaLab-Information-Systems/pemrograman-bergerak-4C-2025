// pages/add_place_page.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../models/place.dart';

class AddPlacePage extends StatefulWidget {
  const AddPlacePage({super.key});

  @override
  State<AddPlacePage> createState() => _AddPlacePageState();
}

class _AddPlacePageState extends State<AddPlacePage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _locationController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();

  String? _selectedType;
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDEDED),
      appBar: AppBar(
        title: const Text('Tambah Wisata'),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        titleTextStyle: const TextStyle(
          color: Colors.black, 
          fontSize: 18,   
          fontWeight: FontWeight.bold,
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 240,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  image: _selectedImage != null
                    ? DecorationImage(
                        image: FileImage(_selectedImage!),
                        fit: BoxFit.cover,
                      )
                    : null,
                ),
                child: _selectedImage == null
                  ? const Center(
                      child: Icon(Icons.add_photo_alternate_rounded, size: 100, color: Colors.grey),
                    )
                  : null,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _pickImage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), 
                  ),
                ),
                child: const Text("Upload Image"),
              ),
              const SizedBox(height: 16),
              _buildTextField(_titleController, "Nama Wisata",  hint: "Masukkan Nama Wisata Disini"),
              const SizedBox(height: 12),
              _buildTextField(_locationController, "Lokasi Wisata", hint: "Masukkan Lokasi Wisata Disini"),
              const SizedBox(height: 12),
              const Text("Jenis Wisata :", style: TextStyle(fontWeight: FontWeight.w500)),
              const SizedBox(height: 6),
              DropdownButtonFormField<String>(
                value: _selectedType,
                hint: const Text("Pilih Jenis Wisata"),
                items: ['Alam', 'Budaya', 'Religi', 'Kuliner']
                  .map((type) => DropdownMenuItem(
                        value: type,
                        child: Text(type),
                      ))
                  .toList(),
                onChanged: (value) {
                  setState(() => _selectedType = value);
                },
                validator: (value) => value == null ? "Wajib pilih jenis wisata" : null,
                decoration: _inputDecoration(hint: "Pilih Jenis Wisata").copyWith(
                  hintStyle: const TextStyle(color: Colors.grey), 
                ),
                style: const TextStyle(color: Colors.black),
              ),
              const SizedBox(height: 12),
              _buildTextField(_priceController, "Harga Tiket", keyboardType: TextInputType.number, hint: "Masukkan Harga Tiket Disini"),
              const SizedBox(height: 12),
              const Text("Deskripsi :", style: TextStyle(fontWeight: FontWeight.w500)),
              const SizedBox(height: 6),
              TextFormField(
                controller: _descriptionController,
                maxLines: 4,
                decoration: _inputDecoration(hint: "Masukkan Deskripsi Wisata Disini"),
                validator: (value) => value == null || value.isEmpty ? "Wajib diisi" : null,
              ),
              const SizedBox(height: 24),

              ElevatedButton(
                onPressed: () {
                  final isValid = _formKey.currentState!.validate();

                  if (_selectedImage == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Gambar wajib diupload")),
                    );
                  }
                  if (isValid && _selectedImage != null) {
                    final newPlace = Place(
                      title: _titleController.text,
                      location: _locationController.text,
                      imageUrl: _selectedImage!.path,
                      imageDetail: _selectedImage!.path,
                      description: _descriptionController.text,
                      category: _selectedType ?? '',
                      price: _priceController.text,
                    );
                    Navigator.pop(context, newPlace);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text("Simpan"),
              ),
              const SizedBox(height: 8),

              Center(
                child: TextButton(
                  onPressed: () {
                    _formKey.currentState?.reset();
                    _titleController.clear();
                    _locationController.clear();
                    _priceController.clear();
                    _descriptionController.clear();
                    setState(() {
                      _selectedType = null;
                      _selectedImage = null;
                    });
                  },
                  child: const Text(
                    "Reset",
                    style: TextStyle(color: Colors.indigo),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      {TextInputType? keyboardType, String? hint}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("$label :", style: const TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: _inputDecoration(hint: hint),
          validator: (value) =>
            value == null || value.isEmpty ? "Wajib diisi" : null,
        ),
      ],
    );
  }

  InputDecoration _inputDecoration({String? hint}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
      filled: true,
      fillColor: Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide.none,
    ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
    );
  }
}
