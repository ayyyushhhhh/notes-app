import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:notes_app/bloc/notes_bloc.dart';
import 'package:notes_app/model/notes_model.dart';
import 'package:notes_app/screens/add_notes_screen.dart';
import 'package:notes_app/screens/search_for_notes.dart';
import 'package:notes_app/widgets/StaggeredGridView_widget.dart';

class NotesScreen extends StatefulWidget {
  @override
  _NotesScreenState createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  late List<Notes> notes;
  NotesBloc bloc = NotesBloc();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _searchNotes() {
    return Container(
      height: MediaQuery.of(context).size.height / 12,
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 0),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.black12,
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (BuildContext context) {
              return NotesSearch(
                notes: notes,
                bloc: bloc,
              );
            }),
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Search For Notes"),
            Icon(Icons.search),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: StreamBuilder(
            stream: bloc.getNotesStream,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                notes = snapshot.data;
                if (notes.length == 0) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Nothing Here",
                        style: TextStyle(fontSize: 30),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height / 3,
                        child: SvgPicture.asset("assets/images/nothing.svg",
                            semanticsLabel: 'Acme Logo'),
                      )
                    ],
                  );
                }
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      _searchNotes(),
                      buildAllNotes(notes: notes, bloc: bloc),
                    ],
                  ),
                );
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
      ),
    );
  }
}
