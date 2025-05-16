import 'package:flutter/material.dart';
import '../models/agenda.dart';
import '../services/agenda_services.dart';

class AgendaFormScreen extends StatefulWidget {
  final Agenda? agenda;

  const AgendaFormScreen({super.key, this.agenda});

  @override
  State<AgendaFormScreen> createState() => _AgendaFormScreenState();
}

class _AgendaFormScreenState extends State<AgendaFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _detailController = TextEditingController();
  final _tanggalController = TextEditingController();
  final _lokasiController = TextEditingController();
  final AgendaService _service = AgendaService();

  @override
  void initState() {
    super.initState();
    if (widget.agenda != null) {
      _namaController.text = widget.agenda!.nama;
      _detailController.text = widget.agenda!.detail;
      _tanggalController.text = widget.agenda!.tanggal;
      _lokasiController.text = widget.agenda!.lokasi;
    }
  }

  @override
  void dispose() {
    _namaController.dispose();
    _detailController.dispose();
    _tanggalController.dispose();
    _lokasiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.agenda == null ? 'Tambah Agenda' : 'Edit Agenda'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextField(_namaController, 'Nama Agenda'),
              _buildTextField(_detailController, 'Detail Agenda', maxLines: 3),
              _buildTextField(
                _tanggalController,
                'Tanggal',
                hint: 'YYYY-MM-DD',
              ),
              _buildTextField(_lokasiController, 'Lokasi'),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _saveAgenda,
                child: const Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label, {
    int maxLines = 1,
    String? hint,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: const OutlineInputBorder(),
        ),
        validator:
            (value) =>
                (value == null || value.isEmpty) ? '$label harus diisi' : null,
      ),
    );
  }

  Future<void> _saveAgenda() async {
    if (!_formKey.currentState!.validate()) return;

    final agenda = Agenda(
      id: widget.agenda?.id ?? 0,
      nama: _namaController.text,
      detail: _detailController.text,
      tanggal: _tanggalController.text,
      lokasi: _lokasiController.text,
    );

    try {
      if (widget.agenda == null) {
        await _service.createAgenda(agenda);
        if (!mounted) return;
        _showMessage('Agenda berhasil ditambahkan');
      } else {
        await _service.updateAgenda(agenda);
        if (!mounted) return;
        _showMessage('Agenda berhasil diperbarui');
      }

      if (!mounted) return;
      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;
      _showMessage('Error: $e');
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}
