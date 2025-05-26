import 'package:flutter/material.dart';
import 'package:alat_musik_tradisional/models/alat_musik.dart';
import 'package:alat_musik_tradisional/services/alat_musik_service.dart';
import 'alat_musik_form_screen.dart';

class AlatMusikListScreen extends StatefulWidget {
  @override
  _AlatMusikListScreenState createState() => _AlatMusikListScreenState();
}

class _AlatMusikListScreenState extends State<AlatMusikListScreen> {
  List<AlatMusik> alatMusikList = [];

  @override
  void initState() {
    super.initState();
    fetchAlatMusik();
  }

  Future<void> fetchAlatMusik() async {
    final data = await AlatMusikService().getAlatMusik();
    setState(() {
      alatMusikList = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Daftar Alat Musik',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue.shade600,
        elevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: fetchAlatMusik,
        child: ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: alatMusikList.length,
          itemBuilder: (context, index) {
            final alat = alatMusikList[index];
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 3,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                title: Text(
                  alat.namaAlat,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue.shade800,
                  ),
                ),
                subtitle: Text(
                  '${alat.asalDaerah} • ${alat.jenis}',
                  style: const TextStyle(color: Colors.black54),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AlatMusikFormScreen(alatMusik: alat),
                          ),
                        ).then((_) => fetchAlatMusik());
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () async {
                        await AlatMusikService().deleteAlatMusik(alat.id);
                        fetchAlatMusik();
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AlatMusikFormScreen()),
          );
          fetchAlatMusik();
        },
        backgroundColor: Colors.blue.shade600,
        child: const Icon(Icons.add, color: Colors.white,),
      ),
    );
  }
}
