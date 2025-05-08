class Wisata {
  final String nama;
  final String lokasi;
  final String jenis;
  final String harga;
  final String deskripsi;
  final String? imagePath;

  Wisata({
    required this.nama,
    required this.lokasi,
    required this.jenis,
    required this.harga,
    required this.deskripsi,
    this.imagePath,
  });
}
