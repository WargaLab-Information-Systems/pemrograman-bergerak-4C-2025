import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AgendaScreen extends StatefulWidget {
  @override
  _AgendaScreenState createState() => _AgendaScreenState();
}

class _AgendaScreenState extends State<AgendaScreen> {
  final CollectionReference _agendaCollection = FirebaseFirestore.instance
      .collection('agenda');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Daftar Agenda')),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.lightBlue[100]!, Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: StreamBuilder<QuerySnapshot>(
          stream: _agendaCollection.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError)
              return Center(child: Text("Error: ${snapshot.error}"));
            if (snapshot.connectionState == ConnectionState.waiting)
              return Center(child: CircularProgressIndicator());

            final data = snapshot.data!.docs;

            if (data.isEmpty) return 
            Center(child: Text("Belum ada agenda"));

            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final doc = data[index];
                final agenda = doc.data() as Map<String, dynamic>;
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  elevation: 4,
                  child: ListTile(
                    title: Text(
                      agenda['namaagenda'] ?? '-',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Deskripsi: ${agenda['Deskripsi']}"),
                        Text("Lokasi: ${agenda['Lokasi']}"),
                        Text(
                          "Tanggal: ${agenda['Tanggal'].toDate().toLocal()}",
                        ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          color: Colors.blue,
                          tooltip: 'Edit',
                          onPressed:
                              () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (_) => EditAgendaScreen(
                                        id: doc.id,
                                        data: agenda,
                                      ),
                                ),
                              ),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed:
                              () => _showDeleteConfirmationDialog(doc.id),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => TambahAgendaScreen()),
            ),
        child: Icon(Icons.add),
        
      ),
    );
  }

  void _showDeleteConfirmationDialog(String docId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Konfirmasi Hapus"),
          content: Text("Apakah Anda yakin ingin menghapus agenda ini?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Batal"),
            ),
            TextButton(
              onPressed: () async {
                await _agendaCollection.doc(docId).delete();
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Hapus"),
            ),
          ],
        );
      },
    );
  }
}

class TambahAgendaScreen extends StatefulWidget {
  @override
  _TambahAgendaScreenState createState() => _TambahAgendaScreenState();
}

class _TambahAgendaScreenState extends State<TambahAgendaScreen> {
  final _formKey = GlobalKey<FormState>();
  final namaController = TextEditingController();
  final deskripsiController = TextEditingController();
  final lokasiController = TextEditingController();
  DateTime? tanggal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tambah Agenda")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: namaController,
                decoration: InputDecoration(labelText: 'Nama Agenda'),
                validator: (val) => val!.isEmpty ? 'Harus diisi' : null,
              ),
              TextFormField(
                controller: deskripsiController,
                decoration: InputDecoration(labelText: 'Deskripsi'),
              ),
              TextFormField(
                controller: lokasiController,
                decoration: InputDecoration(labelText: 'Lokasi'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  final selected = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2100),
                  );
                  if (selected != null) {
                    setState(() => tanggal = selected);
                  }
                },
                child: Text(
                  tanggal == null
                      ? 'Pilih Tanggal'
                      : 'Tanggal: ${tanggal!.toLocal()}',
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (!_formKey.currentState!.validate() || tanggal == null)
                    return;

                  await FirebaseFirestore.instance.collection('agenda').add({
                    'namaagenda': namaController.text,
                    'Deskripsi': deskripsiController.text,
                    'Lokasi': lokasiController.text,
                    'Tanggal': tanggal,
                  });

                  Navigator.pop(context);
                },
                child: Text("Simpan"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EditAgendaScreen extends StatefulWidget {
  final String id;
  final Map<String, dynamic> data;

  EditAgendaScreen({required this.id, required this.data});

  @override
  _EditAgendaScreenState createState() => _EditAgendaScreenState();
}

class _EditAgendaScreenState extends State<EditAgendaScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController namaController;
  late TextEditingController deskripsiController;
  late TextEditingController lokasiController;
  DateTime? tanggal;

  @override
  void initState() {
    super.initState();
    namaController = TextEditingController(text: widget.data['namaagenda']);
    deskripsiController = TextEditingController(text: widget.data['Deskripsi']);
    lokasiController = TextEditingController(text: widget.data['Lokasi']);
    tanggal = widget.data['Tanggal'].toDate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Agenda")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: namaController,
                decoration: InputDecoration(labelText: 'Nama Agenda'),
                validator: (val) => val!.isEmpty ? 'Harus diisi' : null,
              ),
              TextFormField(
                controller: deskripsiController,
                decoration: InputDecoration(labelText: 'Deskripsi'),
              ),
              TextFormField(
                controller: lokasiController,
                decoration: InputDecoration(labelText: 'Lokasi'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  final selected = await showDatePicker(
                    context: context,
                    initialDate: tanggal ?? DateTime.now(),
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2100),
                  );
                  if (selected != null) {
                    setState(() => tanggal = selected);
                  }
                },
                child: Text(
                  tanggal == null
                      ? 'Pilih Tanggal'
                      : 'Tanggal: ${tanggal!.toLocal()}',
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (!_formKey.currentState!.validate() || tanggal == null)
                    return;

                  await FirebaseFirestore.instance
                      .collection('agenda')
                      .doc(widget.id)
                      .update({
                        'namaagenda': namaController.text,
                        'Deskripsi': deskripsiController.text,
                        'Lokasi': lokasiController.text,
                        'Tanggal': tanggal,
                      });

                  Navigator.pop(context);
                },
                child: Text("Simpan Perubahan"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
