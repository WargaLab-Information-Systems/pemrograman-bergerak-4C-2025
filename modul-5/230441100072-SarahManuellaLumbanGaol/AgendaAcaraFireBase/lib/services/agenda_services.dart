import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/agenda.dart';

class AgendaService {
  // Use your correct server IP and path
  static const String baseUrl = "http://172.16.12.154/agendaacara/";

  // Increased timeout duration
  final Duration timeoutDuration = Duration(seconds: 15);

  Future<List<Agenda>> getAgendas() async {
    try {
      print('Attempting to fetch agendas from: ${baseUrl}get.php');

      final response = await http
          .get(Uri.parse('${baseUrl}get.php'))
          .timeout(timeoutDuration);

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);

        if (decoded['status'] == true) {
          final List<dynamic> data = decoded['data'] ?? [];
          return data.map((json) => Agenda.fromJson(json)).toList();
        } else {
          throw Exception(
            decoded['message'] ??
                'Failed to load data: Invalid response format',
          );
        }
      } else {
        throw Exception('HTTP Error ${response.statusCode}: ${response.body}');
      }
    } catch (e) {
      print('Error fetching agendas: $e');
      throw Exception(
        'Failed to connect to server. Please check:\n'
        '1. Your device and server are on the same network\n'
        '2. The server is running\n'
        '3. The URL is correct',
      );
    }
  }

  Future<bool> createAgenda(Agenda agenda) async {
    try {
      print('Creating agenda: ${agenda.toJson()}');

      final response = await http
          .post(
            Uri.parse('${baseUrl}post.php'),
            headers: {'Content-Type': 'application/json'},
            body: json.encode(agenda.toJson()),
          )
          .timeout(timeoutDuration);

      print('Create response: ${response.statusCode} - ${response.body}');

      final decoded = json.decode(response.body);
      return decoded['status'] == true;
    } catch (e) {
      print('Error creating agenda: $e');
      throw Exception('Failed to create agenda: $e');
    }
  }

  Future<bool> updateAgenda(Agenda agenda) async {
    try {
      print('Updating agenda ID ${agenda.id}: ${agenda.toJson()}');

      final response = await http
          .put(
            Uri.parse('${baseUrl}put.php'),
            headers: {'Content-Type': 'application/json'},
            body: json.encode(agenda.toJson()),
          )
          .timeout(timeoutDuration);

      print('Update response: ${response.statusCode} - ${response.body}');

      final decoded = json.decode(response.body);
      return decoded['status'] == true;
    } catch (e) {
      print('Error updating agenda: $e');
      throw Exception('Failed to update agenda: $e');
    }
  }

  Future<bool> deleteAgenda(int id) async {
    try {
      print('Deleting agenda ID $id');

      final response = await http
          .delete(
            Uri.parse('${baseUrl}delete.php'), // Fixed URL (was post.php)
            headers: {'Content-Type': 'application/json'},
            body: json.encode({'id': id}),
          )
          .timeout(timeoutDuration);

      print('Delete response: ${response.statusCode} - ${response.body}');

      final decoded = json.decode(response.body);
      return decoded['status'] == true;
    } catch (e) {
      print('Error deleting agenda: $e');
      throw Exception('Failed to delete agenda: $e');
    }
  }
}
