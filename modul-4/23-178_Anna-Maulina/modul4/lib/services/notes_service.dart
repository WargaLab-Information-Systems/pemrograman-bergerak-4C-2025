// services/notes_services.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/notes.dart';

class NotesService {
  static const String baseUrl = 'https://coba-4c9b1-default-rtdb.firebaseio.com/notes';

  static Future<List<Notes>> fetchNotes() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl.json'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return data.entries.map((entry) {
          final value = entry.value;
          value['id'] = entry.key;
          return Notes.fromJson(value);
        }).toList();
      } else {
        throw Exception('Failed to load notes');
      }
    } catch (e) {
      throw Exception('Failed to load notes: $e');
    }
  }

  static Future<void> deleteNote(String id) async {
    final url = Uri.parse('$baseUrl/$id.json');
    final response = await http.delete(url);
    if (response.statusCode != 200) {
      throw Exception('Gagal menghapus catatan');
    }
  }

  static Future<void> updateNote(String id, Notes note) async {
    final url = Uri.parse('$baseUrl/$id.json');
    final response = await http.put(
      url,
      body: json.encode({
        'title': note.title,
        'body': note.body,
        'createdAt': note.createdAt,
      }),
    );
    if (response.statusCode != 200) {
      throw Exception('Gagal memperbarui catatan');
    }
  }

  static Future<void> addNote(Notes note) async {
    final url = Uri.parse('$baseUrl.json');
    await http.post(url, body: json.encode({
      'title': note.title,
      'body': note.body,
      'createdAt': note.createdAt,
    }));
  }
}
