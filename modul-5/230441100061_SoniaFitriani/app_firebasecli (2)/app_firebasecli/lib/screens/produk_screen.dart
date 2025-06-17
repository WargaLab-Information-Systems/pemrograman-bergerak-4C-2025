import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProdukScreen extends StatelessWidget {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  ProdukScreen({super.key});

  // --- Get Semua Produk ---
  Future<List<Map<String, dynamic>>> getProduk() async {
    try {
      final snapshot = await firestore
          .collection('produk')
          .orderBy('created_at', descending: true)
          .get();

      return snapshot.docs.map((doc) {
        final data = doc.data();
        data['docId'] = doc.id;
        return data;
      }).toList();
    } catch (e) {
      debugPrint('Error fetching produk: $e');
      return [];
    }
  }

  // --- Get Produk berdasarkan ID Dokumen ---
  Future<Map<String, dynamic>?> getProdukById(String id) async {
    try {
      final doc = await firestore.collection('produk').doc(id).get();
      if (doc.exists) {
        final data = doc.data();
        data?['docId'] = doc.id;
        return data;
      }
      return null;
    } catch (e) {
      debugPrint('Error: $e');
      return null;
    }
  }

  // --- Tambah Produk ---
  void _addProduk(BuildContext context) {
    final idController = TextEditingController();
    final namaController = TextEditingController();
    final kategoriController = TextEditingController();
    final hargaController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Tambah Produk'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: idController,
                decoration: const InputDecoration(labelText: 'ID Produk'),
              ),
              TextField(
                controller: namaController,
                decoration: const InputDecoration(labelText: 'Nama'),
              ),
              TextField(
                controller: kategoriController,
                decoration: const InputDecoration(labelText: 'Kategori'),
              ),
              TextField(
                controller: hargaController,
                decoration: const InputDecoration(labelText: 'Harga'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Batal')),
          ElevatedButton(
            onPressed: () async {
              if (idController.text.isEmpty || namaController.text.isEmpty) return;

              await firestore.collection('produk').doc(idController.text).set({
                'id_produk': idController.text,
                'nama': namaController.text,
                'kategori': kategoriController.text,
                'harga': int.tryParse(hargaController.text) ?? 0,
                'created_at': FieldValue.serverTimestamp(),
              });
              Navigator.pop(context);
            },
            child: const Text('Simpan'),
          )
        ],
      ),
    );
  }

  // --- Update Produk ---
  void _updateProduk(BuildContext context, String docId, Map<String, dynamic> currentData) {
    final namaController = TextEditingController(text: currentData['nama']);
    final kategoriController = TextEditingController(text: currentData['kategori']);
    final hargaController = TextEditingController(text: currentData['harga'].toString());

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Edit Produk'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: namaController,
                decoration: const InputDecoration(labelText: 'Nama'),
              ),
              TextField(
                controller: kategoriController,
                decoration: const InputDecoration(labelText: 'Kategori'),
              ),
              TextField(
                controller: hargaController,
                decoration: const InputDecoration(labelText: 'Harga'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Batal')),
          ElevatedButton(
            onPressed: () async {
              await firestore.collection('produk').doc(docId).update({
                'nama': namaController.text,
                'kategori': kategoriController.text,
                'harga': int.tryParse(hargaController.text) ?? 0,
                'updated_at': FieldValue.serverTimestamp(),
              });
              Navigator.pop(context);
            },
            child: const Text('Update'),
          )
        ],
      ),
    );
  }

  // --- Hapus Produk ---
  void _hapusProduk(BuildContext context, String docId) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Hapus Produk?'),
        content: const Text('Data akan dihapus permanen.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Batal')),
          ElevatedButton(
            onPressed: () async {
              await firestore.collection('produk').doc(docId).delete();
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }

  // --- Detail Produk (PERBAIKAN: Dipindah ke dalam class) ---
  void _showDetailProduk(BuildContext context, String docId) async {
    final produk = await getProdukById(docId);

    if (produk == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Produk tidak ditemukan')),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Detail Produk'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ID Produk : ${produk['id_produk']}'),
            Text('Nama      : ${produk['nama']}'),
            Text('Kategori  : ${produk['kategori']}'),
            Text('Harga     : Rp${produk['harga']}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Produk'),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestore.collection('produk').orderBy('created_at', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Terjadi kesalahan'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final docs = snapshot.data!.docs;

          if (docs.isEmpty) {
            return const Center(child: Text('Belum ada data produk.'));
          }

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final data = docs[index].data() as Map<String, dynamic>;
              final docId = docs[index].id;

              return Card(
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  title: Text(data['nama'] ?? '-'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('ID: ${data['id_produk'] ?? '-'}'),
                      Text('Kategori: ${data['kategori'] ?? '-'}'),
                      Text('Harga: Rp${data['harga']?.toString() ?? '0'}'),
                    ],
                  ),
                  trailing: PopupMenuButton(
                    itemBuilder: (context) => [
                      const PopupMenuItem(value: 'edit', child: Text('Edit')),
                      const PopupMenuItem(value: 'delete', child: Text('Hapus')),
                    ],
                    onSelected: (value) {
                      if (value == 'edit') {
                        _updateProduk(context, docId, data);
                      } else if (value == 'delete') {
                        _hapusProduk(context, docId);
                      }
                    },
                  ),
                  onTap: () => _showDetailProduk(context, docId),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addProduk(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
