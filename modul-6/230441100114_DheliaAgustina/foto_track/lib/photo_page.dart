// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:camera/camera.dart';
// import 'package:image_gallery_saver/image_gallery_saver.dart';
// import 'package:path/path.dart' as path;
// import 'package:permission_handler/permission_handler.dart';
// import 'location_service.dart';
// import 'notification_service.dart';
// import 'gallery_page.dart';

// class PhotoPage extends StatefulWidget {
//   @override
//   _PhotoPageState createState() => _PhotoPageState();
// }

// class _PhotoPageState extends State<PhotoPage> {
//   late CameraController _controller;
//   late List<CameraDescription> cameras;
//   bool isReady = false;

//   final TextEditingController titleController = TextEditingController();
//   final TextEditingController descriptionController = TextEditingController();
//   String? selectedCategory;
//   DateTime selectedDate = DateTime.now();

//   final List<Map<String, String>> _photoDataList = [];

//   @override
//   void initState() {
//     super.initState();
//     initCamera();
//   }

//   Future<void> initCamera() async {
//     await Permission.camera.request();
//     cameras = await availableCameras();
//     _controller = CameraController(cameras[0], ResolutionPreset.medium);
//     await _controller.initialize();
//     setState(() => isReady = true);
//   }

//   Future<void> takePicture() async {
//     try {
//       final image = await _controller.takePicture();
//       final imageBytes = await File(image.path).readAsBytes();
//       await ImageGallerySaver.saveImage(imageBytes);

//       final location = await LocationService().getLocation();
//       final locationText = '(${location['latitude']}, ${location['longitude']})';

//       _photoDataList.add({
//         "image": image.path,
//         "title": titleController.text,
//         "description": descriptionController.text,
//         "category": selectedCategory ?? '',
//         "date": selectedDate.toIso8601String(),
//         "location": locationText,
//       });

//       await NotificationService().showNotification(
//         'Foto Disimpan',
//         'Lokasi: $locationText',
//       );

//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Foto & data berhasil disimpan')),
//       );

//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (_) => GalleryPage(photoData: _photoDataList),
//         ),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Gagal mengambil foto: $e')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (!isReady) {
//       return Scaffold(
//         appBar: AppBar(title: Text('Ambil Foto')),
//         body: Center(child: CircularProgressIndicator()),
//       );
//     }

//     return Scaffold(
//       appBar: AppBar(title: Text('Ambil Foto')),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(16),
//                 child: Container(
//                   width: MediaQuery.of(context).size.width * 0.7, // 70% dari lebar layar
//                   height: MediaQuery.of(context).size.width * 0.7, // tetap kotak
//                   child: CameraPreview(_controller),
//                 ),
//               ),

