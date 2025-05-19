import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/model.dart';

class DoaService {
  static const String baseUrl =
      'https://api-tokolaptoplenovo-default-rtdb.firebaseio.com/toko_laptop_lenovo';

  // Fetch all data
  static Future<List<toko>> fetchDoa() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl.json'));
      if (response.statusCode == 200) {
        final Map<String, dynamic>? data = json.decode(response.body);
        
        if (data == null) return [];

        return data.entries.map((entry) {
          return toko.fromJson(entry.value, entry.key);
        }).toList();
      } else {
        throw Exception('Gagal memuat data');
      }
    } catch (e) {
      throw Exception('Terjadi kesalahan: $e');
    }
  }

  // Add new data
  static Future<toko> addDoa(toko doa) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl.json'),
        body: json.encode(doa.toJson()),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        return toko(
          id: responseData['name'],
          namaProduk: doa.namaProduk,
          harga: doa.harga,
          kategori: doa.kategori,
        );
      } else {
        throw Exception('Gagal menambahkan data');
      }
    } catch (e) {
      throw Exception('Terjadi kesalahan: $e');
    }
  }

  // Update existing data
  static Future<void> updateDoa(toko doa) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/${doa.id}.json'),
        body: json.encode(doa.toJson()),
      );

      if (response.statusCode != 200) {
        throw Exception('Gagal memperbarui data');
      }
    } catch (e) {
      throw Exception('Terjadi kesalahan: $e');
    }
  }

  // Delete data
  static Future<void> deleteDoa(String id) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/$id.json'),
      );

      if (response.statusCode != 200) {
        throw Exception('Gagal menghapus data');
      }
    } catch (e) {
      throw Exception('Terjadi kesalahan: $e');
    }
  }
}
