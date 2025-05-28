import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:toko_kain/model_barang.dart';

class BarangService {
  static const String baseUrl =
      'http://192.168.1.9/Program_Flutter/Flutter_kain/';

  static Future<List<Barang>> fetchBarang() async {
    final response = await http.get(Uri.parse('${baseUrl}get.php'));

    if (response.statusCode == 200) {
      try {
        final List<dynamic> data = json.decode(response.body);
        return data.map((e) => Barang.fromJson(e)).toList();
      } catch (e) {
        throw Exception('Format data salah: $e');
      }
    } else {
      throw Exception('Gagal ambil data (${response.statusCode})');
    }
  }

  static Future<void> addBarang(Barang barang) async {
    final response = await http.post(
      Uri.parse('${baseUrl}post.php'),
      body: {
        'nama': barang.nama,
        'warna': barang.warna,
        'ukuran': barang.panjang.toString(),
      },
    );
    if (response.statusCode != 200) {
      throw Exception('Gagal tambah data');
    }
  }

  static Future<void> updateBarang(Barang barang) async {
    final response = await http.post(
      Uri.parse('${baseUrl}put.php'),
      body: {
        'id': barang.id,
        'nama': barang.nama,
        'warna': barang.warna,
        'ukuran': barang.panjang.toString(),
      },
    );
    if (response.statusCode != 200) {
      throw Exception('Gagal update data');
    }
  }

  static Future<void> deleteBarang(String id) async {
    final response = await http.post(
      Uri.parse('${baseUrl}delete.php'),
      body: {'id': id},
    );
    if (response.statusCode != 200) {
      throw Exception('Gagal hapus data');
    }
  }
}
