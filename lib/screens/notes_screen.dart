import 'package:flutter/material.dart';
import 'package:mp_project/screens/add_note_screen.dart';
import 'package:mp_project/screens/note_details_screen.dart';
import 'package:mp_project/services/db_service.dart';
class NotesScreen extends StatefulWidget {
  @override
  _NotesScreenState createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  late Future<List<Map<String, dynamic>>> _notes;

  @override
  void initState() {
    super.initState();
    _notes = DatabaseHelper().getNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Notes'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _notes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No notes found.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 4,
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(snapshot.data![index]['title']),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NoteDetailScreen(
                            title: snapshot.data![index]['title'],
                            content: snapshot.data![index]['content'],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddNoteScreen()),
          );
        },
        child: Icon(Icons.add),
        tooltip: 'Add Note',
      ),
    );
  }
}
