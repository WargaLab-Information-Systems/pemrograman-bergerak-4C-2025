// services/connectivity_service.dart
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

Future<void> checkConnection(BuildContext context) async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  String status;

  ConnectivityResult? result;
  if (connectivityResult is List<ConnectivityResult> &&
      connectivityResult.isNotEmpty) {
    result = connectivityResult.first;
  } else {
    result = null;
  }

  if (result == ConnectivityResult.mobile) {
    status = "Mobile connection active";
  } else if (result == ConnectivityResult.wifi) {
    status = "Connected to Wi-Fi";
  } else if (result == ConnectivityResult.none) {
    status = "No internet connection";
  } else {
    status = "Connection status unknown";
  }
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Connection Status: $status')),
  );
}