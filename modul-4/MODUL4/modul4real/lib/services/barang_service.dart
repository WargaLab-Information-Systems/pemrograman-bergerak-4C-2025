import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/barang.dart';

class BarangService {
  static const String baseUrl =
      "https://api-kholifah-default-rtdb.firebaseio.com/info";

  /// Ambil semua barang
  static Future<List<Barang>> getBarang() async {
    try {
      final response = await http.get(Uri.parse("$baseUrl.json"));

      if (response.statusCode == 200) {
        final Map<String, dynamic>? data =
            json.decode(response.body) as Map<String, dynamic>?;

        if (data == null) return [];

        return data.entries
            .map((entry) => Barang.fromJson(entry.value, entry.key))
            .toList();
      } else {
        throw Exception("Gagal memuat data");
      }
    } catch (e) {
      throw Exception("Terjadi kesalahan saat mengambil data: $e");
    }
  }

  /// Tambahkan barang baru
  static Future<void> addBarang(Barang barang) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl.json"),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(barang.toJson()),
      );

      if (response.statusCode >= 400) {
        throw Exception("Gagal menambah barang");
      }
    } catch (e) {
      throw Exception("Terjadi kesalahan saat menambah barang: $e");
    }
  }

  /// Update barang berdasarkan ID
  static Future<void> updateBarang(Barang barang) async {
    try {
      final response = await http.patch(
        Uri.parse("$baseUrl/${barang.id}.json"),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(barang.toJson()),
      );

      if (response.statusCode >= 400) {
        throw Exception("Gagal memperbarui barang");
      }
    } catch (e) {
      throw Exception("Terjadi kesalahan saat memperbarui barang: $e");
    }
  }

  /// Hapus barang berdasarkan ID
  static Future<void> deleteBarang(String id) async {
    try {
      final response = await http.delete(
        Uri.parse("$baseUrl/$id.json"),
      );

      if (response.statusCode >= 400) {
        throw Exception("Gagal menghapus barang");
      }
    } catch (e) {
      throw Exception("Terjadi kesalahan saat menghapus barang: $e");
    }
  }
}
