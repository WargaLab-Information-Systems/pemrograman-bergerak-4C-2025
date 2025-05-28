import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:toko_kain/model_barang.dart';

class FirestoreService {
  final CollectionReference _barangCollection = FirebaseFirestore.instance
      .collection('data_kain');

  // ✅ GET all data
  Future<List<Barang>> getBarang() async {
    final snapshot = await _barangCollection.get();
    return snapshot.docs.map((doc) {
      return Barang.fromFirestore(doc.data() as Map<String, dynamic>, doc.id);
    }).toList();
  }

  // ✅ POST (Add data)
  Future<void> addBarang(Barang barang) async {
    await _barangCollection.add(barang.toFirestore());
  }

  // ✅ PUT (Update data)
  Future<void> updateBarang(Barang barang) async {
    await _barangCollection.doc(barang.id).update(barang.toFirestore());
  }

  // ✅ DELETE data
  Future<void> deleteBarang(String id) async {
    await _barangCollection.doc(id).delete();
  }
}
