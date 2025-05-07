import 'dart:convert';
import 'package:http/http.dart' as http;
import 'film_model.dart';

class FilmService {
  static const String baseUrl =
      'https://tabelfilmbioskop-default-rtdb.firebaseio.com';
      

  // Ambil semua data film
  static Future<List<Film>> getAllFilm() async {
    final response = await http.get(Uri.parse('$baseUrl/film.json'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data == null) return [];
      return (data as Map<String, dynamic>).entries.map((entry) {
        return Film.fromMap(entry.value, entry.key);
      }).toList();
    } else {
      throw Exception('Gagal memuat data film');
    }
  }

  // Tambahkan film baru
  static Future<void> addFilm(Film film) async {
    await http.post(
      Uri.parse('$baseUrl/film.json'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(film.toMap()),
    );
  }

  // Perbarui film berdasarkan ID
  static Future<void> updateFilm(Film film) async {
    await http.patch(
      Uri.parse('$baseUrl/film/${film.id}.json'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(film.toMap()),
    );
  }

  // Hapus film berdasarkan ID
  static Future<void> deleteFilm(String id) async {
    await http.delete(Uri.parse('$baseUrl/film/$id.json'));
  }
}
