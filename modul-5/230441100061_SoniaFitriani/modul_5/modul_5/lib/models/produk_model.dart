class Produk {
  final int? idProduk; // int? karena saat insert bisa null
  final String namaProduk;
  final String kategori;
  final int harga;

  Produk({
    this.idProduk,
    required this.namaProduk,
    required this.kategori,
    required this.harga,
  });

  factory Produk.fromJson(Map<String, dynamic> json) {
    return Produk(
      idProduk: json['id_produk'] is int
          ? json['id_produk']
          : int.tryParse(json['id_produk'].toString()),
      namaProduk: json['nama'] ?? '',
      kategori: json['kategori'] ?? '',
      harga: json['harga'] is int
          ? json['harga']
          : int.tryParse(json['harga'].toString()) ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_produk': idProduk, // tetep dikirim, terutama saat update
      'nama': namaProduk,
      'kategori': kategori,
      'harga': harga,
    };
  }
}
