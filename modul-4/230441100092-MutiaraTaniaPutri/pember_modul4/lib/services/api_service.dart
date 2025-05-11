import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/jadwal_model.dart';

class ApiService {
  static const String baseUrl = 'https://api-mtp-default-rtdb.firebaseio.com';
  static const String dataKey = '-OPjMywXDLbF4IeDJeL8';

  // Ubah: return Map<String, JadwalModel>
  static Future<Map<String, JadwalModel>> fetchJadwal() async {
    final url = Uri.parse('$baseUrl/jadwal_minum_air/$dataKey.json');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic>? body = json.decode(response.body);
      if (body == null) return {};

      final result = <String, JadwalModel>{};
      body.forEach((firebaseId, value) {
        if (value != null) {
          result[firebaseId] = JadwalModel.fromJson(value);
        }
      });

      return result;
    } else {
      throw Exception('Failed to load data');
    }
  }

  static Future<void> addJadwal(JadwalModel model) async {
    final url = Uri.parse('$baseUrl/jadwal_minum_air/$dataKey.json');
    await http.post(url, body: json.encode(model.toJson()));
  }

  static Future<void> deleteJadwal(String firebaseId) async {
    final url = Uri.parse('$baseUrl/jadwal_minum_air/$dataKey/$firebaseId.json');
    await http.delete(url);
  }
}
