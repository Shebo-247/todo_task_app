import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'dart:io';
import '../models/task_model.dart';

class DatabaseHelper {
  static const String tasksTABLE = 'tasks';
  static const String idCOL = 'id';
  static const String titleCOL = 'title';
  static const String dateCOL = 'date';
  static const String isCompletedCOL = 'isCompleted';

  DatabaseHelper._createInstance();

  static DatabaseHelper _databaseHelper =
      DatabaseHelper._createInstance(); // Singleton DatabaseHelper
  static Database _database; // Singleton Database

  // initialize the databaseHelper Singleton
  factory DatabaseHelper() => _databaseHelper;

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }

    return _database;
  }

  Future<Database> initializeDatabase() async {
    // Get the directory path for both android and iOS
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'tasksDB.db');

    // Open or Create the database at a given path
    Database tasksDatabase = await openDatabase(
      path,
      version: 1, // version value must change with every update uploaded.
      onCreate: _createDatabase,
    );
    return tasksDatabase;
  }

  void _createDatabase(Database _db, int version) async {
    await _db.execute(
        "CREATE TABLE $tasksTABLE($idCOL INTEGER PRIMARY KEY AUTOINCREMENT, $titleCOL TEXT, $dateCOL TEXT, $isCompletedCOL INTEGER)");
  }

  // CRUD Methods
  // 1 => FETCH
  Future<List<Task>> getAllTasks() async {
    Database db = await this.database;
    var result = await db.query(tasksTABLE, orderBy: '$dateCOL asc');

    List<Task> _allTasks = [];

    for (int i = 0; i < result.length; i++){
      Task task = Task.map(result[i]);
      _allTasks.add(task);
    }

    return _allTasks;
  }

  Future<Task> getTask(int id) async {
    Database db = await this.database;
    var result =
        await db.rawQuery("SELECT * from $tasksTABLE WHERE $idCOL = $id");
    if (result.length == 0) return null;

    return Task.fromMap(result.first);
  }

  // 2 => INSERT
  Future<int> addTask(Task task) async {
    Database db = await this.database;
    var result = db.insert(tasksTABLE, task.toMap());
    return result;
  }

  // 3 => DELETE
  Future<int> deleteTask(int id) async {
    Database db = await this.database;
    var result = db.delete(tasksTABLE, where: '$idCOL = ?', whereArgs: [id]);
    return result;
  }

  // 4 => UPDATE
  Future<int> updateTask(Task task) async {
    print('${task.id} ${task.title}');
    Database db = await this.database;
    var result = db.update(tasksTABLE, task.toMap(),
        where: '$idCOL = ?', whereArgs: [task.id]);
    return result;
  }

  // Close database
  Future close() async {
    Database db = await this.database;
    return db.close();
  }
}
