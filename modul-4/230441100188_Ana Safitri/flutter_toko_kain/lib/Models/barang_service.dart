import 'dart:convert';
import 'package:flutter_toko_kain/model_barang.dart';
import 'package:http/http.dart' as http;

class BarangService {
  static const String baseUrl =
      'https://api-kain-default-rtdb.firebaseio.com/kain';

  static Future<List<Barang>> fetchBarang() async {
    final response = await http.get(Uri.parse('$baseUrl.json'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;
      return data.entries
          .map((entry) => Barang.fromJson(entry.value, entry.key))
          .toList();
    } else {
      throw Exception('Gagal mengambil data');
    }
  }

  static Future<void> addBarang(Barang barang) async {
    final response = await http.post(
      Uri.parse('$baseUrl.json'),
      body: json.encode(barang.toJson()),
    );
    if (response.statusCode != 200) throw Exception('Gagal menambahkan data');
  }

  static Future<void> updateBarang(Barang barang) async {
    final response = await http.put(
      Uri.parse('$baseUrl/${barang.id}.json'),
      body: json.encode(barang.toJson()),
    );
    if (response.statusCode != 200) throw Exception('Gagal memperbarui data');
  }

  static Future<void> deleteBarang(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id.json'));
    if (response.statusCode != 200) throw Exception('Gagal menghapus data');
  }
}
