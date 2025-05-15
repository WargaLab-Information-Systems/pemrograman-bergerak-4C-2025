import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class EditAgenda extends StatefulWidget {
  final String documentId;
  const EditAgenda({Key? key, required this.documentId}) : super(key: key);

  @override
  State<EditAgenda> createState() => _EditAgendaState();
}

class _EditAgendaState extends State<EditAgenda> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _deskripsiController = TextEditingController();
  final TextEditingController _lokasiController = TextEditingController();
  DateTime? _tanggal;

  @override
  void initState() {
    super.initState();
    _getAgenda();
  }

  void _getAgenda() async {
    final docSnapshot = await FirebaseFirestore.instance
        .collection('agenda')
        .doc(widget.documentId)
        .get();

    if (docSnapshot.exists) {
      setState(() {
        _namaController.text = docSnapshot['nama_agenda'];
        _deskripsiController.text = docSnapshot['deskripsi'];
        _lokasiController.text = docSnapshot['lokasi'];
        _tanggal = (docSnapshot['tanggal'] as Timestamp).toDate();
      });
    }
  }

  void _updateAgenda() async {
    if (_formKey.currentState!.validate() && _tanggal != null) {
      await FirebaseFirestore.instance
          .collection('agenda')
          .doc(widget.documentId)
          .update({
        'nama_agenda': _namaController.text,
        'deskripsi': _deskripsiController.text,
        'lokasi': _lokasiController.text,
        'tanggal': _tanggal
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Agenda berhasil diperbarui')),
      );

      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lengkapi semua data terlebih dahulu')),
      );
    }
  }

  void _selectDateTime(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _tanggal ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_tanggal ?? DateTime.now()),
      );

      if (pickedTime != null) {
        setState(() {
          _tanggal = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final formatTanggal = _tanggal != null
        ? DateFormat('dd MMM yyyy – HH:mm').format(_tanggal!)
        : 'Pilih Tanggal & Jam';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Edit Agenda',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _namaController,
                decoration: InputDecoration(
                  labelText: 'Nama Agenda',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                validator: (value) => value!.isEmpty ? 'Wajib diisi' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _deskripsiController,
                decoration: InputDecoration(
                  labelText: 'Deskripsi',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                validator: (value) => value!.isEmpty ? 'Wajib diisi' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _lokasiController,
                decoration: InputDecoration(
                  labelText: 'Lokasi',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                validator: (value) => value!.isEmpty ? 'Wajib diisi' : null,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      formatTanggal,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => _selectDateTime(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Pilih Tanggal & Jam'),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _updateAgenda,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Update', style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
