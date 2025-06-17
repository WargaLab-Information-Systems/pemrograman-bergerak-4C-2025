import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/produk_model.dart';

class ProdukService {
  static const String _baseUrl = 'http://192.168.200.212/RESTAPI_produk';

  static const Map<String, String> _headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  // CREATE
  static Future<String> tambahProduk(Produk produk) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/create.php'),
      headers: _headers,
      body: jsonEncode({
        'id_produk': produk.idProduk, // harus int
        'nama': produk.namaProduk,
        'kategori': produk.kategori,
        'harga': produk.harga,
      }),
    );

    final data = json.decode(response.body);
    print("Decoded: $data");

    if (response.statusCode == 200 && data['status'] == true) {
      return data['message']; // Ubah sesuai output dari API kamu
    } else {
      throw Exception(data['message'] ?? 'Gagal menambah produk');
    }
  }

  // READ
  static Future<List<Produk>> ambilSemuaProduk() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/get.php'),
      headers: _headers,
    );

    final data = json.decode(response.body);
    if (response.statusCode == 200 && data['status'] == true) {
      final List<dynamic> list = data['data'];
      return list.map((json) => Produk.fromJson(json)).toList();
    } else {
      throw Exception(data['message'] ?? 'Gagal mengambil data produk');
    }
  }

  // UPDATE
  static Future<void> perbaruiProduk(Produk produk) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/update.php'),
      headers: _headers,
      body: jsonEncode({
        'id_produk': produk.idProduk,
        'nama': produk.namaProduk,
        'kategori': produk.kategori,
        'harga': produk.harga,
      }),
    );

    final data = json.decode(response.body);
    if (response.statusCode != 200 || data['status'] != true) {
      throw Exception(data['message'] ?? 'Gagal memperbarui produk');
    }
  }

  // DELETE
  static Future<void> hapusProduk(int idProduk) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/delete.php'),
      headers: _headers,
      body: jsonEncode({
        "id_produk": idProduk, // ini juga harus int
      }),
    );

    final data = json.decode(response.body);
    if (response.statusCode != 200 || data['status'] != true) {
      throw Exception(data['message'] ?? 'Gagal menghapus produk');
    }
  }
}
