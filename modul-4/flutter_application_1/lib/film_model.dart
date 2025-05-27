class Film {
  final String id;
  final String judul;
  final String genre;
  final String durasi;
  final String jadwal;

  Film({
    required this.id,
    required this.judul,
    required this.genre,
    required this.durasi,
    required this.jadwal,
  });

  // Untuk mengambil data dari Firebase
  factory Film.fromMap(Map<String, dynamic> map, String id) {
    return Film(
      id: id,
      judul: map['judul'] ?? '',
      genre: map['genre'] ?? '',
      durasi: map['durasi'] ?? '',
      jadwal: map['jadwal'] ?? '',
    );
  }

  // Untuk mengirim data ke Firebase
  Map<String, dynamic> toMap() {
    return {
      'judul': judul,
      'genre': genre,
      'durasi': durasi,
      'jadwal': jadwal,
    };
  }
}
