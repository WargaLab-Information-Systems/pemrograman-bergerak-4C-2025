import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/agenda.dart';

class AgendaService {
  static const String baseUrl = 'https://apiamalia-default-rtdb.firebaseio.com/agenda';

  static Future<List<Agenda>> fetchAgenda() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl.json'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>?;

        if (data == null) return [];

        return data.entries.map((entry) {
          return Agenda.fromJson(entry.value, entry.key);
        }).toList();
      } else {
        throw Exception('Failed to load agenda');
      }
    } catch (e) {
      throw Exception('Failed to load agenda: $e');
    }
  }

  static Future<void> addAgenda(Agenda agenda) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl.json'),
        body: json.encode(agenda.toJson()),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to add agenda');
      }
    } catch (e) {
      throw Exception('Failed to add agenda: $e');
    }
  }

  static Future<void> updateAgenda(Agenda agenda) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/${agenda.id}.json'),
        body: json.encode(agenda.toJson()),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update agenda');
      }
    } catch (e) {
      throw Exception('Failed to update agenda: $e');
    }
  }

  static Future<void> deleteAgenda(String id) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/$id.json'),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to delete agenda');
      }
    } catch (e) {
      throw Exception('Failed to delete agenda: $e');
    }
  }
}
