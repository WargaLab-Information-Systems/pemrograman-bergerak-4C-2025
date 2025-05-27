import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/agenda.dart';

class AgendaService {
  // static final String baseUrl = 'http://10.10.3.83/Agenda1/'; 
  static final String baseUrl = 'http://172.16.12.217/Agenda1/'; 

  /// Ambil semua data agenda
  static Future<List<Agenda>> fetchAgenda() async {
    final response = await http.get(Uri.parse('$baseUrl/get.php'));
    
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Agenda.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load agenda');
    }
  }

  /// Tambah agenda
  static Future<void> addAgenda(Agenda agenda) async {
    final response = await http.post(
      Uri.parse('$baseUrl/insert.php'),
      body: {
        'judul': agenda.judul,
        'tanggal': agenda.tanggal,
        'lokasi': agenda.lokasi,
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Gagal menambahkan agenda');
    }
  }

  /// Update agenda
  static Future<void> updateAgenda(Agenda agenda) async {
    final response = await http.post(
      Uri.parse('$baseUrl/update.php'),
      body: {
        'id': agenda.id,
        'judul': agenda.judul,
        'tanggal': agenda.tanggal,
        'lokasi': agenda.lokasi,
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Gagal mengubah agenda');
    }
  }

  /// Hapus agenda
  static Future<void> deleteAgenda(String id) async {
    final response = await http.post(
      Uri.parse('$baseUrl/delete.php'),
      body: {
        'id': id,
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Gagal menghapus agenda');
    }
  }
}
