class PermintaanMagang {
  String id;
  String nama;
  String email;
  String nomorHp;
  String nim;
  String statusPengajuan;
  String perusahaanTujuan;

  PermintaanMagang({
    required this.id,
    required this.nama,
    required this.email,
    required this.nomorHp,
    required this.nim,
    required this.statusPengajuan,
    required this.perusahaanTujuan,
  });

  factory PermintaanMagang.fromJson(Map<String, dynamic> json, String id) {
    return PermintaanMagang(
      id: id,
      nama: json['nama'] ?? '',
      email: json['Email'] ?? '',
      nomorHp: json['NomorHP'] ?? '',
      nim: json['NIM'] ?? '',
      statusPengajuan: json['StatuPengajuan'] ?? '',
      perusahaanTujuan: json['PerusahaanTujuan'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nama': nama,
      'Email': email,
      'NomorHP': nomorHp,
      'NIM': nim,
      'StatuPengajuan': statusPengajuan,
      'PerusahaanTujuan': perusahaanTujuan,
    };
  }
}
