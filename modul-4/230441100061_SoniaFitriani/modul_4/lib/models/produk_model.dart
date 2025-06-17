class Produk {
  String id;
  String namaProduk;
  String kategori;
  int harga;

  Produk({
    required this.id,
    required this.namaProduk,
    required this.kategori,
    required this.harga,
  });

  factory Produk.fromJson(Map<String, dynamic> json, String id) {
    return Produk(
      id: id,
      namaProduk: json['nama_produk'],
      kategori: json['kategori'],
      harga: json['harga'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nama_produk': namaProduk,
      'kategori': kategori,
      'harga': harga,
    };
  }
}
