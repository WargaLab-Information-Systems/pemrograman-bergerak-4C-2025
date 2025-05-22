import 'package:flutter/material.dart';
import '../models/aktivitas.dart';
import '../services/aktivitas_service.dart';

class AktivitasPage extends StatefulWidget {
  const AktivitasPage({super.key});

  @override
  State<AktivitasPage> createState() => _AktivitasPageState();
}

class _AktivitasPageState extends State<AktivitasPage> {
  final _formKey = GlobalKey<FormState>();
  final namaController = TextEditingController();
  final kaloriController = TextEditingController();
  final tanggalController = TextEditingController();
  final idUserController = TextEditingController();

  List<Aktivitas> aktivitasList = [];
  Aktivitas? editingItem;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

Future<void> fetchData() async {
  final data = await AktivitasService.fetchAktivitas();
  print('Jumlah data aktivitas: ${data.length}');
  setState(() {
    aktivitasList = data;
  });
}

  Future<void> saveData() async {
    if (!_formKey.currentState!.validate()) return;

    final newAktivitas = Aktivitas(
      idAktivitas: editingItem?.idAktivitas ?? '',
      idUser: idUserController.text,
      kaloriBakar: kaloriController.text,
      namaAktivitas: namaController.text,
      tanggal: tanggalController.text,
    );

    bool success;
    if (editingItem == null) {
      success = await AktivitasService.addAktivitas(newAktivitas);
    } else {
      success = await AktivitasService.updateAktivitas(newAktivitas);
    }

    if (success) {
      fetchData();
      clearForm();
    }
  }

  Future<void> deleteData(Aktivitas aktivitas) async {
    final success = await AktivitasService.deleteAktivitas(aktivitas.idAktivitas);
    if (success) {
      fetchData();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gagal menghapus data')),
      );
    }
  }

  void fillForm(Aktivitas item) {
    setState(() {
      editingItem = item;
      namaController.text = item.namaAktivitas;
      kaloriController.text = item.kaloriBakar;
      tanggalController.text = item.tanggal;
      idUserController.text = item.idUser;
    });
  }

  void clearForm() {
    namaController.clear();
    kaloriController.clear();
    tanggalController.clear();
    idUserController.clear();
    editingItem = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Aktivitas'), backgroundColor: Colors.blue),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Card(
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: namaController,
                        decoration: const InputDecoration(labelText: 'Nama Aktivitas'),
                        validator: (v) => v!.isEmpty ? 'Wajib diisi' : null,
                      ),
                      TextFormField(
                        controller: kaloriController,
                        decoration: const InputDecoration(labelText: 'Kalori Bakar'),
                        keyboardType: TextInputType.number,
                        validator: (v) => v!.isEmpty ? 'Wajib diisi' : null,
                      ),
                      TextFormField(
                        controller: tanggalController,
                        decoration: const InputDecoration(labelText: 'Tanggal (yyyy/mm/dd)'),
                        validator: (v) => v!.isEmpty ? 'Wajib diisi' : null,
                      ),
                      TextFormField(
                        controller: idUserController,
                        decoration: const InputDecoration(labelText: 'ID User'),
                        validator: (v) => v!.isEmpty ? 'Wajib diisi' : null,
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: saveData,
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                            child: Text(editingItem == null ? 'Tambah' : 'Update'),
                          ),
                          ElevatedButton(
                            onPressed: clearForm,
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                            child: const Text('Clear'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: aktivitasList.isEmpty
                  ? const Center(child: Text('Belum ada data'))
                  : ListView.builder(
                      itemCount: aktivitasList.length,
                      itemBuilder: (ctx, i) {
                        final item = aktivitasList[i];
                        return Card(
                          child: ListTile(
                            title: Text(item.namaAktivitas),
                            subtitle: Text(
                                'Kalori: ${item.kaloriBakar}\nTanggal: ${item.tanggal}\nUser ID: ${item.idUser}'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit, color: Colors.orange),
                                  onPressed: () => fillForm(item),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                  onPressed: () => deleteData(item),
                                )
                              ],
                            ),
                          ),
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
