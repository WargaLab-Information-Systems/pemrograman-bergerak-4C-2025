// services/notes_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/notes.dart';

class NotesService {
  static const String baseUrl = 'http://localhost/rest-api-notes';

  static Future<List<Notes>> fetchNotes() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/get_notes.php'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Notes.fromJson(json)).toList();
      } else {
        throw Exception('Gagal memuat catatan');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  static Future<void> deleteNote(String id) async {
    final url = Uri.parse('$baseUrl/delete_note.php');
    final response = await http.post(
      url,
      body: {'id': id},
    );
    if (response.statusCode != 200) {
      throw Exception('Gagal menghapus catatan');
    }
  }

  static Future<void> updateNote(String id, Notes note) async {
    final url = Uri.parse('$baseUrl/update_note.php');
    final response = await http.post(
      url,
      body: {
        'id': id,
        'title': note.title,
        'body': note.body,
        'createdAt': note.createdAt,
      }
    );
    if (response.statusCode != 200) {
      throw Exception('Gagal memperbarui catatan');
    }
  }

  static Future<void> addNote(Notes note) async {
    final url = Uri.parse('$baseUrl/add_note.php');
    final response = await http.post(
      url,
      body: {
        'title': note.title,
        'body': note.body,
        'createdAt': note.createdAt,
      },
    );
    if (response.statusCode != 200) {
      throw Exception('Gagal menambahkan catatan');
    }
  }
}
