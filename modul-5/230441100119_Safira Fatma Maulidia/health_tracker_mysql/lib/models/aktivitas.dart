class Aktivitas {
  final String idAktivitas;
  final String idUser;
  final String namaAktivitas;
  final String kaloriBakar;
  final String tanggal;

  Aktivitas({
    required this.idAktivitas,
    required this.idUser,
    required this.namaAktivitas,
    required this.kaloriBakar,
    required this.tanggal,
  });

  factory Aktivitas.fromJson(Map<String, dynamic> json) {
    return Aktivitas(
      idAktivitas: json['id_aktivitas'].toString(),
      idUser: json['id_user'].toString(),
      namaAktivitas: json['nama_aktivitas'],
      kaloriBakar: json['kalori_bakar'].toString(),
      tanggal: json['tanggal'],
    );
  }

  Map<String, String> toMap() {
    return {
      'id_user': idUser,
      'nama_aktivitas': namaAktivitas,
      'kalori_bakar': kaloriBakar,
      'tanggal': tanggal,
    };
  }

Map<String, String> toMapWithId() {
  return {
    'id_aktivitas': idAktivitas,
    'id_user': idUser,
    'nama_aktivitas': namaAktivitas,
    'kalori_bakar': kaloriBakar,
    'tanggal': tanggal,
  };
}
}