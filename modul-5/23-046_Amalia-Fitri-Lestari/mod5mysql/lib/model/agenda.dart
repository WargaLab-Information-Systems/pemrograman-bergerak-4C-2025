class Agenda {
  final String id;
  final String judul;
  final String tanggal;
  final String lokasi;

  Agenda({
    required this.id,
    required this.judul,
    required this.tanggal,
    required this.lokasi,
  });

  factory Agenda.fromJson(Map<String, dynamic> json) {
    return Agenda(
      id: json['id'].toString(),
      judul: json['judul'] ?? '',
      tanggal: json['tanggal'] ?? '',
      lokasi: json['lokasi'] ?? '',
    );
  }
}
