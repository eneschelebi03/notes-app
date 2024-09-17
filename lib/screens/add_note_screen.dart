import 'package:flutter/material.dart';
import 'package:mp_project/screens/notes_screen.dart';
import 'package:mp_project/services/db_service.dart';
class AddNoteScreen extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Note Title'),
            ),
            TextField(
              controller: _contentController,
              decoration: InputDecoration(labelText: 'Note Content'),
              maxLines: 5,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    if (_titleController.text.isNotEmpty &&
                        _contentController.text.isNotEmpty) {
                      await DatabaseHelper().insertNote(
                        _titleController.text,
                        _contentController.text,
                      );
                      _titleController.clear();
                      _contentController.clear();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Note added successfully!')),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please fill in all fields.')),
                      );
                    }
                  },
                  child: Text('Save Note'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NotesScreen()),
                    );
                  },
                  child: Text('View Notes'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
