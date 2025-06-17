import 'dart:typed_data';
import 'package:flutter/material.dart';

class TravelData {
  final String nama;
  final String lokasi;
  final String jenis;
  final String harga;
  final String deskripsi;
  final Uint8List? imageBytes;

  TravelData({
    required this.nama,
    required this.lokasi,
    required this.jenis,
    required this.harga,
    required this.deskripsi,
    required this.imageBytes,
  });

  ImageProvider get imageProvider => MemoryImage(imageBytes!);
}
