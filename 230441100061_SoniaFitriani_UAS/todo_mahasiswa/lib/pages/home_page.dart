import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import '../models/task_model.dart';
import '../widgets/tugas_card.dart';
import '../widgets/kategori_filter.dart';
import 'tambah_page.dart';
import 'detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ref = FirebaseDatabase.instance.ref().child('tugas');
  List<Tugas> tugasList = [];
  String selectedKategori = 'All';

  @override
  void initState() {
    super.initState();
    ref.onValue.listen((event) {
      final data = event.snapshot.value as Map?;
      tugasList.clear();
      if (data != null) {
        data.forEach((key, value) {
          tugasList.add(Tugas.fromJson(key, Map<String, dynamic>.from(value)));
        });
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Tugas> filtered = selectedKategori == 'All'
        ? tugasList
        : tugasList.where((e) => e.kategori == selectedKategori).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("To-Do List Mahasiswa"),
        actions: [
          KategoriFilter(
            selectedValue: selectedKategori,
            onChanged: (val) => setState(() => selectedKategori = val),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: filtered.length,
        itemBuilder: (context, index) {
          final tugas = filtered[index];
          return TugasCard(
            tugas: tugas,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => DetailPage(tugas: tugas)),
              );
            },
            onCheck: () {
              ref.child(tugas.id).update({'selesai': !tugas.selesai});
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const TambahPage()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
