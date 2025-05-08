import 'package:flutter/material.dart';
import '../models/permintaan_magang.dart';
import '../services/firebase_service.dart';
import 'tambah_data_screen.dart';
import 'update_data_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseService _firebaseService = FirebaseService();
  late Future<List<PermintaanMagang>> _futureData;

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  void _refreshData() {
    setState(() {
      _futureData = _firebaseService.fetchData();
    });
  }

  void _confirmDelete(String id) async {
    final confirmed = await showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: Text('Hapus Data'),
            content: Text('Yakin ingin menghapus data ini?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text('Batal'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: Text('Hapus'),
              ),
            ],
          ),
    );
    if (confirmed) {
      await _firebaseService.deleteData(id);
      _refreshData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE3F2FD),
      appBar: AppBar(
        backgroundColor: Color(0xFF90CAF9),
        title: Text("Data Magang Mahasiswa SI 2025"),
      ),
      body: FutureBuilder<List<PermintaanMagang>>(
        future: _futureData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());

          if (snapshot.hasError)
            return Center(child: Text("Error: ${snapshot.error}"));

          final dataList = snapshot.data ?? [];
          return ListView.builder(
            padding: EdgeInsets.all(12),
            itemCount: dataList.length,
            itemBuilder: (context, index) {
              final item = dataList[index];
              return Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 4,
                margin: EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  title: Text(
                    item.nama,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Perusahaan: ${item.perusahaanTujuan}"),
                      Text("Status: ${item.statusPengajuan}"),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.edit,
                          color: const Color.fromARGB(255, 21, 31, 39),
                        ),
                        onPressed: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => UpdateDataScreen(data: item),
                            ),
                          );
                          _refreshData();
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: const Color.fromARGB(255, 201, 142, 138),
                        ),
                        onPressed: () => _confirmDelete(item.id),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF42A5F5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            30,
          ), // Atur radius sesuai kebutuhan
        ),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => TambahDataScreen()),
          );
          _refreshData();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
