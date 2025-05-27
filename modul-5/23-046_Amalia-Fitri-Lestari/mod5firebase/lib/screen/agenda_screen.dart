import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'form_agenda_screen.dart'; 
import '../../model/agenda_model.dart';


class AgendaScreen extends StatefulWidget {
  const AgendaScreen({super.key});

  @override
  State<AgendaScreen> createState() => _AgendaScreenState();
}

class _AgendaScreenState extends State<AgendaScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fungsi untuk menghapus agenda berdasarkan ID dokumen (bukan field 'id')
  void _deleteAgenda(String docId) async {
    try {
      await _firestore.collection('Agenda').doc(docId).delete();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Agenda berhasil dihapus')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menghapus agenda: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Agenda'),
        backgroundColor: Colors.pinkAccent,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('Agenda').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('Belum ada agenda.'));
          } else {
            final agendas = snapshot.data!.docs;
            return ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: agendas.length,
              itemBuilder: (context, index) {
                var agendaDoc = agendas[index];
                var data = agendaDoc.data() as Map<String, dynamic>;
                return Card(
                  color: Colors.pink[50],
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ListTile(
                    title: Text(
                      data['judul'] ?? '',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 6),
                        Text('Tanggal: ${data['tanggal'] ?? ''}'),
                        Text('Lokasi: ${data['lokasi'] ?? ''}'),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () {
                            // Navigasi ke FormTambahAgendaScreen untuk edit agenda
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FormTambahAgendaScreen(
                                  agenda: Agenda.fromMap(
                                    agendaDoc.id,
                                    data,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteAgenda(agendaDoc.id),
                        ),
                      ],
                    ),
                    onTap: () {
                      
                    },
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pinkAccent,
        onPressed: () {
          // Navigasi ke FormTambahAgendaScreen untuk tambah agenda baru
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const FormTambahAgendaScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
