import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';

Future<String> cekKoneksiInternet() async {
  final connectivity = await Connectivity().checkConnectivity();
  String koneksi = "Terhubung ke jaringan";

  if (connectivity == ConnectivityResult.none) {
    return "Tidak ada koneksi internet";
  } else if (connectivity == ConnectivityResult.wifi) {
    koneksi = "Terhubung ke WiFi";
  } else if (connectivity == ConnectivityResult.mobile) {
    koneksi = "Terhubung ke jaringan seluler";
  }

  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return koneksi;
    } else {
      return "Tidak ada koneksi internet";
    }
  } on SocketException catch (_) {
    return "Tidak ada koneksi internet";
  }
}
