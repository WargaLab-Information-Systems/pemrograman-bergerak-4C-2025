import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model_barang.dart';
import '../Models/add_edit_barang_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Barang> _barangList = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    try {
      final response = await http.get(
        Uri.parse('https://api-kain-default-rtdb.firebaseio.com/kain.json'),
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data != null && data is Map<String, dynamic>) {
          final List<Barang> loaded = [];
          data.forEach((key, value) {
            loaded.add(Barang.fromJson(value, key));
          });
          setState(() => _barangList = loaded);
        } else {
          setState(() => _barangList = []);
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _addBarang(Barang barang) async {
    try {
      await http.post(
        Uri.parse('https://api-kain-default-rtdb.firebaseio.com/kain.json'),
        body: json.encode(barang.toJson()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menambah data: ${e.toString()}')),
      );
    }
  }

  Future<void> _updateBarang(Barang barang) async {
    try {
      await http.put(
        Uri.parse(
          'https://api-kain-default-rtdb.firebaseio.com/kain/${barang.id}.json',
        ),
        body: json.encode(barang.toJson()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal update data: ${e.toString()}')),
      );
    }
  }

  Future<void> _deleteBarang(String id) async {
    try {
      await http.delete(
        Uri.parse('https://api-kain-default-rtdb.firebaseio.com/kain/$id.json'),
      );
      await _loadData();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal hapus data: ${e.toString()}')),
      );
    }
  }

  void _openForm({Barang? barang}) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => AddEditBarangPage(
              barang: barang,
              onSave: (newBarang) async {
                if (barang == null) {
                  await _addBarang(newBarang);
                } else {
                  await _updateBarang(newBarang);
                }
              },
            ),
      ),
    );
    if (result != null) {
      await _loadData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF1F3),
      appBar: AppBar(
        title: const Text('Toko Kain'),
        backgroundColor: Colors.pink[200],
        foregroundColor: Colors.white,
        elevation: 2,
      ),
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _barangList.isEmpty
              ? const Center(
                child: Text(
                  'Belum ada kain ditambahkan.',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              )
              : ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: _barangList.length,
                itemBuilder: (context, index) {
                  final barang = _barangList[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      title: Text(
                        barang.nama,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        '${barang.warna} • ${barang.panjang} meter',
                        style: const TextStyle(color: Colors.black54),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.deepOrange,
                            ),
                            onPressed: () => _openForm(barang: barang),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.redAccent,
                            ),
                            onPressed: () => _deleteBarang(barang.id),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pink[300],
        foregroundColor: Colors.white,
        onPressed: () => _openForm(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
