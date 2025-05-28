class Barang {
  final String id;
  final String nama;
  final String warna;
  final double panjang;

  Barang({
    required this.id,
    required this.nama,
    required this.warna,
    required this.panjang,
  });

  factory Barang.fromJson(Map<String, dynamic> json, String id) {
    return Barang(
      id: id,
      nama: json['nama'] ?? '',
      warna: json['warna'] ?? '',
      panjang: _parseUkuran(json['ukuran']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nama': nama,
      'warna': warna,
      'ukuran': '${panjang.toStringAsFixed(0)} Meter',
    };
  }

  static double _parseUkuran(dynamic ukuran) {
    if (ukuran is String) {
      return double.tryParse(ukuran.split(' ').first) ?? 0.0;
    } else if (ukuran is num) {
      return ukuran.toDouble();
    } else {
      return 0.0;
    }
  }
}
