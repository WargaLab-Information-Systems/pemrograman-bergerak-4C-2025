class Agenda {
  final int id;
  final String nama;
  final String detail;
  final String tanggal;
  final String lokasi;

  Agenda({
    required this.id,
    required this.nama,
    required this.detail,
    required this.tanggal,
    required this.lokasi,
  });

  factory Agenda.fromJson(Map<String, dynamic> json) {
    // Safe type conversion
    int parseId(dynamic value) {
      if (value is int) return value;
      if (value is String) return int.tryParse(value) ?? 0;
      return 0;
    }

    return Agenda(
      id: parseId(json['id']),
      nama: json['nama']?.toString() ?? '',
      detail: json['detail']?.toString() ?? '',
      tanggal: json['tanggal']?.toString() ?? '',
      lokasi: json['lokasi']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id.toString(), // Convert to string for PHP compatibility
    'nama': nama,
    'detail': detail,
    'tanggal': tanggal,
    'lokasi': lokasi,
  };
}
