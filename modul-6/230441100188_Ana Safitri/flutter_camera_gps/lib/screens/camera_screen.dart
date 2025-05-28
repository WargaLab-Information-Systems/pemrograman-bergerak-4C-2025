import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';

import '../models/captured_image.dart';
import '../services/notification_service.dart';
import 'description_screen.dart';
import '../services/network_service.dart';

class CameraScreen extends StatefulWidget {
  final List<CameraDescription> cameras;
  const CameraScreen({required this.cameras, Key? key}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  bool _isInitialized = false;
  bool _isSaving = false;
  String _address = 'Mencari lokasi…';
  String _coordinates = 'Lat: -, Long: -';
  Timer? _locationTimer;
  Position? _currentPosition;
  bool _locationError = false;

  @override
  void initState() {
    super.initState();
    _initCamera();
    _startLocationUpdates();
    NotificationService.initialize();
  }

  Future<void> _initCamera() async {
    _controller = CameraController(
      widget.cameras[0],
      ResolutionPreset.high,
      enableAudio: false,
    );
    try {
      await _controller.initialize();
      if (mounted) setState(() => _isInitialized = true);
    } catch (e) {
      debugPrint('Error init camera: $e');
    }
  }

  void _startLocationUpdates() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if (mounted) {
        setState(() {
          _address = 'GPS tidak aktif';
          _locationError = true;
        });
      }
      return;
    }

    // Check location permission
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        if (mounted) {
          setState(() {
            _address = 'Izin lokasi ditolak';
            _locationError = true;
          });
        }
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      if (mounted) {
        setState(() {
          _address = 'Izin lokasi permanen ditolak';
          _locationError = true;
        });
      }
      return;
    }

    // Start periodic location updates
    _locationTimer = Timer.periodic(const Duration(seconds: 5), (_) async {
      try {
        final pos = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best,
        ).timeout(const Duration(seconds: 10));

        _currentPosition = pos;

        try {
          final placemarks = await placemarkFromCoordinates(
            pos.latitude,
            pos.longitude,
          ).timeout(const Duration(seconds: 5));

          final pm = placemarks.first;
          final addr = [
            if (pm.street != null && pm.street!.isNotEmpty) pm.street,
            if (pm.subLocality != null && pm.subLocality!.isNotEmpty)
              pm.subLocality,
            if (pm.locality != null && pm.locality!.isNotEmpty) pm.locality,
          ].join(', ');

          if (mounted) {
            setState(() {
              _address = addr.isEmpty ? 'Lokasi tidak diketahui' : addr;
              _coordinates =
                  'Lat ${pos.latitude.toStringAsFixed(6)}° Long ${pos.longitude.toStringAsFixed(6)}°';
              _locationError = false;
            });
          }
        } catch (e) {
          if (mounted) {
            setState(() {
              _address =
                  'Lokasi: ${pos.latitude.toStringAsFixed(6)}, ${pos.longitude.toStringAsFixed(6)}';
              _coordinates =
                  'Lat ${pos.latitude.toStringAsFixed(6)}° Long ${pos.longitude.toStringAsFixed(6)}°';
              _locationError = false;
            });
          }
        }
      } catch (e) {
        debugPrint('Lokasi error: $e');
        if (mounted) {
          setState(() {
            _address = 'Gagal mendapatkan lokasi';
            _coordinates = 'Lat: -, Long: -';
            _locationError = true;
          });
        }
      }
    });
  }

  Future<void> _openLocationSettings() async {
    await Geolocator.openLocationSettings();
  }

  @override
  void dispose() {
    _locationTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  Future<void> _takePicture() async {
    if (!_controller.value.isInitialized || _isSaving) return;
    setState(() => _isSaving = true);

    try {
      final image = await _controller.takePicture();

      final galleryResult = await ImageGallerySaver.saveFile(image.path);
      if (galleryResult['isSuccess'] != true) {
        throw Exception('Gagal simpan ke gallery');
      }

      final appDir = await getApplicationDocumentsDirectory();
      final fileName = 'photo_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final savedPath = '${appDir.path}/$fileName';
      await File(image.path).copy(savedPath);

      final lat = _currentPosition?.latitude ?? 0;
      final lon = _currentPosition?.longitude ?? 0;
      await NotificationService.showNotification(
        'Photo Saved',
        'Lat: ${lat.toStringAsFixed(4)}, Lon: ${lon.toStringAsFixed(4)}',
      );

      final captured = CapturedImage(
        path: savedPath,
        description: _address,
        latitude: lat,
        longitude: lon,
        timestamp: DateTime.now(),
      );
      if (!mounted) return;
      Navigator.pop(context, captured);
    } catch (e) {
      debugPrint('Error taking picture: $e');
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return Scaffold(
      body: Stack(
        children: [
          CameraPreview(_controller),

          // Location display at the bottom (like WhatsApp)
          Positioned(
            left: 0,
            right: 0,
            bottom: 120, // Adjusted to be above the action buttons
            child: Container(
              color: Colors.black54,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: _locationError ? Colors.red : Colors.white,
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _address,
                          style: TextStyle(
                            color: _locationError ? Colors.red : Colors.white,
                            fontSize: 14,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (_locationError)
                        GestureDetector(
                          onTap: _openLocationSettings,
                          child: Text(
                            'SETEL',
                            style: TextStyle(
                              color: Colors.blue[300],
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _coordinates,
                    style: TextStyle(
                      color: _locationError ? Colors.red : Colors.white,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year} ${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')} GMT+07:00',
                    style: TextStyle(
                      color: _locationError ? Colors.red : Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bottom action buttons
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Column(
              children: [
                // Capture button
                FloatingActionButton(
                  onPressed: _takePicture,
                  backgroundColor: Colors.white,
                  child:
                      _isSaving
                          ? const CircularProgressIndicator()
                          : const Icon(Icons.camera_alt, color: Colors.black),
                ),
                const SizedBox(height: 20),

                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildActionButton('Koleksi', Icons.collections),
                      _buildActionButton('Lokasi', Icons.location_on),
                      _buildActionButton('FOTO', Icons.photo),
                      _buildActionButton('VIDEO', Icons.videocam),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(String label, IconData icon) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 12)),
      ],
    );
  }
}
