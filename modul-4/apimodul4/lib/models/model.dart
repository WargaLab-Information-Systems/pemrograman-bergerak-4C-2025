class toko {
  final String? id;
  final String? namaProduk;
  final String? harga;
  final String? kategori;

  toko({
    this.id,
    this.namaProduk,
    this.harga,
    this.kategori,
  });

  factory toko.fromJson(Map<String, dynamic> json, String id) {
    return toko(
      id: id,
      namaProduk: json['nama_produk'],
      harga: json['harga'],
      kategori: json['kategori'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nama_produk': namaProduk,
      'harga': harga,
      'kategori': kategori,
    };
  }
}

