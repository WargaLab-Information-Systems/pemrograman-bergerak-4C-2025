// screens/notes_screen.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modul4/screens/add_note_screen.dart';
import 'package:modul4/utils/date_formatter.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key});

  Stream<List<Map<String, dynamic>>> _streamNotes() {
    return FirebaseFirestore.instance.collection('notes').snapshots().map(
      (snapshot) {
        return snapshot.docs.map((doc) {
          final data = doc.data();
          return {
            'id': doc.id,
            'title': data['title'],
            'body': data['body'],
            'createdAt': (data['createdAt'] as Timestamp).toDate().toIso8601String(),
          };
        }).toList();
      },
    );
  }

  Future<void> _deleteNote(String id) async {
    try {
      await FirebaseFirestore.instance.collection('notes').doc(id).delete();
    } catch (e) {
      throw Exception('Gagal menghapus catatan: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE0F7FA),
      appBar: AppBar(
        title: const Text('Notes'),
        backgroundColor: const Color(0xFF00796B),
        foregroundColor: Colors.white,
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: _streamNotes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF00796B))));
          } else if (snapshot.hasError) {
            return Center(child: Text('Terjadi Kesalahan: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Tidak ada catatan'));
          } else {
            final notesList = snapshot.data!;
            notesList.sort((a, b) => b['createdAt'].compareTo(a['createdAt']));
            return ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: notesList.length,
              itemBuilder: (context, index) {
                final note = notesList[index];
                return Card(
                  color: const Color(0xFFB2EBF2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 6,
                  shadowColor: const Color(0xFF004D40),
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.notes, color: Color(0xFF00796B)),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                note['title'],
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF004D40),
                                ),
                              ),
                            ),
                            PopupMenuButton<String>(
                              onSelected: (value) async {
                                if (value == 'edit') {
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AddNoteScreen(note: note),
                                    ),
                                  );
                                } else if (value == 'delete') {
                                  await _deleteNote(note['id']);
                                }
                              },
                              itemBuilder: (context) => [
                                const PopupMenuItem(
                                  value: 'edit',
                                  child: ListTile(
                                    leading: Icon(Icons.edit, color: Colors.green),
                                    title: Text('Edit'),
                                  ),
                                ),
                                const PopupMenuItem(
                                  value: 'delete',
                                  child: ListTile(
                                    leading: Icon(Icons.delete, color: Colors.red),
                                    title: Text('Hapus'),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          note['body'],
                          style: const TextStyle(fontSize: 16, color: Color(0xFF00796B)),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Icon(Icons.access_time, size: 16, color: Color(0xFF004D40)),
                            const SizedBox(width: 4),
                            Text(
                              formatTanggal(note['createdAt']),
                              style: const TextStyle(fontSize: 12, color: Color(0xFF004D40)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddNoteScreen()),
          );
        },
        backgroundColor: const Color(0xFF00796B),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
