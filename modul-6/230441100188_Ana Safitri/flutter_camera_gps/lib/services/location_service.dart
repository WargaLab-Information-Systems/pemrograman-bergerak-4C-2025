import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  static Future<Position> getCurrentLocation() async {
    if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
      var status = await Permission.locationWhenInUse.status;
      if (!status.isGranted) {
        status = await Permission.locationWhenInUse.request();
        if (!status.isGranted) {
          throw Exception('Tidak ada izin');
        }
      }
    }

    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Lokasi tidak di temukan');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Izin di tolak');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('izin di tolak permanen');
    }

    return await Geolocator.getCurrentPosition();
  }
}
