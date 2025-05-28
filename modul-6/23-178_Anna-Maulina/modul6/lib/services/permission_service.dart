// services/permission_service.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  BuildContext context;

  PermissionService(this.context);

  Future<bool> checkAndRequestCameraPermission() async {
    var cameraStatus = await Permission.camera.status;
    if (!cameraStatus.isGranted) {
      await requestPermission(Permission.camera, 'camera');
      cameraStatus = await Permission.camera.status; 
    }
    return cameraStatus.isGranted;
  }

  Future<bool> checkAndRequestStoragePermission() async {
    bool permissionGranted = false;
    if (Platform.isAndroid) {
      final status = await Permission.storage.request();
      permissionGranted = status.isGranted;
    } else if (Platform.isIOS) {
      final status = await Permission.photos.request();
      permissionGranted = status.isGranted;
    }

    if (!permissionGranted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Permission not granted")),
      );
      return false;
    }

    return true;
  }


  Future<bool> checkAndRequestLocationPermission() async {
    var locationStatus = await Permission.locationWhenInUse.status;
    if (!locationStatus.isGranted) {
      await requestPermission(Permission.locationWhenInUse, 'location');
      locationStatus = await Permission.locationWhenInUse.status; // Re-check status
    }
    return locationStatus.isGranted;
  }

  Future<bool> requestPermission(
      Permission permission, String permissionName) async {
    var status = await permission.request(); 
    if (status.isGranted) {
      return true; 
    } else {
      String message = '$permissionName permission not granted.';
      SnackBarAction? action;

      if (status.isPermanentlyDenied) {
        message = '$permissionName permission permanently denied. Please enable it in app settings.';
        action = SnackBarAction(
          label: 'Open Settings',
          onPressed: () {
            openAppSettings(); 
          },
        );
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          action: action, 
        ),
      );
      return false; 
    }
  }
}