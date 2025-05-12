// screens/add_note_screen.dart
import 'package:flutter/material.dart';
import 'package:modul4/models/notes.dart';
import 'package:modul4/services/notes_service.dart';

class AddNoteScreen extends StatefulWidget {
  final Notes? note;

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
      final createdAt = DateTime.now().toIso8601String();
      final updatedNote = Notes(
        id: widget.note?.id ?? '',
        title: _titleController.text,
        body: _bodyController.text,
        createdAt: createdAt,
      );

      if (widget.note != null) {
        await NotesService.updateNote(widget.note!.id, updatedNote);
      } else {
        await NotesService.addNote(updatedNote);
      }

      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      _titleController.text = widget.note!.title;
      _bodyController.text = widget.note!.body;
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
        title: const Text('Tambah Catatan'),
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
                decoration: InputDecoration(
                  labelText: 'Judul',
                  labelStyle: const TextStyle(color: Color(0xFF00796B)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFF00796B)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFF00796B), width: 2),
                  ),
                  filled: true,
                  fillColor: const Color(0xFFE0F7FA),
                ),
                validator: (value) => value!.isEmpty ? 'Judul tidak boleh kosong' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _bodyController,
                decoration: InputDecoration(
                  labelText: 'Isi Catatan',
                  labelStyle: const TextStyle(color: Color(0xFF00796B)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFF00796B)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFF00796B), width: 2),
                  ),
                  filled: true,
                  fillColor: const Color(0xFFE0F7FA),
                ),
                maxLines: 5,
                validator: (value) => value!.isEmpty ? 'Isi tidak boleh kosong' : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: _submitNote,
                label: const Text('Simpan'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00796B), 
                  foregroundColor: Colors.white, 
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
