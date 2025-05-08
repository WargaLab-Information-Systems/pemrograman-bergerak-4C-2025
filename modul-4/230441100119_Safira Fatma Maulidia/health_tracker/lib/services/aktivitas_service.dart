import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/aktivitas.dart';

class AktivitasService {
  static const String baseUrl = 'https://api-safira-default-rtdb.firebaseio.com/health_tracker';
  static const String aktivitasKey = '-OPfP9bskp4VkEwqS4DR';

  static Future<List<Aktivitas>> fetchAktivitas() async {
    final response = await http.get(Uri.parse('$baseUrl.json'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<Aktivitas> aktivitasList = [];
      if (data != null && data[aktivitasKey] != null) {
        for (var item in data[aktivitasKey]) {
          if (item != null) {
            aktivitasList.add(Aktivitas.fromJson(Map<String, dynamic>.from(item)));
          }
        }
      }
      return aktivitasList;
    } else {
      throw Exception('Gagal memuat aktivitas');
    }
  }

  static Future<bool> saveAktivitas(List<Aktivitas> list) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$aktivitasKey.json'),
      body: json.encode([null, ...list.map((e) => e.toJson())]),
    );
    return response.statusCode == 200;
  }
}
