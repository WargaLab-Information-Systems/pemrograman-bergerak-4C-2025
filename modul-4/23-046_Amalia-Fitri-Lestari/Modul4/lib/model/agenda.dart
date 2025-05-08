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

  factory Agenda.fromJson(Map<String, dynamic> json, String id) {
    return Agenda(
      id: id, // ID ambil dari parameter luar, bukan dari dalam json
      judul: json['judul'] ?? '',
      tanggal: json['tanggal'] ?? '',
      lokasi: json['lokasi'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'judul': judul,
      'tanggal': tanggal,
      'lokasi': lokasi,
    };
  }
}
