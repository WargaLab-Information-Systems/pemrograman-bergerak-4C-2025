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
  late TextEditingController tanggalController;

  DateTime? selectedDate;
  String? idJadwal, tanggal, waktuMinum, catatan;
  String? jumlahAirStr;
  bool isEdit = false;

  @override
  void initState() {
    super.initState();
    tanggalController = TextEditingController();
  }

  @override
  void dispose() {
    tanggalController.dispose();
    super.dispose();
  }

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

      tanggalController.text = tanggal ?? '';
    }
    super.didChangeDependencies();
  }

  Future<void> submit() async {
    if (!_formKey.currentState!.validate()) return;

    if (tanggal == null || tanggal!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tanggal belum diisi')),
      );
      return;
    }

    final model = JadwalModel(
      idJadwal: idJadwal ?? '',
      tanggal: tanggal!,
      jumlahAir: int.tryParse(jumlahAirStr ?? '0') ?? 0,
      waktuMinum: waktuMinum ?? '',
      catatan: catatan ?? '',
    );

    try {      
      if (isEdit) {
        await ApiService.updateJadwal(model);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Berhasil mengedit data')),
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
        SnackBar(content: Text('Gagal menyimpan data: $e')),
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
                controller: tanggalController,
                readOnly: true,
                decoration: const InputDecoration(labelText: "Tanggal"),
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: selectedDate ?? DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );

                  if (picked != null) {
                    setState(() {
                      selectedDate = picked;
                      tanggal = "${picked.toIso8601String().split('T')[0]}";
                      tanggalController.text = tanggal!;
                    });
                  }
                },
                validator: (val) =>
                    val == null || val.isEmpty ? 'Harus diisi' : null,
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
                validator: (val) =>
                    val == null || val.isEmpty ? 'Harus diisi' : null,
              ),
              TextFormField(
                initialValue: catatan,
                decoration: const InputDecoration(labelText: "Catatan"),
                onChanged: (val) => catatan = val,
                validator: (val) =>
                    val == null || val.isEmpty ? 'Harus diisi' : null,
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