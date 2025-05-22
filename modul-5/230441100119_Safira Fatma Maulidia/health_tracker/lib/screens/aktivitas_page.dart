// File: screens/aktivitas_page.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/aktivitas.dart';
import '../services/aktivitas_service.dart';

class AktivitasPage extends StatefulWidget {
  const AktivitasPage({Key? key}) : super(key: key);

  @override
  State<AktivitasPage> createState() => _AktivitasPageState();
}

class _AktivitasPageState extends State<AktivitasPage> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _kaloriController = TextEditingController();
  final TextEditingController _tanggalController = TextEditingController();
  final TextEditingController _idUserController = TextEditingController();

  final AktivitasService _aktivitasService = AktivitasService();
  Aktivitas? _selectedAktivitas;

  void _clearForm() {
    _namaController.clear();
    _kaloriController.clear();
    _tanggalController.clear();
    _idUserController.clear();
    setState(() {
      _selectedAktivitas = null;
    });
  }

  void _selectDateTime() async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (date != null) {
      TimeOfDay? time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (time != null) {
        final selectedDateTime = DateTime(
          date.year,
          date.month,
          date.day,
          time.hour,
          time.minute,
        );

        _tanggalController.text = DateFormat('yyyy-MM-dd HH:mm').format(selectedDateTime);
      }
    }
  }

  void _submitForm() {
    if (_namaController.text.isEmpty ||
        _kaloriController.text.isEmpty ||
        _tanggalController.text.isEmpty ||
        _idUserController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Semua field harus diisi')),
      );
      return;
    }

    DateTime parsedTanggal;
    try {
      parsedTanggal = DateFormat('yyyy-MM-dd HH:mm').parse(_tanggalController.text);
    } catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Format tanggal tidak valid')),
      );
      return;
    }

    final aktivitas = Aktivitas(
      id: _selectedAktivitas?.id ?? '',
      namaAktivitas: _namaController.text,
      kaloriBakar: int.parse(_kaloriController.text),
      idUser: _idUserController.text,
      tanggal: parsedTanggal,
    );

    if (_selectedAktivitas == null) {
      _aktivitasService.tambahAktivitas(aktivitas);
    } else {
      _aktivitasService.updateAktivitas(_selectedAktivitas!.id, aktivitas);
    }

    _clearForm();
  }

  void _isiForm(Aktivitas aktivitas) {
    _namaController.text = aktivitas.namaAktivitas;
    _kaloriController.text = aktivitas.kaloriBakar.toString();
    _tanggalController.text = DateFormat('yyyy-MM-dd HH:mm').format(aktivitas.tanggal);
    _idUserController.text = aktivitas.idUser;
    setState(() {
      _selectedAktivitas = aktivitas;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Aktivitas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              color: const Color(0xFFF8F0FB),
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextField(
                      controller: _namaController,
                      decoration: const InputDecoration(labelText: 'Nama Aktivitas'),
                    ),
                    TextField(
                      controller: _kaloriController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'Kalori Bakar'),
                    ),
                    TextField(
                      controller: _tanggalController,
                      readOnly: true,
                      onTap: _selectDateTime,
                      decoration: const InputDecoration(labelText: 'Tanggal & Waktu'),
                    ),
                    TextField(
                      controller: _idUserController,
                      decoration: const InputDecoration(labelText: 'ID User'),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                          onPressed: _submitForm,
                          child: Text(_selectedAktivitas == null ? 'Tambah' : 'Edit'),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                          onPressed: _clearForm,
                          child: const Text('Clear', style: TextStyle(color: Colors.purple)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: StreamBuilder<List<Aktivitas>>(
                stream: _aktivitasService.getAktivitas(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('Belum ada data'));
                  }

                  final aktivitasList = snapshot.data!;

                  return ListView.builder(
                    itemCount: aktivitasList.length,
                    itemBuilder: (context, index) {
                      final aktivitas = aktivitasList[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          title: Text(aktivitas.namaAktivitas),
                          subtitle: Text(
                            'Kalori: ${aktivitas.kaloriBakar}, Tanggal: ${DateFormat('yyyy-MM-dd HH:mm').format(aktivitas.tanggal)}',
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit, color: Colors.orange),
                                onPressed: () => _isiForm(aktivitas),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () => _aktivitasService.hapusAktivitas(aktivitas.id),
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
          ],
        ),
      ),
    );
  }
}
