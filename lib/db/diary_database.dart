import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class DiaryDatabase {
  static const String dbName = 'diary_data_base.db';

  Future<Database> getDatabase() async {
    final databasePath = await getDatabasesPath();
    final fullPath = path.join(databasePath, dbName);
    return await openDatabase(fullPath, onCreate: (db, version) {
      db.execute(
          'CREATE TABLE Diary (id INTEGER PRIMARY KEY AUTOINCREMENT, date TEXT, activity TEXT, description TEXT)');
    }, version: 1);
  }

  Future<void> insertActivity(
      String date, String activity, String description) async {
    final db = await getDatabase();
    await db.insert('Diary',
        {'date': date, 'activity': activity, 'description': description});
  }

  Future<List<Map<String, dynamic>>> getAllDiary() async {
    final db = await getDatabase();
    print(await db.query('Diary'));
    return await db.query('Diary');
  }
}
