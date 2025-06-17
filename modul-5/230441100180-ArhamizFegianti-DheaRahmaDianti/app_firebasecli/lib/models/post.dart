class Post {
  final String? id;
  final String imagePath;
  final String nama;
  final String jenis;
  final String harga;
  final String deskripsi;

  Post({
    this.id,
    required this.imagePath,
    required this.nama,
    required this.jenis,
    required this.harga,
    required this.deskripsi,
  });

  Map<String, dynamic> toMap() {
    return {
      'imagePath': imagePath,
      'nama': nama,
      'jenis': jenis,
      'harga': harga,
      'deskripsi': deskripsi,
    };
  }

  factory Post.fromMap(Map<String, dynamic> map, {String? id}) {
    return Post(
      id: id,
      imagePath: map['imagePath'],
      nama: map['nama'],
      jenis: map['jenis'],
      harga: map['harga'],
      deskripsi: map['deskripsi'],
    );
  }
}
