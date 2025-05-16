import 'package:flutter/material.dart';
import '../models/agenda.dart';
import '../services/agenda_services.dart';
import 'agenda_form_screen.dart';
import 'agenda_detail_screen.dart';

class AgendaListScreen extends StatefulWidget {
  @override
  _AgendaListScreenState createState() => _AgendaListScreenState();
}

class _AgendaListScreenState extends State<AgendaListScreen> {
  final AgendaService _service = AgendaService();
  late Future<List<Agenda>> _agendasFuture;

  @override
  void initState() {
    super.initState();
    _refreshAgendas();
  }

  void _refreshAgendas() {
    setState(() {
      _agendasFuture = _service.getAgendas();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Agenda'),
        actions: [
          IconButton(icon: Icon(Icons.refresh), onPressed: _refreshAgendas),
        ],
      ),
      body: FutureBuilder<List<Agenda>>(
        future: _agendasFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${snapshot.error}'),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _refreshAgendas,
                    child: Text('Coba Lagi'),
                  ),
                ],
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Tidak ada agenda'));
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final agenda = snapshot.data![index];
              return Card(
                margin: EdgeInsets.all(8),
                child: ListTile(
                  title: Text(agenda.nama),
                  subtitle: Text('${agenda.tanggal} - ${agenda.lokasi}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => AgendaDetailScreen(agenda: agenda),
                      ),
                    ).then((_) => _refreshAgendas());
                  },
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => AgendaFormScreen(agenda: agenda),
                            ),
                          ).then((_) => _refreshAgendas());
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _confirmDelete(agenda.id),
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
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AgendaFormScreen()),
          ).then((_) => _refreshAgendas());
        },
      ),
    );
  }

  Future<void> _confirmDelete(int id) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi'),
          content: Text('Apakah Anda yakin ingin menghapus agenda ini?'),
          actions: <Widget>[
            TextButton(
              child: Text('Batal'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('Hapus', style: TextStyle(color: Colors.red)),
              onPressed: () async {
                Navigator.of(context).pop();
                try {
                  await _service.deleteAgenda(id);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Agenda berhasil dihapus')),
                  );
                  _refreshAgendas();
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Gagal menghapus: $e')),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }
}
