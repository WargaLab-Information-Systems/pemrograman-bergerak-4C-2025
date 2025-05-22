import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/aktivitas.dart';

class AktivitasService {
  static const baseUrl = 'http://192.168.76.161/health_tracker_sql';

  static Future<List<Aktivitas>> fetchAktivitas() async {
    final response = await http.get(Uri.parse('$baseUrl/get.php'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return List<Aktivitas>.from(data.map((item) => Aktivitas.fromJson(item)));
    } else {
      throw Exception('Gagal memuat data');
    }
  }

  static Future<bool> addAktivitas(Aktivitas aktivitas) async {
    final response = await http.post(Uri.parse('$baseUrl/post.php'), body: aktivitas.toMap());
    return jsonDecode(response.body)['status'] == 'success';
  }

  static Future<bool> updateAktivitas(Aktivitas aktivitas) async {
    final response = await http.post(Uri.parse('$baseUrl/put.php'), body: aktivitas.toMapWithId());
    return jsonDecode(response.body)['status'] == 'success';
  }

  static Future<bool> deleteAktivitas(String id) async {
    final response = await http.post(
      Uri.parse('$baseUrl/delete.php'),
      body: {'id_aktivitas': id},
    );
    final data = jsonDecode(response.body);
    return data['status'] == 'success';
  }

}
