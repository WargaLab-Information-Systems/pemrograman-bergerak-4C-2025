class Aksesoris {
  final String id_aksesoris;
  final String nama_aksesoris;
  final String harga;
  final String stok;

  Aksesoris({
    required this.id_aksesoris,
    required this.nama_aksesoris,
    required this.harga,
    required this.stok,
  });

  factory Aksesoris.fromJson(Map<String, dynamic> json) {
    return Aksesoris(
      id_aksesoris: json['id_aksesoris'],
      nama_aksesoris: json['nama_aksesoris'],
      harga: json['harga'],
      stok: json['stok'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_aksesoris': id_aksesoris,
      'nama_aksesoris': nama_aksesoris,
      'harga': harga,
      'stok': stok,
    };
  }
}
