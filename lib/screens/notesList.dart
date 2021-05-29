import 'package:flutter/material.dart';
import 'package:notes_app/bloc/notes_bloc.dart';
import 'package:notes_app/model/notes_model.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:notes_app/screens/add_notes_screen.dart';

class NotesScreen extends StatefulWidget {
  @override
  _NotesScreenState createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  List<Notes> allNotes = [];
  NotesBloc bloc = NotesBloc();
  @override
  void initState() {
    super.initState();
    // _refreshAllNotes();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(10),
        child: StreamBuilder(
          stream: bloc.getNotesStream,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              return _buildAllNotes(snapshot.data);
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => AddNotesScreen(
                bloc: bloc,
              ),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildAllNotes(List<Notes> notes) {
    return StaggeredGridView.countBuilder(
      itemCount: notes.length,
      staggeredTileBuilder: (int index) {
        return StaggeredTile.count(1, index.isEven ? 1.2 : 1.8);
      },
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 12,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (BuildContext context) {
                  return AddNotesScreen(
                    note: notes[index],
                    bloc: bloc,
                  );
                }),
              );
            },
            child: _notesContainer(notes[index]));
      },
    );
  }

  Container _notesContainer(Notes note) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(int.parse(note.color)),
      ),
      child: Text(
        note.title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 30,
        ),
      ),
    );
  }
}
