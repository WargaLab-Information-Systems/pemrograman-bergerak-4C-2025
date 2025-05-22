import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/agenda_model.dart';

class AgendaService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fungsi untuk menambah agenda
  static Future<void> addAgenda(Agenda agenda) async {
    try {
      await _firestore.collection('Agenda').add(agenda.toMap());
    } catch (e) {
      throw Exception('Gagal menambahkan agenda: $e');
    }
  }

  // Fungsi untuk mengupdate agenda
  static Future<void> updateAgenda(Agenda agenda) async {
    try {
      await _firestore.collection('Agenda').doc(agenda.id).update(agenda.toMap());
    } catch (e) {
      throw Exception('Gagal mengupdate agenda: $e');
    }
  }
}
