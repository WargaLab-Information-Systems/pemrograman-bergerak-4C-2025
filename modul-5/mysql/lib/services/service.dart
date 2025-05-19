import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/model.dart';

class DoaService {
  static const String baseUrl = 'http://192.168.30.64/Modul5Pember';

  // Fetch all data
  static Future<List<toko>> fetchDoa() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/get.php'));
      
      if (response.statusCode == 200) {
        print("Get response: ${response.body}");
        
        // Check if response is HTML (error) or JSON
        if (response.body.trim().startsWith('<')) {
          throw Exception('Server returned HTML instead of JSON. Check PHP errors.');
        }
        
        final List<dynamic> data = json.decode(response.body);
        
        if (data.isEmpty) return [];

        return data.map((item) {
          return toko.fromJson(item);
        }).toList();
      } else {
        throw Exception('Gagal memuat data: ${response.statusCode}');
      }
    } catch (e) {
      print("Error in fetchDoa: $e");
      throw Exception('Terjadi kesalahan: $e');
    }
  }

  // Add new data
  static Future<toko> addDoa(toko doa) async {
    try {
      print("Sending data: ${doa.nama}, ${doa.harga}, ${doa.kategori}");
      
      // Use x-www-form-urlencoded format
      final response = await http.post(
        Uri.parse('$baseUrl/post.php'),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'nama': doa.nama ?? '',
          'harga': doa.harga ?? '0',
          'kategori': doa.kategori ?? '',
        },
      );

      print("Add response status: ${response.statusCode}");
      print("Add response body: ${response.body}");
      
      // Check if response is HTML (error) or JSON
      if (response.body.trim().startsWith('<')) {
        throw Exception('Server returned HTML instead of JSON. Check PHP errors.');
      }

      if (response.statusCode == 200) {
        try {
          final responseData = json.decode(response.body);
          print("Decoded response: $responseData");
          
          // Create a new toko object with the data that was sent
          return toko(
            id_laptop: int.tryParse(responseData['id_laptop']?.toString() ?? '0'),
            nama: doa.nama,
            harga: doa.harga,
            kategori: doa.kategori,
          );
        } catch (e) {
          print("JSON decode error: $e");
          throw Exception('Invalid JSON response: ${response.body}');
        }
      } else {
        throw Exception('Gagal menambahkan data: ${response.statusCode}');
      }
    } catch (e) {
      print("Error in addDoa: $e");
      throw Exception('Terjadi kesalahan: $e');
    }
  }

  // Update existing data
  static Future<void> updateDoa(toko doa) async {
    try {
      print("Updating data: id=${doa.id_laptop}, ${doa.nama}, ${doa.harga}, ${doa.kategori}");
      
      // Use x-www-form-urlencoded format
      final response = await http.post(
        Uri.parse('$baseUrl/put.php'),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'id_laptop': doa.id_laptop?.toString() ?? '0',
          'nama': doa.nama ?? '',
          'harga': doa.harga ?? '0',
          'kategori': doa.kategori ?? '',
        },
      );

      print("Update response status: ${response.statusCode}");
      print("Update response body: ${response.body}");
      
      // Check if response is HTML (error) or JSON
      if (response.body.trim().startsWith('<')) {
        throw Exception('Server returned HTML instead of JSON. Check PHP errors.');
      }

      if (response.statusCode != 200) {
        throw Exception('Gagal memperbarui data: ${response.statusCode}');
      }
      
      try {
        json.decode(response.body); // Just to validate JSON
      } catch (e) {
        throw Exception('Invalid JSON response: ${response.body}');
      }
    } catch (e) {
      print("Error in updateDoa: $e");
      throw Exception('Terjadi kesalahan: $e');
    }
  }

  // Delete data
  static Future<void> deleteDoa(int id) async {
    try {
      print("Deleting id: $id");
      
      // Use x-www-form-urlencoded format
      final response = await http.post(
        Uri.parse('$baseUrl/delete.php'),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'id_laptop': id.toString(),
        },
      );

      print("Delete response status: ${response.statusCode}");
      print("Delete response body: ${response.body}");
      
      // Check if response is HTML (error) or JSON
      if (response.body.trim().startsWith('<')) {
        throw Exception('Server returned HTML instead of JSON. Check PHP errors.');
      }

      if (response.statusCode != 200) {
        throw Exception('Gagal menghapus data: ${response.statusCode}');
      }
      
      try {
        json.decode(response.body); // Just to validate JSON
      } catch (e) {
        throw Exception('Invalid JSON response: ${response.body}');
      }
    } catch (e) {
      print("Error in deleteDoa: $e");
      throw Exception('Terjadi kesalahan: $e');
    }
  }
}
