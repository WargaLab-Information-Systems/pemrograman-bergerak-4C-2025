import 'package:cloud_firestore/cloud_firestore.dart';

class Aktivitas {
  String id;
  String namaAktivitas;
  int kaloriBakar;
  String idUser;
  DateTime tanggal;

  Aktivitas({
    required this.id,
    required this.namaAktivitas,
    required this.kaloriBakar,
    required this.idUser,
    required this.tanggal,
  });

  factory Aktivitas.fromMap(Map<String, dynamic> data, String docId) {
    return Aktivitas(
      id: docId,
      namaAktivitas: data['nama_aktivitas'] ?? '',
      kaloriBakar: data['kalori_bakar'] ?? 0,
      idUser: data['id_user'] ?? '',
      tanggal: (data['tanggal'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nama_aktivitas': namaAktivitas,
      'kalori_bakar': kaloriBakar,
      'id_user': idUser,
      'tanggal': Timestamp.fromDate(tanggal),
    };
  }
}
