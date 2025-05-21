import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/aksesoris_models.dart';

class AksesorisService {
static const String baseUrl = "http://172.16.12.137/modul5/php"; 


  // GET: Ambil semua data aksesoris
  static Future<List<Aksesoris>> fetchAksesoris() async {
    final response = await http.get(Uri.parse("$baseUrl/get.php"));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => Aksesoris.fromJson(item)).toList();
    } else {
      throw Exception("Gagal mengambil data aksesoris");
    }
  }

  // POST: Tambah data aksesoris
  static Future<void> addAksesoris(Aksesoris aksesoris) async {
    final response = await http.post(
      Uri.parse("$baseUrl/post.php"),
      body: aksesoris.toJson(),
    );

    if (response.statusCode != 200) {
      throw Exception("Gagal menambahkan aksesoris");
    }
  }

  // POST: Update data aksesoris
  static Future<void> updateAksesoris(Aksesoris aksesoris) async {
  print("Mengirim data update: ${aksesoris.toJson()}");

  final response = await http.post(
    Uri.parse("$baseUrl/put.php"),
    body: aksesoris.toJson(),
  );

  print("Response status: ${response.statusCode}");
  print("Response body: ${response.body}");

  if (response.statusCode != 200) {
    throw Exception("Gagal memperbarui aksesoris");
  }
}

  // POST: Hapus data aksesoris berdasarkan ID
  static Future<void> deleteAksesoris(String id) async {
    final response = await http.delete(
      Uri.parse("$baseUrl/delete.php"),
      body: {'id_aksesoris': id},
    );

    if (response.statusCode != 200) {
      throw Exception("Gagal menghapus aksesoris");
    }
  }
}
