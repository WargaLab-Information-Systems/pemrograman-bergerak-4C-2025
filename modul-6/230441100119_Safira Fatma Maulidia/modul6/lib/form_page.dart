import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'model/gambar_data.dart';
import 'services/gallery_service.dart';
import 'services/location_service.dart';
// import 'services/notification_service.dart'; // sudah tidak dipakai

class FormPage extends StatefulWidget {
  final List<GambarData> dataList;

  const FormPage({super.key, required this.dataList});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  File? _image;
  final TextEditingController _momenController = TextEditingController();
  DateTime? _selectedDateTime;

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _pickDateTime() async {
    DateTime now = DateTime.now();

    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year - 5),
      lastDate: DateTime(now.year + 5),
    );

    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(now),
      );

      if (pickedTime != null) {
        setState(() {
          _selectedDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  Future<void> _simpanData() async {
    if (_image == null || _momenController.text.isEmpty || _selectedDateTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Lengkapi gambar, momen, dan tanggal/waktu.")),
      );
      return;
    }

    try {
      final location = await LocationService.getCurrentLocation();

      if (!kIsWeb) {
        final success = await GalleryService.saveImageToGallery(_image!);
        if (!success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Gagal menyimpan gambar ke galeri')),
          );
          return;
        }
      }

      widget.dataList.add(GambarData(
        imagePath: _image!.path,
        latitude: location.latitude,
        longitude: location.longitude,
        momen: _momenController.text,
        dateTime: _selectedDateTime!,
      ));

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Gambar dan momen berhasil disimpan.")),
      );

      setState(() {
        _image = null;
        _momenController.clear();
        _selectedDateTime = null;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gagal mengambil lokasi atau menyimpan gambar.')),
      );
    }
  }

  @override
  void dispose() {
    _momenController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String? dateTimeText = _selectedDateTime != null
        ? DateFormat('yyyy-MM-dd HH:mm').format(_selectedDateTime!)
        : null;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Gambar & Momen'),
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _image != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.file(_image!, width: 250, height: 250, fit: BoxFit.cover),
                    )
                  : Container(
                      width: 250,
                      height: 250,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.grey[300],
                      ),
                      child: const Center(child: Text("Belum ada gambar")),
                    ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.camera_alt, size: 30),
                    onPressed: () => _pickImage(ImageSource.camera),
                  ),
                  const SizedBox(width: 16),
                  IconButton(
                    icon: const Icon(Icons.photo_library, size: 30),
                    onPressed: () => _pickImage(ImageSource.gallery),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              TextField(
                controller: _momenController,
                decoration: InputDecoration(
                  labelText: "Momen",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  prefixIcon: const Icon(Icons.event_note),
                ),
              ),
              const SizedBox(height: 24),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                leading: const Icon(Icons.calendar_today),
                title: Text(dateTimeText ?? "Pilih Tanggal & Waktu"),
                trailing: ElevatedButton(
                  onPressed: _pickDateTime,
                  child: const Text("Pilih"),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                icon: const Icon(Icons.save),
                label: const Text("Simpan"),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: Colors.indigo,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: _simpanData,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
