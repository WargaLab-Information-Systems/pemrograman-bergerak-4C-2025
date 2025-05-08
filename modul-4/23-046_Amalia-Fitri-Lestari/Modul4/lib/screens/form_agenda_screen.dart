
import 'package:flutter/material.dart';
import '../model/agenda.dart';
import '../service/agenda_service.dart';

class FormAgendaScreen extends StatefulWidget {
  final Agenda? agenda;
  const FormAgendaScreen({super.key, this.agenda});

  @override
  State<FormAgendaScreen> createState() => _FormAgendaScreenState();
}

class _FormAgendaScreenState extends State<FormAgendaScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _judulController = TextEditingController();
  final TextEditingController _tanggalController = TextEditingController();
  final TextEditingController _lokasiController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.agenda != null) {
      _judulController.text = widget.agenda!.judul;
      _tanggalController.text = widget.agenda!.tanggal;
      _lokasiController.text = widget.agenda!.lokasi;
    }
  }

  @override
  void dispose() {
    _judulController.dispose();
    _tanggalController.dispose();
    _lokasiController.dispose();
    super.dispose();
  }

  void _saveAgenda() async {
    if (_formKey.currentState!.validate()) {
      final newAgenda = Agenda(
        id: widget.agenda?.id ?? '',
        judul: _judulController.text,
        tanggal: _tanggalController.text,
        lokasi: _lokasiController.text,
      );

      if (widget.agenda == null) {
        await AgendaService.addAgenda(newAgenda);
      } else {
        await AgendaService.updateAgenda(newAgenda);
      }

      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink, // Warna pink untuk AppBar
        title: Text(widget.agenda == null ? 'Tambah Agenda' : 'Edit Agenda'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(  // Untuk mencegah overflow jika keyboard muncul
          child: Card(
            elevation: 8, 
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12), 
            ),
            color: Colors.white, 
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _judulController,
                      decoration: InputDecoration(
                        labelText: 'Judul',
                        labelStyle: TextStyle(color: Colors.pink),  
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.pink), 
                          borderRadius: BorderRadius.circular(8), // 
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.pinkAccent, width: 2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      ),
                      validator: (value) => value == null || value.isEmpty ? 'Wajib diisi' : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _tanggalController,
                      decoration: InputDecoration(
                        labelText: 'Tanggal',
                        labelStyle: TextStyle(color: Colors.pink),  
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.pink),
                          borderRadius: BorderRadius.circular(8), 
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.pinkAccent, width: 2), // Warna garis saat form difokuskan
                          borderRadius: BorderRadius.circular(8),
                        ),
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      ),
                      validator: (value) => value == null || value.isEmpty ? 'Wajib diisi' : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _lokasiController,
                      decoration: InputDecoration(
                        labelText: 'Lokasi',
                        labelStyle: TextStyle(color: Colors.pink),  
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.pink), 
                          borderRadius: BorderRadius.circular(8), 
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.pinkAccent, width: 2), 
                          borderRadius: BorderRadius.circular(8),
                        ),
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      ),
                      validator: (value) => value == null || value.isEmpty ? 'Wajib diisi' : null,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _saveAgenda,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink,  
                        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Simpan',
                        style: TextStyle(
                          fontSize: 16, 
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

