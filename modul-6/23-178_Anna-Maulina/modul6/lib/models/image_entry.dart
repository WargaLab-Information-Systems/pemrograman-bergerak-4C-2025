// models/image_entry.dart
import 'dart:io';
import 'package:geolocator/geolocator.dart';

class ImageEntry {
  final File imageFile;
  final Position? location;
  final String? locationName; 
  final DateTime timestamp;

  ImageEntry({
    required this.imageFile,
    this.location,
    this.locationName, 
    required this.timestamp,
  });
}