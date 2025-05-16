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
  String? idJadwal, tanggal, waktuMinum, catatan;
  String? jumlahAirStr;
  bool isEdit = false;

  @override
  void didChangeDependencies() {
    final args = ModalRoute.of(context)!.settings.arguments;
    if (args != null && args is JadwalModel) {
      isEdit = true;
      idJadwal = args.idJadwal;
      tanggal = args.tanggal;
      waktuMinum = args.waktuMinum;
      jumlahAirStr = args.jumlahAir.toString();
      catatan = args.catatan;
    }
    super.didChangeDependencies();
  }

  Future<void> submit() async {
    if (!_formKey.currentState!.validate()) return;

    final model = JadwalModel(
      idJadwal: idJadwal ?? '',
      tanggal: tanggal ?? '',
      jumlahAir: int.tryParse(jumlahAirStr ?? '0') ?? 0,
      waktuMinum: waktuMinum ?? '',
      catatan: catatan ?? '',
    );

    await ApiService.addJadwal(model);
    Navigator.pop(context);
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
                initialValue: idJadwal,
                decoration: const InputDecoration(labelText: "ID Jadwal"),
                onChanged: (val) => idJadwal = val,
                validator: (val) => val == null || val.isEmpty ? 'Harus diisi' : null,
              ),
              TextFormField(
                initialValue: tanggal,
                decoration: const InputDecoration(labelText: "Tanggal"),
                onChanged: (val) => tanggal = val,
                validator: (val) => val == null || val.isEmpty ? 'Harus diisi' : null,
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
