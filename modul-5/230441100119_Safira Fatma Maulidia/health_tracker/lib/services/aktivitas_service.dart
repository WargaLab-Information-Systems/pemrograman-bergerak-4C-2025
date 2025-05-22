import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/aktivitas.dart';

class AktivitasService {
  final CollectionReference _aktivitasRef =
      FirebaseFirestore.instance.collection('aktivitas');

  Future<void> tambahAktivitas(Aktivitas aktivitas) async {
    await _aktivitasRef.add(aktivitas.toMap());
  }

  Future<void> updateAktivitas(String id, Aktivitas aktivitas) async {
    await _aktivitasRef.doc(id).update(aktivitas.toMap());
  }

  Future<void> hapusAktivitas(String id) async {
    await _aktivitasRef.doc(id).delete();
  }

  Stream<List<Aktivitas>> getAktivitas() {
    return _aktivitasRef.orderBy('tanggal', descending: true).snapshots().map(
      (snapshot) {
        return snapshot.docs.map((doc) {
          return Aktivitas.fromMap(doc.data() as Map<String, dynamic>, doc.id);
        }).toList();
      },
    );
  }
}
