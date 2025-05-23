import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/produk_model.dart';

class ProdukService {
  static const String baseUrl = 'https://api-sonia-9999c-default-rtdb.firebaseio.com/produk';

  Future<List<Produk>> fetchProduk() async {
    final response = await http.get(Uri.parse('$baseUrl.json'));
    final data = json.decode(response.body) as Map<String, dynamic>?;

    if (data == null) return [];

    return data.entries.map((entry) {
      return Produk.fromJson(entry.value, entry.key);
    }).toList();
  }

  Future<void> addProduk(Produk produk) async {
    await http.post(
      Uri.parse('$baseUrl.json'),
      body: json.encode(produk.toJson()),
    );
  }

  Future<void> updateProduk(Produk produk) async {
    await http.put(
      Uri.parse('$baseUrl/${produk.id}.json'),
      body: json.encode(produk.toJson()),
    );
  }

  Future<void> deleteProduk(String id) async {
    await http.delete(Uri.parse('$baseUrl/$id.json'));
  }
}

