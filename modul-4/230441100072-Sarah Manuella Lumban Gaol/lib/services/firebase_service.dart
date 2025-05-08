import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/permintaan_magang.dart';

class FirebaseService {
  static const String baseUrl = "https://databasemagangsi-2f280-default-rtdb.firebaseio.com/";

  Future<List<PermintaanMagang>> fetchData() async {
    final response = await http.get(Uri.parse("${baseUrl}.json"));
    if (response.statusCode == 200) {
      final Map<String, dynamic>? data = json.decode(response.body);
      if (data == null) return [];
      return data.entries.map((e) => PermintaanMagang.fromJson(e.value, e.key)).toList();
    } else {
      throw Exception("Gagal memuat data");
    }
  }

  Future<void> tambahData(PermintaanMagang data) async {
    final response = await http.post(
      Uri.parse("${baseUrl}.json"),
      body: json.encode(data.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception("Gagal menambah data");
    }
  }

  Future<void> updateData(String id, PermintaanMagang data) async {
    final response = await http.patch(
      Uri.parse("${baseUrl}$id.json"),
      body: json.encode(data.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception("Gagal mengupdate data");
    }
  }

  Future<void> deleteData(String id) async {
    final response = await http.delete(Uri.parse("${baseUrl}$id.json"));
    if (response.statusCode != 200) {
      throw Exception("Gagal menghapus data");
    }
  }
}