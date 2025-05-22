import 'package:flutter/material.dart';
import '../model/agenda.dart';
import '../service/agenda_service.dart';
import 'form_agenda_screen.dart';

class AgendaScreen extends StatefulWidget {
  const AgendaScreen({super.key});

  @override
  State<AgendaScreen> createState() => _AgendaScreenState();
}

class _AgendaScreenState extends State<AgendaScreen> {
  late Future<List<Agenda>> _agendaList;

  @override
  void initState() {
    super.initState();
    _loadAgenda();
  }

  void _loadAgenda() {
    setState(() {
      _agendaList = AgendaService.fetchAgenda(); // Memanggil fetchAgenda untuk load data
    });
  }

  void _deleteAgenda(String id) async {
    await AgendaService.deleteAgenda(id);  // Menghapus agenda berdasarkan ID
    _loadAgenda();  // Memuat ulang agenda setelah dihapus
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Agenda'),
        backgroundColor: Colors.pinkAccent,
      ),
      body: FutureBuilder<List<Agenda>>(
        future: _agendaList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Belum ada agenda.'));
          } else {
            final agendas = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: agendas.length,
              itemBuilder: (context, index) {
                final agenda = agendas[index];
                return Card(
                  color: Colors.pink[50],
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: ListTile(
                    title: Text(agenda.judul,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 6),
                        Text('Tanggal: ${agenda.tanggal}'),
                        Text('Lokasi: ${agenda.lokasi}'),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FormAgendaScreen(agenda: agenda),
                              ),
                            );
                            _loadAgenda(); // Muat ulang data setelah edit
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteAgenda(agenda.id),
                        ),
                      ],
                    ),
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FormAgendaScreen(agenda: agenda),
                        ),
                      );
                      _loadAgenda(); // Muat ulang data setelah klik
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
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const FormAgendaScreen(),
            ),
          );
          _loadAgenda(); // Muat ulang data setelah tambah agenda
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
