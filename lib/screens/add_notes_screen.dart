import 'package:flutter/material.dart';
import 'package:notes_app/bloc/notes_bloc.dart';
import 'package:notes_app/model/notes_model.dart';

class AddNotesScreen extends StatefulWidget {
  final Notes? note;
  final NotesBloc bloc;
  AddNotesScreen({this.note, required this.bloc});
  @override
  _AddNotesScreenState createState() => _AddNotesScreenState();
}

class _AddNotesScreenState extends State<AddNotesScreen> {
  String title = "";
  String description = "";
  String? dateTime;

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      title = widget.note!.title;
      description = widget.note!.description;
    }
  }

  void _saveNewDatabase() async {
    Notes note = Notes(
        title: title.toString(),
        dateTime: DateTime.now().toIso8601String(),
        description: description.toString());
    await widget.bloc.addNewNote(note);
  }

  void _updateDatabase() async {
    final note = widget.note!.updateWith(
        title: title.toString(),
        description: description.toString(),
        dateTime: DateTime.now().toIso8601String());
    await widget.bloc.updateNewNote(note);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              if (widget.note != null) {
                _updateDatabase();
              } else {
                _saveNewDatabase();
              }
              Navigator.pop(context);
            },
            icon: Icon(Icons.done),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              TextField(
                controller: TextEditingController()..text = title.toString(),
                onChanged: (value) {
                  title = value;
                },
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                  hintText: "Title",
                  hintStyle:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  border: InputBorder.none,
                ),
              ),
              SizedBox(
                height: 3,
              ),
              TextField(
                controller: TextEditingController()
                  ..text = description.toString(),
                onChanged: (value) {
                  description = value;
                },
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                  hintText: "Notes",
                  hintStyle:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  border: InputBorder.none,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
