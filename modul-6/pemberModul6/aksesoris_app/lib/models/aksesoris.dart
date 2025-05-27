import 'dart:io';

class Aksesoris {
  final String nama;
  final int stok;
  final int harga;
  final File? gambar;

  Aksesoris({
    required this.nama,
    required this.stok,
    required this.harga,
    this.gambar,
  });
}
