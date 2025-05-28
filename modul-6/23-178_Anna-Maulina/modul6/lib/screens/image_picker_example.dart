// screens/image_picker_example.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:modul6/models/image_entry.dart';
import 'package:modul6/screens/image_list_screen.dart';
import 'package:modul6/services/notification_service.dart';
import 'package:modul6/services/connectivity_service.dart';
import 'package:modul6/services/location_service.dart';
import 'package:modul6/services/permission_service.dart';

class ImagePickerExample extends StatefulWidget {
  const ImagePickerExample({super.key});

  @override
  State<ImagePickerExample> createState() => _ImagePickerExampleState();
}

class _ImagePickerExampleState extends State<ImagePickerExample> {
  File? _image;
  final ImagePicker _picker = ImagePicker();
  Position? _currentPosition;
  String? _currentAddress;
  final List<ImageEntry> _imageEntries = [];
  late PermissionService _permissionService;

  @override
  void initState() {
    super.initState();
    _permissionService = PermissionService(context);
  }

  Future<void> _getImage(ImageSource source) async {
    bool cameraGranted = false;
    bool storageGranted = false;
    bool locationGranted = false;

    if (source == ImageSource.camera) {
      cameraGranted = await _permissionService.checkAndRequestCameraPermission();
      if (!cameraGranted) return;
    } else {
      storageGranted = await _permissionService.checkAndRequestStoragePermission();
      if (!storageGranted) return;
    }

    locationGranted = await _permissionService.checkAndRequestLocationPermission();
    if (locationGranted) {
      _currentPosition = await getCurrentLocation(context);
      // Panggil reverse geocoding jika lokasi berhasil didapatkan
      if (_currentPosition != null) {
        _currentAddress = await getAddressFromCoordinates(_currentPosition!);
      } else {
        _currentAddress = null; // Reset jika lokasi tidak didapat
      }
    } else {
      _currentAddress = null;
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content:
                  Text('Location permission not granted, location will not be saved.')),
        );
      }
    }

    final pickedFile = await _picker.pickImage(source: source);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _imageEntries.add(ImageEntry(
          imageFile: _image!,
          location: _currentPosition,
          locationName: _currentAddress,
          timestamp: DateTime.now(),
        ));
      } else {
        debugPrint('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Camera & Gallery & Sensor Access'),
        centerTitle: true,
        elevation: 4,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'Last Taken Image',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: _image == null
                          ? Center(
                              child: Text(
                                'No image yet.',
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.file(
                                _image!,
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                    const SizedBox(height: 16),
                    _currentAddress != null
                        ? Text(
                            'Location: $_currentAddress',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyMedium,
                          )
                        : (_currentPosition != null
                            ? Text(
                                'Location: Lat: ${_currentPosition!.latitude.toStringAsFixed(4)}, Lon: ${_currentPosition!.longitude.toStringAsFixed(4)}',
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodyMedium,
                              )
                            : Text(
                                'Location not available.',
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontStyle: FontStyle.italic),
                              )),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            Text(
              'Select Image Source',
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _buildActionButton(
                  icon: Icons.camera_alt,
                  label: 'Camera',
                  onPressed: () => _getImage(ImageSource.camera),
                ),
                _buildActionButton(
                  icon: Icons.photo_library,
                  label: 'Gallery',
                  onPressed: () => _getImage(ImageSource.gallery),
                ),
              ],
            ),
            const SizedBox(height: 32),

            Text(
              'Other Actions',
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ImageListScreen(imageEntries: _imageEntries),
                  ),
                );
              },
              icon: const Icon(Icons.list_alt),
              label: const Text('View Image List', style: TextStyle(fontSize: 16)),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () => checkConnection(context),
              icon: const Icon(Icons.wifi),
              label: const Text('Check Internet Connection', style: TextStyle(fontSize: 16)),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                showNotif(
                  'Manual Notification!',
                  'This is a notification you triggered manually.',
                );
              },
              icon: const Icon(Icons.notifications_active),
              label: const Text('Show Notification', style: TextStyle(fontSize: 16)),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return Column(
      children: [
        FloatingActionButton(
          heroTag: label,
          onPressed: onPressed,
          tooltip: label,
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Colors.white,
          child: Icon(icon, size: 30),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }
}