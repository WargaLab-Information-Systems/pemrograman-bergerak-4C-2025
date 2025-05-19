import 'package:flutter/material.dart';
import 'package:mysql/screens/login_screen.dart';
import '../services/service.dart';
import '../models/model.dart';
import 'toko_form.dart';
import 'toko_detail.dart';
// Pastikan file login_page.dart ada dan terhubung

class DoaPage extends StatefulWidget {
  @override
  _DoaPageState createState() => _DoaPageState();
}

class _DoaPageState extends State<DoaPage> {
  late Future<List<toko>> futureDoa;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  Future<void> _refreshData() async {
    final future = DoaService.fetchDoa();
    setState(() {
      _isLoading = true;
      futureDoa = future;
    });

    try {
      await future;
    } catch (e) {
      // Bisa log atau abaikan
    }

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _deleteDoa(int id) async {
    try {
      await DoaService.deleteDoa(id);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Data berhasil dihapus')),
      );
      _refreshData();
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menghapus data: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Toko Laptop Lenovo'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _refreshData,
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : FutureBuilder<List<toko>>(
              future: futureDoa,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Error: ${snapshot.error}'),
                        SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: _refreshData,
                          child: Text('Coba Lagi'),
                        ),
                      ],
                    ),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Tidak ada data'),
                        SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => DoaForm(
                                  onSave: _refreshData,
                                ),
                              ),
                            );
                          },
                          child: Text('Tambah Data'),
                        ),
                      ],
                    ),
                  );
                }

                final doaList = snapshot.data!;
                return ListView.builder(
                  itemCount: doaList.length,
                  itemBuilder: (context, index) {
                    final doa = doaList[index];
                    return Card(
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      elevation: 2,
                      child: ListTile(
                        title: Text(
                          doa.nama ?? 'Tanpa Nama Produk',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Harga: Rp ${doa.harga ?? "-"}'),
                            Text('Kategori: ${doa.kategori ?? "-"}'),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit, color: Colors.blue),
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => DoaForm(
                                      doa: doa,
                                      onSave: _refreshData,
                                    ),
                                  ),
                                );
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                    title: Text('Konfirmasi'),
                                    content: Text('Apakah Anda yakin ingin menghapus data ini?'),
                                    actions: [
                                      TextButton(
                                        child: Text('Batal'),
                                        onPressed: () => Navigator.of(ctx).pop(),
                                      ),
                                      TextButton(
                                        child: Text('Hapus'),
                                        onPressed: () {
                                          Navigator.of(ctx).pop();
                                          if (doa.id_laptop != null) {
                                            _deleteDoa(doa.id_laptop!);
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => DoaDetailPage(doa: doa),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => DoaForm(
                onSave: _refreshData,
              ),
            ),
          );
        },
        child: Icon(Icons.add),
        tooltip: 'Tambah Data',
      ),
    );
  }
}
