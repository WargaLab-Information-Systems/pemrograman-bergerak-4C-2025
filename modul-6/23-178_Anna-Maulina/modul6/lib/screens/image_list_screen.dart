// screens/image_list_screen.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:modul6/models/image_entry.dart';
import 'package:modul6/services/permission_service.dart';

class ImageListScreen extends StatefulWidget {
  final List<ImageEntry> imageEntries;

  const ImageListScreen({super.key, required this.imageEntries});

  @override
  State<ImageListScreen> createState() => _ImageListScreenState();
}

class _ImageListScreenState extends State<ImageListScreen> {
  late PermissionService _permissionService;

  @override
  void initState() {
    super.initState();
    _permissionService = PermissionService(context);
  }

  Future<void> _saveImageToGallery(File imageFile) async {
    bool storageGranted = await _permissionService.checkAndRequestStoragePermission();
    if (!storageGranted) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Storage permission not granted.')),
        );
      }
      return;
    }

    try {
      final result = await ImageGallerySaver.saveFile(imageFile.path);
      if (result['isSuccess']) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Image successfully saved to gallery!')),
          );
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text('Failed to save image to gallery: ${result['errorMessage']}')),
          );
        }
      }
    } catch (e) {
      debugPrint("Error saving image to gallery: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('An error occurred while saving the image: ${e.toString()}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final sortedImageEntries = List<ImageEntry>.from(widget.imageEntries);
    sortedImageEntries.sort((a, b) => b.timestamp.compareTo(a.timestamp));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Image List'),
        centerTitle: true,
        elevation: 4,
      ),
      body: sortedImageEntries.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.image_not_supported, size: 80, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'No images have been taken yet.',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: sortedImageEntries.length,
              itemBuilder: (context, index) {
                final entry = sortedImageEntries[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  elevation: 3,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(entry.imageFile,
                              height: 180,
                              width: double.infinity,
                              fit: BoxFit.cover),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Time: ${entry.timestamp.toLocal().toString().split('.')[0]}',
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        if (entry.locationName != null && entry.locationName!.isNotEmpty)
                          Text(
                            'Location: ${entry.locationName}',
                            style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                          )
                        else if (entry.location != null)
                          Text(
                            'Location: Lat: ${entry.location!.latitude.toStringAsFixed(4)}, Lon: ${entry.location!.longitude.toStringAsFixed(4)}',
                            style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                          )
                        else
                          Text(
                            'Location: No location information available',
                            style: TextStyle(fontSize: 14, color: Colors.grey[700], fontStyle: FontStyle.italic),
                          ),
                        const SizedBox(height: 12),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: ElevatedButton.icon(
                            onPressed: () => _saveImageToGallery(entry.imageFile),
                            icon: const Icon(Icons.download, size: 18),
                            label: const Text('Save', style: TextStyle(fontSize: 14)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}