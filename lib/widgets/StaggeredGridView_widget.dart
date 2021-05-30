import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:notes_app/bloc/notes_bloc.dart';
import 'package:notes_app/model/notes_model.dart';
import 'package:notes_app/screens/add_notes_screen.dart';
import 'package:notes_app/widgets/notes_container.dart';

Widget buildAllNotes({required List<Notes> notes, required NotesBloc bloc}) {
  return StaggeredGridView.countBuilder(
    shrinkWrap: true,
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
          child: notesContainer(notes[index]));
    },
  );
}
