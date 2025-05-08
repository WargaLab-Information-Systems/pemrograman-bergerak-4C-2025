import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/pet.dart';

class PetService {
  static const String baseUrl =
      'https://api-yahahmd-default-rtdb.firebaseio.com/peliharaan';

  static Future<List<Pet>> fetchPets() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl.json'));

      if (response.statusCode == 200) {
        if (response.body == 'null' || response.body.isEmpty) {
          return [];
        }

        final Map<String, dynamic> data = json.decode(response.body);
        final List<Pet> pets = [];

        data.forEach((key, value) {
          pets.add(Pet.fromJson(value, key: key));
        });

        return pets;
      } else {
        throw Exception('Failed to load pets: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching pets: $e');
      return [];
    }
  }

  static Future<String?> addPet(Pet pet) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl.json'),
        body: json.encode(pet.toJson()),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return data['name']; // Firebase returns the new key as 'name'
      } else {
        throw Exception('Failed to add pet: ${response.statusCode}');
      }
    } catch (e) {
      print('Error adding pet: $e');
      return null;
    }
  }

  static Future<bool> deletePet(String key) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl/$key.json'));
      return response.statusCode == 200;
    } catch (e) {
      print('Error deleting pet: $e');
      return false;
    }
  }

  static Future<bool> updatePet(String key, Pet pet) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/$key.json'),
        body: json.encode(pet.toJson()),
      );
      return response.statusCode == 200;
    } catch (e) {
      print('Error updating pet: $e');
      return false;
    }
  }
}
