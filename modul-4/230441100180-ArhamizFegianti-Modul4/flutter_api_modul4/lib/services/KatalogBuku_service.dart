import 'dart:convert';
import 'package:flutter_api_modul4/models/katalog_buku.dart';
import 'package:http/http.dart' as http;

class KatalogbukuService {
  static const String baseUrl =
      'https://firestore.googleapis.com/v1/projects/apikatalogbuku/databases/(default)/documents/katalog_buku';

  static Future<List<KatalogBuku>> fetchKatalogBuku() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        final List<dynamic> documents = jsonData['documents'];

        return documents.map((doc) {
            final data = doc['fields'];
            final docName = doc['name'] as String;
            final docId = docName.split('/').last;

            return KatalogBuku(
              docId: docId,
              kode_buku:
                  data['kode_buku']['integerValue']
                      .toString(),
              judul: data['judul']['stringValue'],
              penerbit: data['penerbit']['stringValue'],
            );
          }).toList()
          ..sort(
            (a, b) => int.parse(a.kode_buku).compareTo(int.parse(b.kode_buku)),
          );
      } else {
        throw Exception(
          'Failed to load data. Status code: ${response.statusCode}, body: ${response.body}',
        );
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  static Future<void> createKatalogBuku(KatalogBuku buku) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      body: json.encode({
        "fields": {
          "kode_buku": {"integerValue": buku.kode_buku},
          "judul": {"stringValue": buku.judul},
          "penerbit": {"stringValue": buku.penerbit},
        },
      }),
    );
    if (response.statusCode != 200) {
      throw Exception('gagal menambah data');
    }
  }

  static Future<void> updateKatalogBuku(KatalogBuku book) async {
    final url = Uri.parse(
      '$baseUrl/${book.docId}?updateMask.fieldPaths=kode_buku&updateMask.fieldPaths=judul&updateMask.fieldPaths=penerbit',
    );

    final response = await http.patch(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        "fields": {
          "kode_buku": {"integerValue": int.parse(book.kode_buku)},
          "judul": {"stringValue": book.judul},
          "penerbit": {"stringValue": book.penerbit},
        },
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Gagal update data. Status: ${response.statusCode}');
    }
  }

  static Future<void> deleteKatalogBuku(String docId) async {
    final url = Uri.parse('$baseUrl/$docId');

    final response = await http.delete(url);

    if (response.statusCode != 200) {
      throw Exception('Gagal menghapus data. Status: ${response.statusCode}');
    }
  }
}
