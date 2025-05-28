import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:toko_kain/model_barang.dart';

class BarangService {
  static final CollectionReference _barangCollection = FirebaseFirestore
      .instance
      .collection('data_kain');

  static Future<List<Barang>> fetchBarang() async {
    final snapshot = await _barangCollection.get();
    return snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      final barang = Barang.fromJson(data);
      return barang.copyWith(id: doc.id);
    }).toList();
  }

  static Future<void> addBarang(Barang barang) async {
    await _barangCollection.add(barang.toJson());
  }

  static Future<void> updateBarang(Barang barang) async {
    await _barangCollection.doc(barang.id).update(barang.toJson());
  }

  static Future<void> deleteBarang(String id) async {
    await _barangCollection.doc(id).delete();
  }
}
