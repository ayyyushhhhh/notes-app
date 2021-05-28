class NotesField {
  static String id =
      "_id"; // it is important to use _ in front of id because it is set up by sqflite
  static String title = "title";
  static String dateTime = "dateTime";
  static String description = "description";

  static final List<String> values = [
    id,
    title,
    dateTime,
    description,
  ];
}

class Notes {
  static String notesData = "notesData";
  int? id;
  late String title;
  late String dateTime;
  late String description;

  Notes(
      {this.id,
      required this.title,
      required this.dateTime,
      required this.description});

  static Notes fromMap(Map<String, dynamic> map) {
    return Notes(
        title: map[NotesField.title] as String,
        dateTime: map[NotesField.dateTime] as String,
        description: map[NotesField.description] as String,
        id: map[NotesField.id] as int);
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      NotesField.id: id,
      NotesField.title: title,
      NotesField.description: description,
      NotesField.dateTime: dateTime,
    };
    return map;
  }

  Notes updateWith(
      {int? id, String? title, String? dateTime, String? description}) {
    return Notes(
        id: id ?? this.id,
        title: title ?? this.title,
        dateTime: dateTime ?? this.dateTime,
        description: description ?? this.description);
  }
}
