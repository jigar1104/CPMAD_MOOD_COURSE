import 'package:flutter/material.dart';
import '../models/note.dart';
import '../db/notes_database.dart';

class AddEditNoteScreen extends StatefulWidget {
  final Note? note;

  const AddEditNoteScreen({super.key, this.note});

  @override
  State<AddEditNoteScreen> createState() => _AddEditNoteScreenState();
}

class _AddEditNoteScreenState extends State<AddEditNoteScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descController;
  String _selectedPriority = 'Medium';

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note?.title ?? '');
    _descController = TextEditingController(
      text: widget.note?.description ?? '',
    );
    _selectedPriority = widget.note?.priority ?? 'Medium';
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  Future<void> _saveNote() async {
    if (_formKey.currentState!.validate()) {
      final now = DateTime.now().toIso8601String().substring(0, 10);
      if (widget.note == null) {
        // Create new
        final newNote = Note(
          title: _titleController.text.trim(),
          description: _descController.text.trim(),
          priority: _selectedPriority,
          createdAt: now,
        );
        await NotesDatabase.instance.createNote(newNote);
      } else {
        // Update existing
        final updatedNote = widget.note!.copyWith(
          title: _titleController.text.trim(),
          description: _descController.text.trim(),
          priority: _selectedPriority,
        );
        await NotesDatabase.instance.updateNote(updatedNote);
      }
      if (mounted) Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.note != null;
    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Edit Note' : 'Create New Note')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
                validator: (val) =>
                    val == null || val.trim().isEmpty ? 'Title required' : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: _selectedPriority,
                decoration: const InputDecoration(
                  labelText: 'Priority Level',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'High',
                    child: Text('High Priority (Urgent)'),
                  ),
                  DropdownMenuItem(
                    value: 'Medium',
                    child: Text('Medium Priority (Standard)'),
                  ),
                  DropdownMenuItem(
                    value: 'Low',
                    child: Text('Low Priority (Backlog)'),
                  ),
                ],
                onChanged: (val) {
                  if (val != null) setState(() => _selectedPriority = val);
                },
              ),
              const SizedBox(height: 16),
              Expanded(
                child: TextFormField(
                  controller: _descController,
                  maxLines: null,
                  expands: true,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: const InputDecoration(
                    labelText: 'Note Content',
                    border: OutlineInputBorder(),
                  ),
                  validator: (val) => val == null || val.trim().isEmpty
                      ? 'Content required'
                      : null,
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: _saveNote,
                icon: const Icon(Icons.save),
                label: Text(isEditing ? 'Update Note' : 'Save Note to SQLite'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
