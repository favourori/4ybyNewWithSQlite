import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  static Database _db;

  DatabaseHelper.internal();

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();

    return _db;
  }

  initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'cs.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE IF NOT EXISTS responses (id INTEGER PRIMARY KEY, question TEXT, answer TEXT, studyID INTEGER)');
  }

  Future<int> save(String question, String answer, int studyID) async {
    var dbClient = await db;
    int res;
    List<Map> result = await dbClient.rawQuery('SELECT studyID FROM responses WHERE studyID = \'$studyID\' AND question = \'$question\'');
    if(result.length > 0) {
      res = await updateQuestion(studyID, question, answer);
    } else {
      res = await saveQuestion(question, answer, studyID);
    }
    return res;
  }
  
  Future<int> saveQuestion(String question, String answer, int studyID) async {
    var dbClient = await db;
    var result = await dbClient.rawInsert('INSERT INTO responses (question, answer, studyID) VALUES (\'$question\', \'$answer\', $studyID)');
    return result;
  }

  Future<int> updateQuestion(int studyID, String question, String answer) async {
    var dbClient = await db;
    return await dbClient.rawUpdate('UPDATE responses SET answer = \'$answer\' WHERE studyID = $studyID AND question = \'$question\'');
  }

  Future<int> getCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(await dbClient.rawQuery('SELECT COUNT(*) FROM responses'));
  }

  Future<int> deleteQuestion(int id) async {
    var dbClient = await db;
    return await dbClient.rawDelete('DELETE FROM responses WHERE id = $id');
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}