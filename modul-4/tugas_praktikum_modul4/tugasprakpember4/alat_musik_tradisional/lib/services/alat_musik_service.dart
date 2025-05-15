import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:alat_musik_tradisional/models/alat_musik.dart';

class AlatMusikService {
  final String baseUrl = 'https://firestore.googleapis.com/v1/projects/alat-musik-direktori/databases/(default)/documents';
  final String apiKey = 'AIzaSyBI_qky-g4TJjwqQWJwffcy1KidQJuzbRg';
  final String collection = 'alat_musik';


  Future<List<AlatMusik>> getAlatMusik() async {
    final response = await http.get(Uri.parse('$baseUrl/$collection?key=$apiKey'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List docs = data['documents'] ?? [];
      return docs.map((doc) => AlatMusik.fromJson(doc)).toList();
    } else {
      throw Exception('Gagal mengambil data');
    }
  }

  Future<void> addAlatMusik(String nama, String asal, String jenis) async {
    final response = await http.post(
      Uri.parse('$baseUrl/$collection'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "fields": {
          "nama_alat": {"stringValue": nama},
          "asal_daerah": {"stringValue": asal},
          "jenis": {"stringValue": jenis}
        }
      }),
    );
    if (response.statusCode != 200) {
      throw Exception('Gagal menambahkan data');
    }
  }

  Future<void> updateAlatMusik(String id, String nama, String asal, String jenis) async {

    final response = await http.patch(
      Uri.parse('$baseUrl/$collection/$id?key=$apiKey'),
      headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            "fields": {
              "nama_alat": {"stringValue": nama},
              "asal_daerah": {"stringValue": asal},
              "jenis": {"stringValue": jenis},
            }
      }),
    );
    if (response.statusCode != 200) {
      throw Exception('Gagal mengupdate data');
    }
  }

  Future<void> deleteAlatMusik(String id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/$collection/$id?key=$apiKey'),
    );
    if (response.statusCode != 200) {
      throw Exception('Gagal menghapus data');
    }
  }
}
