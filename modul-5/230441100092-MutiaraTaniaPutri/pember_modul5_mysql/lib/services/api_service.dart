import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/jadwal_model.dart';

class ApiService {
  static const String baseUrl = 'http://192.168.140.153/PEMBER/pember_modul5';

  static Future<Map<String, JadwalModel>> fetchJadwal() async {
    final url = Uri.parse('$baseUrl/get.php');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> body = json.decode(response.body);
      final result = <String, JadwalModel>{};

      for (var item in body) {
        final jadwal = JadwalModel.fromJson(item);
        result[jadwal.idJadwal] = jadwal;
      }

      return result;
    } else {
      throw Exception('Gagal memuat data');
    }
  }

  static Future<void> addJadwal(JadwalModel model) async {
    final url = Uri.parse('$baseUrl/post.php');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'tanggal': model.tanggal,
        'jumlah_air_ml': model.jumlahAir,
        'waktu_minum': model.waktuMinum,
        'catatan': model.catatan,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Gagal mengirim data: ${response.body}');
    }
  }


  static Future<void> deleteJadwal(String idJadwal) async {
    final url = Uri.parse('$baseUrl/delete.php');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'id_jadwal': idJadwal}),
    );

    if (response.statusCode != 200) {
      throw Exception('Gagal menghapus data: ${response.body}');
    }
  }


  static Future<void> updateJadwal(JadwalModel model) async {
    final url = Uri.parse('$baseUrl/post.php');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'id_jadwal': model.idJadwal,
        'tanggal': model.tanggal,
        'jumlah_air_ml': model.jumlahAir,
        'waktu_minum': model.waktuMinum,
        'catatan': model.catatan,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Gagal mengupdate data: ${response.body}');
    }
  }



}
