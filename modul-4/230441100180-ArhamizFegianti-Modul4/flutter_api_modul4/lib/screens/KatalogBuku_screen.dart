import 'package:flutter/material.dart';
import 'package:flutter_api_modul4/crud_page.dart';
import 'package:flutter_api_modul4/models/katalog_buku.dart';
import 'package:flutter_api_modul4/services/KatalogBuku_service.dart';

class KatalogbukuScreen extends StatefulWidget {
  const KatalogbukuScreen({super.key});

  @override
  State<KatalogbukuScreen> createState() => _KatalogbukuScreenState();
}

class _KatalogbukuScreenState extends State<KatalogbukuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Katalog Buku',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
        ),
        centerTitle: true,
      ),

      backgroundColor: Colors.pink[50],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddBookScreen()),
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
        backgroundColor: Colors.pink,
      ),

      body: FutureBuilder<List<KatalogBuku>>(
        future: KatalogbukuService.fetchKatalogBuku(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('terjadi kesalahan: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('no data found'));
          } else if (snapshot.hasData) {
            final katalog_bukuList = snapshot.data!;
            return ListView.builder(
              itemCount: katalog_bukuList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(katalog_bukuList[index].kode_buku),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        katalog_bukuList[index].judul,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(katalog_bukuList[index].penerbit),
                    ],
                  ),

                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.teal),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => AddBookScreen(
                                    book: katalog_bukuList[index],
                                  ),
                            ),
                          ).then((_) => setState(() {}));
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.pink),
                        onPressed: () async {
                          final confirm = await showDialog(
                            context: context,
                            builder:
                                (ctx) => AlertDialog(
                                  title: const Text('Hapus Buku'),
                                  content: const Text(
                                    'Yakin ingin menghapus buku ini?',
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed:
                                          () => Navigator.pop(ctx, false),
                                      child: const Text('Batal'),
                                    ),
                                    TextButton(
                                      onPressed: () => Navigator.pop(ctx, true),
                                      child: const Text('Hapus'),
                                    ),
                                  ],
                                ),
                          );

                          if (confirm == true) {
                            await KatalogbukuService.deleteKatalogBuku(
                              katalog_bukuList[index].docId,
                            );
                            setState(() {}); 
                          }
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('no data found'));
          }
        },
      ),
    );
  }
}
