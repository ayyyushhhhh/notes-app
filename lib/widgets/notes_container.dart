import 'package:flutter/material.dart';
import 'package:notes_app/model/notes_model.dart';

Container notesContainer(Notes note) {
  return Container(
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Color(int.parse(note.color)),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          note.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        Expanded(
          child: Container(
            //color: Colors.red,
            child: Text(
              note.description,
              style: TextStyle(
                fontSize: 15,
              ),
              // overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    ),
  );
}
