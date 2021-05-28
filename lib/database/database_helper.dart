import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:notes_app/model/notes_model.dart';

final String tableNotesData = "notesData"; // define a tableName

class NotesDatabase {
  NotesDatabase._init(); //create
  static final NotesDatabase instance = NotesDatabase._init();
  static Database? _database;

  // create a getter method for database
  Future<Database?> get database async {
    // check if database already exits
    if (_database != null) {
      return _database;
    }
    // if database doesn't exist then create a new database and return
    _database = await _initDB('notes.db');
    return _database;
  }

  // create new database file
  Future<Database?> _initDB(String fileName) async {
    // create a path for databse file using getDatabasePath;
    final String dbPath = await getDatabasesPath();
    //create a final path by joing the folder and the filename
    final String path = join(dbPath, fileName);
    // use openDatabase function to dave the database file to the given path . make sure to give a version number and onCreate Fuction.
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    // For SQL database we have to define some rules here we have rules for id and String
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    //here we ate executing the SQL Query
    await db.execute('''
    CREATE TABLE $tableNotesData (
      ${NotesField.id} $idType,
      ${NotesField.title} $textType,
      ${NotesField.dateTime} $textType,
      ${NotesField.description} $textType
    )
    ''');
  }
  // Here we will add CRUD functionality

  // CREATE
  //creting the columns and the values of the databse
  Future<Notes> create(Notes note) async {
    //creating the instance of the database
    final db = await instance.database;
    // creating the id for the  each new entry
    final id = await db!.insert(tableNotesData, note.toMap());
    return note.updateWith(id: id);
  }

  // READ
  // Use this code for reading all the note
  Future<List<Notes>> readAllNotes() async {
    // Step 1-  get the instance of the database
    final db = await instance.database;
    // Step 2- create a sorting queery
    final orderBy = '${NotesField.dateTime} ASC';
    // Step 3 - creae get the notes through query method. pass tableName and ordering condition
    final result = await db!.query(tableNotesData, orderBy: orderBy);
    // Step 4 - convert the Map to list from the map function and at the end ue toList() mwthod
    return result.map((json) => (Notes.fromMap(json))).toList();
  }

  // UPDATE
  Future<int> update(Notes note) async {
    // initialize the databse
    final db = await instance.database;
    // use update method to update the note
    return db!.update(tableNotesData, note.toMap(),
        where: '${NotesField.id}=?', whereArgs: [note.id]);
  }

  //DELETE
  Future<int> delete(int id) async {
    // get the instance of the database
    final db = await instance.database;
    // use delete method by passing id as arugment
    return await db!
        .delete(tableNotesData, where: '${NotesField.id}=?', whereArgs: [id]);
  }

  Future close() async {
    final db = await instance.database;
    db!.close();
  }
}