//               const SizedBox(height: 20),
//               ElevatedButton.icon(
//                 onPressed: takePicture,
//                 icon: Icon(Icons.camera_alt_outlined),
//                 label: Text('Ambil & Simpan Foto'),
//                 style: ElevatedButton.styleFrom(
//                   minimumSize: Size(double.infinity, 50),
//                   backgroundColor: Colors.indigo,
//                   foregroundColor: Colors.white,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Card(
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 elevation: 3,
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     children: [
//                       TextField(
//                         controller: titleController,
//                         decoration: InputDecoration(
//                           labelText: 'Judul',
//                           border: OutlineInputBorder(),
//                           prefixIcon: Icon(Icons.title),
//                         ),
//                       ),
//                       const SizedBox(height: 12),
//                       TextField(
//                         controller: descriptionController,
//                         decoration: InputDecoration(
//                           labelText: 'Deskripsi',
//                           border: OutlineInputBorder(),
//                           prefixIcon: Icon(Icons.description),
//                         ),
//                         maxLines: 2,
//                       ),
//                       const SizedBox(height: 12),
//                       DropdownButtonFormField<String>(
//                         decoration: InputDecoration(
//                           labelText: 'Kategori',
//                           border: OutlineInputBorder(),
//                           prefixIcon: Icon(Icons.category),
//                         ),
//                         value: selectedCategory,
//                         items: ['Pemandangan', 'Bangunan', 'Lainnya']
//                             .map((e) => DropdownMenuItem(value: e, child: Text(e)))
//                             .toList(),
//                         onChanged: (val) => setState(() => selectedCategory = val),
//                       ),
//                       const SizedBox(height: 12),
//                       ElevatedButton.icon(
//                         onPressed: () async {
//                           final picked = await showDatePicker(
//                             context: context,
//                             initialDate: selectedDate,
//                             firstDate: DateTime(2000),
//                             lastDate: DateTime(2100),
//                           );
//                           if (picked != null) {
//                             setState(() => selectedDate = picked);
//                           }
//                         },
//                         icon: Icon(Icons.calendar_today),
//                         label: Text(
//                           'Pilih Tanggal: ${selectedDate.toLocal().toString().split(" ")[0]}',
//                         ),
//                         style: ElevatedButton.styleFrom(
//                           minimumSize: Size(double.infinity, 45),
//                           backgroundColor: Colors.grey[200],
//                           foregroundColor: Colors.black87,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     titleController.dispose();
//     descriptionController.dispose();
//     super.dispose();
//   }
// }




import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';
import 'location_service.dart';
import 'notification_service.dart';
import 'gallery_page.dart';

class PhotoPage extends StatefulWidget {
  @override
  _PhotoPageState createState() => _PhotoPageState();
}

class _PhotoPageState extends State<PhotoPage> {
  late CameraController _controller;
  late List<CameraDescription> cameras;
  bool isReady = false;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  String? selectedCategory;
  DateTime selectedDate = DateTime.now();
  String? _selectedImagePath;

  final List<Map<String, String>> _photoDataList = [];

  @override
  void initState() {
    super.initState();
    initCamera();
  }

  Future<void> initCamera() async {
    await Permission.camera.request();
    cameras = await availableCameras();
    _controller = CameraController(cameras[0], ResolutionPreset.medium);
    await _controller.initialize();
    setState(() => isReady = true);
  }

  Future<void> takePicture() async {
    try {
      final image = await _controller.takePicture();
      final imageBytes = await File(image.path).readAsBytes();
      await ImageGallerySaver.saveImage(imageBytes);

      setState(() {
        _selectedImagePath = image.path;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Foto berhasil disimpan. Lengkapi data lalu klik "Simpan Data".')),
      );
    } catch (e) {
      _showError('Gagal mengambil foto: $e');
    }
  }

  Future<void> pickImageFromGallery() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        final imageBytes = await File(pickedFile.path).readAsBytes();
        await ImageGallerySaver.saveImage(imageBytes);

        setState(() {
          _selectedImagePath = pickedFile.path;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gambar berhasil dipilih. Lengkapi data lalu klik "Simpan Data".')),
        );
      }
    } catch (e) {
      _showError('Gagal memuat foto dari galeri: $e');
    }
  }

  Future<void> _savePhotoData(String imagePath) async {
    final location = await LocationService().getLocation();
    final locationText = '(${location['latitude']}, ${location['longitude']})';

    _photoDataList.add({
      "image": imagePath,
      "title": titleController.text,
      "description": descriptionController.text,
      "category": selectedCategory ?? '',
      "date": selectedDate.toIso8601String(),
      "location": locationText,
    });

    await NotificationService().showNotification(
      'Foto Disimpan',
      'Lokasi: $locationText',
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Foto & data berhasil disimpan')),
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => GalleryPage(photoData: _photoDataList),
      ),
    );
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!isReady) {
      return Scaffold(
        appBar: AppBar(title: Text('Ambil Foto')),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text('Ambil Foto')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.65,
                  height: MediaQuery.of(context).size.width * 0.65,
                  child: CameraPreview(_controller),
                ),
              ),
              const SizedBox(height: 20),

              ElevatedButton.icon(
                onPressed: takePicture,
                icon: Icon(Icons.camera_alt_outlined),
                label: Text('Ambil Foto'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              ElevatedButton.icon(
                onPressed: pickImageFromGallery,
                icon: Icon(Icons.photo_library_outlined),
                label: Text('Pilih dari Galeri'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  backgroundColor: Colors.green[700],
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: titleController,
                        decoration: InputDecoration(
                          labelText: 'Judul',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.title),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: descriptionController,
                        decoration: InputDecoration(
                          labelText: 'Deskripsi',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.description),
                        ),
                        maxLines: 2,
                      ),
                      const SizedBox(height: 12),
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'Kategori',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.category),
                        ),
                        value: selectedCategory,
                        items: ['Pemandangan', 'Bangunan', 'Lainnya']
                            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                            .toList(),
                        onChanged: (val) => setState(() => selectedCategory = val),
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton.icon(
                        onPressed: () async {
                          final picked = await showDatePicker(
                            context: context,
                            initialDate: selectedDate,
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                          );
                          if (picked != null) {
                            setState(() => selectedDate = picked);
                          }
                        },
                        icon: Icon(Icons.calendar_today),
                        label: Text(
                          'Pilih Tanggal: ${selectedDate.toLocal().toString().split(" ")[0]}',
                        ),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 45),
                          backgroundColor: Colors.grey[200],
                          foregroundColor: Colors.black87,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              ElevatedButton.icon(
                onPressed: () {
                  if (_selectedImagePath == null) {
                    _showError("Silakan ambil atau pilih gambar terlebih dahulu.");
                  } else if (titleController.text.isEmpty || descriptionController.text.isEmpty) {
                    _showError("Judul dan deskripsi tidak boleh kosong.");
                  } else {
                    _savePhotoData(_selectedImagePath!);
                  }
                },
                icon: Icon(Icons.save),
                label: Text('Simpan Data'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  backgroundColor: Colors.blueGrey,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}

