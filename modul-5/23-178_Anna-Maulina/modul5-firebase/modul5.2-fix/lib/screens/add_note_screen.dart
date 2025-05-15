// screens/add_note_screen.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddNoteScreen extends StatefulWidget {
  final Map<String, dynamic>? note;

  const AddNoteScreen({super.key, this.note});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();

  Future<void> _submitNote() async {
    if (_formKey.currentState!.validate()) {
      final data = {
        'title': _titleController.text,
        'body': _bodyController.text,
        'createdAt': Timestamp.fromDate(DateTime.now()),
      };

      final collection = FirebaseFirestore.instance.collection('notes');

      try {
        if (widget.note != null) {
          await collection.doc(widget.note!['id']).update(data);
        } else {
          await collection.add(data);
        }
        Navigator.pop(context);
      } catch (e) {
        throw Exception('Gagal menyimpan catatan: $e');
      }
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      _titleController.text = widget.note!['title'];
      _bodyController.text = widget.note!['body'];
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE0F7FA),
      appBar: AppBar(
        title: Text(widget.note == null ? 'Tambah Catatan' : 'Edit Catatan'),
        backgroundColor: const Color(0xFF00796B),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Judul',
                  labelStyle: TextStyle(color: Color(0xFF00796B)),
                  enabledBorder: OutlineInputBorder(),
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value == null || value.isEmpty ? 'Judul tidak boleh kosong' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _bodyController,
                decoration: const InputDecoration(
                  labelText: 'Isi Catatan',
                  labelStyle: TextStyle(color: Color(0xFF00796B)),
                  enabledBorder: OutlineInputBorder(),
                  border: OutlineInputBorder(),
                ),
                maxLines: 5,
                validator: (value) => value == null || value.isEmpty ? 'Isi catatan tidak boleh kosong' : null,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _submitNote,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00796B),
                  foregroundColor: Colors.white,
                ),
                child: const Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
