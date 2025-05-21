import 'package:flutter/material.dart';
import 'package:modul5amin/formpage.dart';
import '../models/aksesoris_models.dart';
import '../service/aksesoris_service.dart';
import 'formpage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}
//  menyimpan list aksesoris yang akan ditampilkan
class _HomePageState extends State<HomePage> {
  List<Aksesoris> daftarAksesoris = [];

  @override
  void initState() {
    super.initState();
    loadData(); // memanggil fungsi loadData saat halaman pertama kali dibuka
  }
//meanggil data dari server dan ditampilkan ke dalam list
  Future<void> loadData() async {
    final data = await AksesorisService.fetchAksesoris();
    setState(() {
      daftarAksesoris = data;
    });
  }
// menghapus data aksesoris berdasarkan id
  void hapusData(String id) async {
    await AksesorisService.deleteAksesoris(id);
    loadData();
  }

  void bukaForm({Aksesoris? item}) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => FormPage(aksesoris: item),
      ),
    );
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Data Aksesoris')),
      body: ListView.builder(
        itemCount: daftarAksesoris.length,
        itemBuilder: (context, index) {
          final item = daftarAksesoris[index];
          return ListTile(
            title: Text(item.nama_aksesoris),
            subtitle: Text('Harga: Rp${item.harga} | Stok: ${item.stok}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.blue),
                  onPressed: () => bukaForm(item: item),
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () => hapusData(item.id_aksesoris),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => bukaForm(),
        child: Icon(Icons.add),
      ),
    );
  }
}
