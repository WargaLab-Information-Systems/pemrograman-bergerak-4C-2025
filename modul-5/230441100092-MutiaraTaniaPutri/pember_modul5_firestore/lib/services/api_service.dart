import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/jadwal_model.dart';

class ApiService {
  static final _firestore = FirebaseFirestore.instance;
  static final _collection = _firestore.collection('jadwal_minum');

  static Future<Map<String, JadwalModel>> fetchJadwal() async {
    final snapshot = await _collection.get();
    final result = <String, JadwalModel>{};

    for (final doc in snapshot.docs) {
      result[doc.id] = JadwalModel.fromJson(doc.data(), id: doc.id);
    }

    return result;
  }

  static Future<void> addJadwal(JadwalModel model) async {
    await _collection.add(model.toMap());
  }

  static Future<void> updateJadwal(String docId, JadwalModel model) async {
    await _collection.doc(docId).update(model.toMap());
  }

  static Future<void> deleteJadwal(String docId) async {
    await _collection.doc(docId).delete();
  }
}
