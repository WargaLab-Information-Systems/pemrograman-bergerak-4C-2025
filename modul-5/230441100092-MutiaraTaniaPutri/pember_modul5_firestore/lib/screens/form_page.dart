import 'package:flutter/material.dart';
import '../models/jadwal_model.dart';
import '../services/api_service.dart';

class FormPage extends StatefulWidget {
  const FormPage({Key? key}) : super(key: key);

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();
  String? tanggal, waktuMinum, catatan, jumlahAirStr;
  String? firebaseId;
  bool isEdit = false;

  @override
  void didChangeDependencies() {
    final args = ModalRoute.of(context)!.settings.arguments;
    if (args != null && args is Map) {
      final model = args['model'] as JadwalModel?;
      firebaseId = args['firebaseId'] as String?;

      if (model != null) {
        isEdit = true;
        tanggal = model.tanggal;
        waktuMinum = model.waktuMinum;
        jumlahAirStr = model.jumlahAir.toString();
        catatan = model.catatan;
      }
    }
    super.didChangeDependencies();
  }

  Future<void> submit() async {
    if (!_formKey.currentState!.validate()) return;

    final model = JadwalModel(
      tanggal: tanggal ?? '',
      jumlahAir: int.tryParse(jumlahAirStr ?? '0') ?? 0,
      waktuMinum: waktuMinum ?? '',
      catatan: catatan ?? '',
    );

    try {
      if (isEdit && firebaseId != null) {
        await ApiService.updateJadwal(firebaseId!, model);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Berhasil mengupdate data')),
        );
      } else {
        await ApiService.addJadwal(model);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Berhasil menambahkan data')),
        );
      }
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Terjadi kesalahan: $e')),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? "Edit Jadwal" : "Tambah Jadwal")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                readOnly: true,
                controller: TextEditingController(text: tanggal),
                decoration: const InputDecoration(labelText: "Tanggal"),
                onTap: () async {
                  final selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (selectedDate != null) {
                    setState(() {
                      tanggal = "${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}";
                    });
                  }
                },
                validator: (val) => tanggal == null || tanggal!.isEmpty ? 'Harus diisi' : null,
              ),

              TextFormField(
                initialValue: jumlahAirStr,
                decoration: const InputDecoration(labelText: "Jumlah Air (ml)"),
                keyboardType: TextInputType.number,
                onChanged: (val) => jumlahAirStr = val,
                validator: (val) {
                  if (val == null || val.isEmpty) return 'Harus diisi';
                  if (int.tryParse(val) == null) return 'Harus berupa angka';
                  return null;
                },
              ),
              TextFormField(
                initialValue: waktuMinum,
                decoration: const InputDecoration(labelText: "Waktu Minum"),
                onChanged: (val) => waktuMinum = val,
                validator: (val) => val == null || val.isEmpty ? 'Harus diisi' : null,
              ),
              TextFormField(
                initialValue: catatan,
                decoration: const InputDecoration(labelText: "Catatan"),
                onChanged: (val) => catatan = val,
                validator: (val) => val == null || val.isEmpty ? 'Harus diisi' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: submit,
                child: Text(isEdit ? "Simpan Perubahan" : "Tambah"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
