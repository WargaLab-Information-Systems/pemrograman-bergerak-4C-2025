class Tugas {
  final String id;
  final String judul;
  final String deskripsi;
  final String deadline;
  final String kategori;
  final bool selesai;

  Tugas({
    required this.id,
    required this.judul,
    required this.deskripsi,
    required this.deadline,
    required this.kategori,
    required this.selesai,
  });

  factory Tugas.fromJson(Map<String, dynamic> json, Map<String, dynamic> map) {
    return Tugas(
      id: json['id'],
      judul: json['judul'],
      deskripsi: json['deskripsi'],
      deadline: json['deadline'],
      kategori: json['kategori'],
      selesai: json['selesai'], // pastikan ini bertipe bool
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'judul': judul,
      'deskripsi': deskripsi,
      'deadline': deadline,
      'kategori': kategori,
      'selesai': selesai,
    };
  }
}
