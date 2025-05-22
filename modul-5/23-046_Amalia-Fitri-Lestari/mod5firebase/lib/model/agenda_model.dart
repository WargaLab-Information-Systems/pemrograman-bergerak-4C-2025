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

  // Konstruktor untuk membuat objek Agenda dari Map (data Firestore)
  factory Agenda.fromMap(String id, Map<String, dynamic> data) {
    return Agenda(
      id: id,
      judul: data['judul'] ?? '',
      tanggal: data['tanggal'] ?? '',
      lokasi: data['lokasi'] ?? '',
    );
  }

  // Mengonversi objek Agenda menjadi Map (untuk menyimpan ke Firestore)
  Map<String, dynamic> toMap() {
    return {
      'judul': judul,
      'tanggal': tanggal,
      'lokasi': lokasi,
    };
  }
}
