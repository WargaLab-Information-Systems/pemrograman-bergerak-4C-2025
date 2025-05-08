class Barang {
  String? id;
  String namaBarang;
  String harga;
  String stok;

  Barang({this.id, required this.namaBarang, required this.harga, required this.stok});

  factory Barang.fromJson(Map<String, dynamic> json, String id) {
    return Barang(
      id: id,
      namaBarang: json['nama barang'],
      harga: json['Harga'],
      stok: json['Stok'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "nama barang": namaBarang,
      "Harga": harga,
      "Stok": stok,
    };
  }
}
