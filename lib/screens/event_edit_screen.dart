import 'package:flutter/material.dart';

import '../models/event_model.dart';

class EventEditScreen extends StatefulWidget {
  static const routeName = '/event-edit';

  const EventEditScreen({Key? key}) : super(key: key);

  @override
  State<EventEditScreen> createState() => _EventEditScreenState();
}

class _EventEditScreenState extends State<EventEditScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  final _locationCtrl = TextEditingController();
  final _imageCtrl = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String? _editingId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args != null && args is Event) {
      _editingId = args.id;
      _titleCtrl.text = args.title;
      _descCtrl.text = args.description;
      _locationCtrl.text = args.location;
      _imageCtrl.text = args.imageUrl ?? '';
      _selectedDate = args.date;
    }
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _descCtrl.dispose();
    _locationCtrl.dispose();
    _imageCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final d = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now().subtract(const Duration(days: 3650)),
      lastDate: DateTime.now().add(const Duration(days: 3650)),
    );
    if (d != null) setState(() => _selectedDate = d);
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    final id = _editingId ?? DateTime.now().millisecondsSinceEpoch.toString();
    final event = Event(
      id: id,
      title: _titleCtrl.text.trim(),
      description: _descCtrl.text.trim(),
      date: _selectedDate,
      location: _locationCtrl.text.trim(),
      imageUrl: _imageCtrl.text.trim().isEmpty ? null : _imageCtrl.text.trim(),
    );
    Navigator.of(context).pop(event);
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = _editingId != null;
    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Éditer événement' : 'Créer événement')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _titleCtrl,
                  decoration: const InputDecoration(labelText: 'Titre'),
                  validator: (v) => (v == null || v.trim().isEmpty) ? 'Titre requis' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _descCtrl,
                  decoration: const InputDecoration(labelText: 'Description'),
                  maxLines: 4,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _locationCtrl,
                  decoration: const InputDecoration(labelText: 'Lieu'),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: Text('Date: ${_selectedDate.toLocal().toString().split(' ')[0]}'),
                    ),
                    TextButton(onPressed: _pickDate, child: const Text('Choisir')),
                  ],
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _imageCtrl,
                  decoration: const InputDecoration(labelText: 'Image (URL)'),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Annuler')),
                    const SizedBox(width: 12),
                    ElevatedButton(onPressed: _save, child: const Text('Enregistrer')),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
