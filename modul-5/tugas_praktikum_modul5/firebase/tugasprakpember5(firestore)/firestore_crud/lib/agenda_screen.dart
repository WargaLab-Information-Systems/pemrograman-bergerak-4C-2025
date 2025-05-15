import 'tambah_agenda.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'edit_agenda.dart';
import 'package:intl/intl.dart';

class agendascreen extends StatelessWidget {
  const agendascreen({Key? key}) : super(key: key);

  void _deleteAgenda(BuildContext context, String documentId) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Konfirmasi'),
        content: const Text('Apakah Anda yakin ingin menghapus agenda ini?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Hapus', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await FirebaseFirestore.instance.collection('agenda').doc(documentId).delete();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Agenda berhasil dihapus')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final CollectionReference agenda = FirebaseFirestore.instance.collection('agenda');

    return Scaffold(
      backgroundColor: Colors.white, 
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true, 
        title: const Text(
          "Daftar Agenda",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: agenda.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('Belum ada data agenda'));
          }

          final agendaList = snapshot.data!.docs;

          return ListView.builder(
            itemCount: agendaList.length,
            itemBuilder: (context, index) {
              final data = agendaList[index];
              final documentId = data.id;

              final namaAgenda = data['nama_agenda'] ?? 'Tanpa Judul';
              final deskripsi = data['deskripsi'] ?? '-';
              final lokasi = data['lokasi'] ?? '-';
              final timestamp = data['tanggal'] as Timestamp?;
              final tanggal = timestamp != null
                  ? DateFormat('dd MMMM yyyy – kk:mm').format(timestamp.toDate())
                  : 'Tanggal tidak tersedia';

              return Card(
                color: Colors.white,
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                elevation: 2,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Text(
                      namaAgenda[0].toUpperCase(),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  title: Text(
                    namaAgenda,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Deskripsi: $deskripsi'),
                      Text('Lokasi: $lokasi'),
                      Text('Tanggal: $tanggal'),
                    ],
                  ),
                  isThreeLine: true,
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditAgenda(documentId: documentId),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteAgenda(context, documentId),
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
        backgroundColor: Colors.blue,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const TambahAgenda()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
