import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/jadwal_model.dart';

class LaporanPage extends StatefulWidget {
  const LaporanPage({Key? key}) : super(key: key);

  @override
  _LaporanPageState createState() => _LaporanPageState();
}

class _LaporanPageState extends State<LaporanPage> {
  List<MapEntry<String, JadwalModel>> data = [];

  Future<void> getData() async {
    try {
      final response = await ApiService.fetchJadwal();
      setState(() {
        data = response.entries.toList();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal memuat data: $e')),
      );
    }
  }

  Future<void> deleteData(String firebaseId) async {
    await ApiService.deleteJadwal(firebaseId);
    await getData();
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Laporan Jadwal Air")),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          final entry = data[index];
          final item = entry.value;
          return Card(
            margin: const EdgeInsets.all(10),
            elevation: 3,
            child: ListTile(
              title: Text('${item.waktuMinum} - ${item.jumlahAir} ml'),
              subtitle: Text('${item.tanggal}\n${item.catatan}'),
              isThreeLine: true,
              trailing: Wrap(
                spacing: 10,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      Navigator.pushNamed(context, '/form', arguments: item)
                          .then((_) => getData());
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => deleteData(entry.key),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Navigator.pushNamed(context, '/form').then((_) => getData()),
        child: const Icon(Icons.add),
      ),
    );
  }
}
