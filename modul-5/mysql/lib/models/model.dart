class toko {
  final int? id_laptop;
  final String? nama;
  final String? kategori;
  final String? harga;

  toko({
    this.id_laptop,
    this.nama,
    this.harga,
    this.kategori,
  });

  factory toko.fromJson(Map<String, dynamic> json) {
    return toko(
      id_laptop: int.tryParse(json['id_laptop']?.toString() ?? '0'),
      nama: json['nama'],
      harga: json['harga'].toString(),
      kategori: json['kategori'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nama': nama,
      'harga': harga,
      'kategori': kategori,
    };
  }
}
