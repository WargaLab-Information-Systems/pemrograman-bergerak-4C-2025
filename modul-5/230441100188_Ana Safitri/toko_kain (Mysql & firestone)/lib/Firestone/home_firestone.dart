import 'package:flutter/material.dart';
import 'package:toko_kain/Firestone/services/barang_firestore_service.dart';
import 'package:toko_kain/model_barang.dart';

class HomeFirestore extends StatefulWidget {
  const HomeFirestore({super.key});

  @override
  State<HomeFirestore> createState() => _HomeFirestoreState();
}

class _HomeFirestoreState extends State<HomeFirestore> {
  final FirestoreService _service = FirestoreService();
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
      final data = await _service.getBarang();
      setState(() => _barangList = data);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal load data: ${e.toString()}')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _deleteBarang(String id) async {
    try {
      await _service.deleteBarang(id);
      await _loadData();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal hapus data: ${e.toString()}')),
      );
    }
  }

  void _openForm({Barang? barang}) async {
    final result = await showDialog(
      context: context,
      builder: (context) {
        final _namaController = TextEditingController(text: barang?.nama);
        final _ukuranController = TextEditingController(
          text: barang?.panjang.toString() ?? '',
        );
        final _warnaController = TextEditingController(text: barang?.warna);

        return AlertDialog(
          title: Text(barang == null ? 'Tambah Kain' : 'Edit Kain'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: _namaController,
                  decoration: const InputDecoration(labelText: 'Nama'),
                ),
                TextField(
                  controller: _ukuranController,
                  decoration: const InputDecoration(labelText: 'Ukuran'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: _warnaController,
                  decoration: const InputDecoration(labelText: 'Warna'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () async {
                final newBarang = Barang(
                  id: barang?.id ?? '',
                  nama: _namaController.text,
                  panjang: double.tryParse(_ukuranController.text) ?? 0,
                  warna: _warnaController.text,
                );
                if (barang == null) {
                  await _service.addBarang(newBarang);
                } else {
                  await _service.updateBarang(newBarang);
                }
                Navigator.pop(context, true);
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );

    if (result == true) await _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF1F3),
      appBar: AppBar(
        backgroundColor: Colors.pink[200],
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 2,
        title: const Text(
          'Toko Kain (Firestore)',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
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
