class JadwalModel {
  final String idJadwal;
  final String tanggal;
  final int jumlahAir;
  final String waktuMinum;
  final String catatan;

  JadwalModel({
    required this.idJadwal,
    required this.tanggal,
    required this.jumlahAir,
    required this.waktuMinum,
    required this.catatan,
  });

  factory JadwalModel.fromJson(Map<String, dynamic> json) {
    return JadwalModel(
      idJadwal: json['id_jadwal'] ?? '',
      tanggal: json['tanggal'] ?? '',
      jumlahAir: json['jumlah_air_ml'] ?? 0,
      waktuMinum: json['waktu_minum'] ?? '',
      catatan: json['catatan'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_jadwal': idJadwal,
      'tanggal': tanggal,
      'jumlah_air_ml': jumlahAir,
      'waktu_minum': waktuMinum,
      'catatan': catatan,
    };
  }
}
