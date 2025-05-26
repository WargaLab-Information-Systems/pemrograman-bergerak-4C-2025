class AlatMusik {
  final String id;
  final String namaAlat;
  final String asalDaerah;
  final String jenis;

  AlatMusik({
    required this.id,
    required this.namaAlat,
    required this.asalDaerah,
    required this.jenis,
  });

  factory AlatMusik.fromJson(Map<String, dynamic> json) {
    final fields = json['fields'] ?? {};
    return AlatMusik(
      id: json['name'].split('/').last, // ambil ID dari URL dokumen Firebase
      namaAlat: fields['nama_alat']?['stringValue'] ?? '',
      asalDaerah: fields['asal_daerah']?['stringValue'] ?? '',
      jenis: fields['jenis']?['stringValue'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fields': {
        'nama_alat': {'stringValue': namaAlat},
        'asal_daerah': {'stringValue': asalDaerah},
        'jenis': {'stringValue': jenis},
      }
    };
  }
}
