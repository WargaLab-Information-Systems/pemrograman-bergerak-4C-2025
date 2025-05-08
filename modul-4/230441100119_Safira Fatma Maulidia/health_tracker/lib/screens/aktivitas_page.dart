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
  int nextId = 1;
  int? editIndex;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final data = await AktivitasService.fetchAktivitas();
      data.sort((a, b) => int.parse(a.idAktivitas).compareTo(int.parse(b.idAktivitas)));
      setState(() {
        aktivitasList = data;
        nextId = aktivitasList.isEmpty
            ? 1
            : int.parse(aktivitasList.last.idAktivitas) + 1;
      });
    } catch (e) {
      print('Error: $e');
    }
  }
  
 //tambah
  Future<void> saveData() async {
    if (!_formKey.currentState!.validate()) return;

    final aktivitas = Aktivitas(
      idAktivitas: editIndex == null
          ? nextId.toString()
          : aktivitasList[editIndex!].idAktivitas,
      idUser: idUserController.text,
      kaloriBakar: kaloriController.text,
      namaAktivitas: namaController.text,
      tanggal: tanggalController.text,
    );

    if (editIndex == null) {
      aktivitasList.add(aktivitas);
    } else {
      aktivitasList[editIndex!] = aktivitas;
    }

    final success = await AktivitasService.saveAktivitas(aktivitasList);
    if (success) {
      fetchData();
      clearForm();
    } else {
      print("Gagal menyimpan data");
    }
  }

  //hpus
  Future<void> deleteData(int index) async {
    aktivitasList.removeAt(index);
    final success = await AktivitasService.saveAktivitas(aktivitasList);
    if (success) {
      fetchData();
    } else {
      print("Gagal menghapus data");
    }
  }

  //edit
  void fillForm(int index) {
    final item = aktivitasList[index];
    setState(() {
      namaController.text = item.namaAktivitas;
      kaloriController.text = item.kaloriBakar;
      tanggalController.text = item.tanggal;
      idUserController.text = item.idUser;
      editIndex = index;
    });
  }

//clear
  void clearForm() {
    namaController.clear();
    kaloriController.clear();
    tanggalController.clear();
    idUserController.clear();
    editIndex = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aktivitas'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: namaController,
                        decoration: const InputDecoration(labelText: 'Nama Aktivitas'),
                        validator: (value) => value!.isEmpty ? 'Wajib diisi' : null,
                      ),
                      TextFormField(
                        controller: kaloriController,
                        decoration: const InputDecoration(labelText: 'Kalori Bakar'),
                        keyboardType: TextInputType.number,
                        validator: (value) => value!.isEmpty ? 'Wajib diisi' : null,
                      ),
                      TextFormField(
                        controller: tanggalController,
                        decoration: const InputDecoration(labelText: 'Tanggal (dd/mm/yyyy)'),
                        validator: (value) => value!.isEmpty ? 'Wajib diisi' : null,
                      ),
                      TextFormField(
                        controller: idUserController,
                        decoration: const InputDecoration(labelText: 'ID User'),
                        validator: (value) => value!.isEmpty ? 'Wajib diisi' : null,
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            onPressed: editIndex == null ? saveData : null,
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                            child: const Text('Tambah'),
                          ),
                          ElevatedButton(
                            onPressed: editIndex != null ? saveData : null,
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                            child: const Text('Update'),
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
                  ? const Center(child: Text('Belum ada data aktivitas'))
                  : ListView.builder(
                      itemCount: aktivitasList.length,
                      itemBuilder: (ctx, i) {
                        final item = aktivitasList[i];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            title: Text(item.namaAktivitas),
                            subtitle: Text(
                              'Kalori: ${item.kaloriBakar} kcal\nTanggal: ${item.tanggal}\nUser ID: ${item.idUser}',
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit, color: Colors.orange),
                                  onPressed: () => fillForm(i),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                  onPressed: () => deleteData(i),
                                ),
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
