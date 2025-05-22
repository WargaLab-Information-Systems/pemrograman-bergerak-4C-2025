import 'package:flutter/material.dart';
import '../../model/agenda_model.dart';
import '../../service/agenda_service.dart';

class FormTambahAgendaScreen extends StatefulWidget {
  final Agenda? agenda; // Menambahkan parameter agenda untuk edit agenda

  const FormTambahAgendaScreen({super.key, this.agenda});

  @override
  State<FormTambahAgendaScreen> createState() => _FormTambahAgendaScreenState();
}

class _FormTambahAgendaScreenState extends State<FormTambahAgendaScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _judulController = TextEditingController();
  final TextEditingController _tanggalController = TextEditingController();
  final TextEditingController _lokasiController = TextEditingController();

  @override
  void initState() {
    super.initState();
    
    // Jika ada agenda yang diterima, isi controller dengan data yang ada
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

  // Fungsi untuk menyimpan atau mengedit agenda
  void _saveAgenda() async {
    if (_formKey.currentState!.validate()) {
      final newAgenda = Agenda(
        id: widget.agenda?.id ?? '', // Gunakan ID agenda yang ada jika ada (untuk edit)
        judul: _judulController.text,
        tanggal: _tanggalController.text,
        lokasi: _lokasiController.text,
      );

      try {
        // Simpan atau update agenda
        if (widget.agenda != null) {
          // Update agenda yang sudah ada
          await AgendaService.updateAgenda(newAgenda);
        } else {
          // Tambahkan agenda baru
          await AgendaService.addAgenda(newAgenda);
        }

        // Kembali ke halaman sebelumnya setelah simpan
        Navigator.pop(context);
      } catch (e) {
        // Menampilkan pesan error jika gagal menyimpan
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal menyimpan agenda: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.agenda == null ? 'Tambah Agenda' : 'Edit Agenda'),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _judulController,
                decoration: const InputDecoration(
                  labelText: 'Judul Agenda',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value == null || value.isEmpty ? 'Wajib diisi' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _tanggalController,
                decoration: const InputDecoration(
                  labelText: 'Tanggal',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value == null || value.isEmpty ? 'Wajib diisi' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _lokasiController,
                decoration: const InputDecoration(
                  labelText: 'Lokasi',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value == null || value.isEmpty ? 'Wajib diisi' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveAgenda,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pinkAccent,
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                ),
                child: Text(
                  widget.agenda == null ? 'Simpan Agenda' : 'Update Agenda',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
