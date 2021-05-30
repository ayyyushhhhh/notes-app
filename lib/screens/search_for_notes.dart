import 'package:flutter/material.dart';
import 'package:notes_app/bloc/notes_bloc.dart';
import 'package:notes_app/model/notes_model.dart';
import 'package:notes_app/widgets/StaggeredGridView_widget.dart';

class NotesSearch extends StatefulWidget {
  final List<Notes> notes;
  final NotesBloc bloc;
  NotesSearch({required this.notes, required this.bloc});
  @override
  _NotesSearchState createState() => _NotesSearchState();
}

class _NotesSearchState extends State<NotesSearch> {
  late TextEditingController _searchController;
  List<Notes> _filteredNotes = [];
  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _searchController.addListener(() {
      _searchQuery();
    });
  }

  void _searchQuery() {
    List<Notes> allNotes = [];
    allNotes.addAll(widget.notes);
    if (_searchController.text.isNotEmpty) {
      allNotes.retainWhere((note) {
        String searchTerm = _searchController.text.toLowerCase();
        String title = note.title.toLowerCase();
        String description = note.description.toLowerCase();
        if (title.contains(searchTerm)) {
          return true;
        } else if (description.contains(searchTerm)) {
          return true;
        }
        return false;
      });
      setState(() {
        _filteredNotes = allNotes;
      });
    } else {
      setState(() {
        _filteredNotes.removeRange(0, _filteredNotes.length);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(20),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 12,
              width: double.infinity,
              margin: EdgeInsets.symmetric(vertical: 20, horizontal: 0),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.black12,
              ),
              child: TextField(
                controller: _searchController,
                autofocus: true,
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: "Search For Notes"),
              ),
            ),
            buildAllNotes(notes: _filteredNotes, bloc: widget.bloc),
            // ListView.builder(
            //   shrinkWrap: true,
            //   itemCount: _filteredNotes.length,
            //   itemBuilder: (BuildContext context, int index) {
            //     return Container(
            //       margin: EdgeInsets.symmetric(vertical: 10),
            //       decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(20),
            //         color: Colors.black12,
            //       ),
            //       child: Column(
            //         mainAxisAlignment: MainAxisAlignment.start,
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           Text(
            //             _filteredNotes[index].title,
            //           ),
            //           Text(
            //             _filteredNotes[index].description,
            //           ),
            //         ],
            //       ),
            //     );
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
