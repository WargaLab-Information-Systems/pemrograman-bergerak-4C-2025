import 'package:flutter/material.dart';
import '../model/barang.dart';
import '../services/barang_service.dart';
import 'form_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
// menyimpan semua data barang
class _HomeScreenState extends State<HomeScreen> {
  List<Barang> barangList = [];
// mengambil barang
  Future<void> fetchBarang() async {
    final data = await BarangService.getBarang();
    setState(() {
      barangList = data;
    });
  }
// otomatis dipanggil ketika hlm awal dibuka
  @override
  void initState() {
    super.initState();
    fetchBarang();
  }

  void deleteBarang(String id) async {
    await BarangService.deleteBarang(id);
    fetchBarang();
  }
// untuk menmbh atau edit di hlm from
  void navigateToForm({Barang? barang}) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => FormScreen(barang: barang)),
    );
    fetchBarang();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Daftar Barang")),
      body: ListView.builder( 
        itemCount: barangList.length,
        itemBuilder: (context, index) {
          final barang = barangList[index];
          return ListTile(
            title: Text(barang.namaBarang),
            subtitle: Text("Rp${barang.harga} • Stok: ${barang.stok}"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.blue),
                  onPressed: () => navigateToForm(barang: barang),
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () => deleteBarang(barang.id!),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => navigateToForm(),
        child: Icon(Icons.add),
      ),
    );
  }
}
