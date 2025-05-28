class Barang {
  final String id;
  final String nama;
  final String warna;
  final double panjang;

  // Untuk MySQL
  Barang copyWith({String? id, String? nama, String? warna, double? panjang}) {
    return Barang(
      id: id ?? this.id,
      nama: nama ?? this.nama,
      warna: warna ?? this.warna,
      panjang: panjang ?? this.panjang,
    );
  }

  Barang({
    required this.id,
    required this.nama,
    required this.warna,
    required this.panjang,
  });

  factory Barang.fromJson(Map<String, dynamic> json) {
    return Barang(
      id: json['id'].toString(),
      nama: json['nama'],
      warna: json['warna'],
      panjang: double.parse(json['ukuran'].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'nama': nama, 'warna': warna, 'ukuran': panjang};
  }

  // Untuk Firestore
  factory Barang.fromFirestore(Map<String, dynamic> data, String id) => Barang(
    id: id,
    nama: data['nama'],
    panjang: data['ukuran'],
    warna: data['warna'],
  );

  Map<String, dynamic> toFirestore() => {
    'nama': nama,
    'ukuran': panjang,
    'warna': warna,
  };
}
