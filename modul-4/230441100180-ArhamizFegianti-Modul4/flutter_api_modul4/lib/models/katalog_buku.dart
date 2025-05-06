class KatalogBuku {
  final String docId;
  final String kode_buku;
  final String judul;
  final String penerbit;

  KatalogBuku({
    required this.docId,
    required this.kode_buku,
    required this.judul,
    required this.penerbit,
  });

  Map<String, dynamic> toJson() {
    return {
      "fields": {
        "kode_buku": {"integerValue": int.parse(kode_buku)},
        "judul": {"stringValue": judul},
        "penerbit": {"stringValue": penerbit},
      },
    };
  }
}
