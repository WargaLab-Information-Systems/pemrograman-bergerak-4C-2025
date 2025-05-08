class Pet {
  final String nama;
  final String jenis;
  final String umur;
  String? id;

  Pet({
    required this.nama,
    required this.jenis,
    required this.umur,
    this.id,
  });

  factory Pet.fromJson(Map<String, dynamic> json, {String? key}) {
    return Pet(
      nama: json['nama'] ?? '',
      jenis: json['jenis'] ?? '',
      umur: json['umur'] ?? '',
      id: key,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nama': nama,
      'jenis': jenis,
      'umur': umur,
    };
  }
}
