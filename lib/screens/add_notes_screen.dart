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
  String? color = "0xFF0000FF";

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      title = widget.note!.title;
      description = widget.note!.description;
      color = widget.note!.color;
    }
  }

  void _saveNewDatabase() async {
    Notes note = Notes(
        title: title.toString(),
        dateTime: DateTime.now().toIso8601String(),
        description: description.toString(),
        color: color.toString());
    await widget.bloc.addNewNote(note);
  }

  void _updateDatabase() async {
    final updatedNote = widget.note!.updateWith(
        title: title.toString(),
        description: description.toString(),
        dateTime: DateTime.now().toIso8601String(),
        color: color.toString());
    await widget.bloc.updateNewNote(updatedNote);
  }

  void _deleteDatabase() async {
    if (widget.note != null) {
      await widget.bloc.deleteNote(widget.note!.id!);
    } else {
      Navigator.pop(context);
    }
  }

  void _showBottomModal(BuildContext scaffoldContext) {
    showModalBottomSheet(
        context: scaffoldContext,
        isDismissible: true,
        builder: (BuildContext context) {
          return Container(
            height: MediaQuery.of(scaffoldContext).size.height,
            margin: EdgeInsets.all(10),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Select Colour",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                ),
                _buildColor(0xFF000080),
                _buildColor(0xFF000000),
                _buildColor(0xFFFF0000),
                _buildColor(0xFFFF6347),
              ],
            ),
          );
        });
  }

  Widget _buildColor(int colorCode) {
    return Flexible(
      child: ListTile(
        onTap: () {
          setState(() {
            color = colorCode.toString();
          });
        },
        tileColor: Color(colorCode),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(int.tryParse(color.toString())!),
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
          IconButton(
            onPressed: () {
              _deleteDatabase();
              if (widget.note != null) {
                Navigator.pop(context);
              }
            },
            icon: Icon(Icons.delete),
          ),
          IconButton(
            onPressed: () {
              _showBottomModal(context);
            },
            icon: Icon(Icons.more_vert),
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
