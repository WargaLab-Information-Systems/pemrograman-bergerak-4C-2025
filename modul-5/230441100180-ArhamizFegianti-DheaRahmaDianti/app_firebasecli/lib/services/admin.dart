import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/admin.dart';

class AdminProfileService {
  static const String baseUrl = 'http:192.168.1.26';

  Future<List<AdminProfile>> fetchProfiles() async {
    final response = await http.get(Uri.parse('$baseUrl/get_profiles.php'));
    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return data.map((e) => AdminProfile.fromJson(e)).toList();
    } else {
      throw Exception('Gagal memuat data profil');
    }
  }

  Future<bool> addProfile(AdminProfile profile) async {
    final response = await http.post(
      Uri.parse('$baseUrl/create_profile.php'),
      body: profile.toJson(),
    );
    return response.statusCode == 200;
  }

  Future<bool> updateProfile(AdminProfile profile) async {
    final response = await http.post(
      Uri.parse('$baseUrl/update_profile.php'),
      body: profile.toJson(),
    );
    return response.statusCode == 200;
  }

  Future<bool> deleteProfile(String id) async {
    final response = await http.post(
      Uri.parse('$baseUrl/delete_profile.php'),
      body: {'id_admin': id},
    );
    return response.statusCode == 200;
  }
}
