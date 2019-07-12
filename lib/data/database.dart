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
    await db.execute(
        'CREATE TABLE IF NOT EXISTS photos (id INTEGER PRIMARY KEY, photo1 TEXT, photo2 TEXT, photo3 TEXT, studyID INTEGER)');
  } 

  Future<int> savePics(List<String> photos, int studyID) async {
    var dbClient = await db;
    int res;
    List<Map> result = await dbClient.rawQuery('SELECT studyID FROM photos WHERE studyID = \'$studyID\'');
    if(result.length > 0) {
      res = await updatePhotos(studyID, photos);
    } else {
      res = await savePhotos(studyID, photos);
    }
    return res;
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
  
  Future<int> savePhotos(int studyID, List<String> photos) async {
    var dbClient = await db;
    var result = await dbClient.rawInsert('INSERT INTO photos (photo1, photo2, photo3, studyID) VALUES (\'${photos[0]}\', \'${photos[1]}\', \'${photos[2]}\', $studyID)');
    return result;
  }

  Future<int> updatePhotos(int studyID, List<String> photos) async {
    var dbClient = await db;
    return await dbClient.rawUpdate('UPDATE photos SET photo1 = \'${photos[0]}\', photo2 = \'${photos[1]}\', photo3 = \'${photos[2]}\' WHERE studyID = $studyID');
  }

  Future<Map> getPhotos(int studyID) async {
    var dbClient = await db;
    List<Map> result = await dbClient.rawQuery('SELECT * FROM photos WHERE studyID=\'$studyID\'');
    return result.first;
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

  Future<List<Map>> getAnswer(String question, int studyID) async {
    var dbClient = await db;
    List<Map> result = await dbClient.rawQuery('SELECT answer FROM responses WHERE question = \'$question\' AND studyID=\'$studyID\'');
    return result;
  }

  Future<int> getTotalGenderEntries(String gender) async {
    var dbClient = await db;
    String question = 'What is your gender?';
    List<Map> result = await dbClient.rawQuery('SELECT DISTINCT studyID FROM responses WHERE question = \'$question\' AND answer=\'$gender\'');
    return result.length;
  }
  
  Future<List<Map>> getEntries() async {
    var dbClient = await db;
    List<Map> result = await dbClient.rawQuery('SELECT DISTINCT studyID FROM responses');
    return result.toList();
  }
  
  Future<int> getTotalEntries() async {
    var dbClient = await db;
    List<Map> result = await dbClient.rawQuery('SELECT DISTINCT studyID FROM responses');
    return result.length;
  }

  Future<int> getCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(await dbClient.rawQuery('SELECT COUNT(*) FROM responses'));
  }

  Future<int> deleteQuestion(int id) async {
    var dbClient = await db;
    return await dbClient.rawDelete('DELETE FROM responses WHERE id = $id');
  }
  
  Future<int> truncate() async {
    var dbClient = await db;
    List<Map> result = await dbClient.rawQuery('TRUNCATE TABLE responses');
    return result.length;
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}