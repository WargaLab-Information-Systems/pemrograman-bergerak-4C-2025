import 'dart:io';

class Wisata {
  final File image;
  final String nama;
  final String lokasi;
  final String jenis;
  final String harga;
  final String deskripsi;

  Wisata({
    required this.image,
    required this.nama,
    required this.lokasi,
    required this.jenis,
    required this.harga,
    required this.deskripsi,
  });
}
