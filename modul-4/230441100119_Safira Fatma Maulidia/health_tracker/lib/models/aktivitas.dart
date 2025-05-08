class Aktivitas {
  final String idAktivitas;
  final String idUser;
  final String kaloriBakar;
  final String namaAktivitas;
  final String tanggal;

  Aktivitas({
    required this.idAktivitas,
    required this.idUser,
    required this.kaloriBakar,
    required this.namaAktivitas,
    required this.tanggal,
  });

  factory Aktivitas.fromJson(Map<String, dynamic> json) => Aktivitas(
    idAktivitas: json['id_aktivitas'],
    idUser: json['id_user'],
    kaloriBakar: json['kalori_bakar'],
    namaAktivitas: json['nama_aktivitas'],
    tanggal: json['tanggal'],
  );

  Map<String, dynamic> toJson() => {
    'id_aktivitas': idAktivitas,
    'id_user': idUser,
    'kalori_bakar': kaloriBakar,
    'nama_aktivitas': namaAktivitas,
    'tanggal': tanggal,
  };
}
