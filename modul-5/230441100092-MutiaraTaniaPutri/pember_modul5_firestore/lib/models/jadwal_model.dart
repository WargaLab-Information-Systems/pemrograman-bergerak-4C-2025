class JadwalModel {
  final String? idJadwal; 
  final String tanggal;
  final int jumlahAir;
  final String waktuMinum;
  final String catatan;

  JadwalModel({
    this.idJadwal,
    required this.tanggal,
    required this.jumlahAir,
    required this.waktuMinum,
    required this.catatan,
  });

  factory JadwalModel.fromJson(Map<String, dynamic> json, {String? id}) {
    return JadwalModel(
      idJadwal: id,
      tanggal: json['tanggal'] ?? '',
      jumlahAir: json['jumlah_air'] ?? 0,
      waktuMinum: json['waktu_minum'] ?? '',
      catatan: json['catatan'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'tanggal': tanggal,
      'jumlah_air': jumlahAir,
      'waktu_minum': waktuMinum,
      'catatan': catatan,
    };
  }
}
