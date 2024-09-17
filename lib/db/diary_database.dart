import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class DiaryDatabase {
  static const String dbName = 'diary.db';

  Future<Database> getDatabase() async {
    final databasePath = await getDatabasesPath();
    final fullPath = path.join(databasePath, dbName);
    return await openDatabase(fullPath, onCreate: (db, version) {
      db.execute(
          'CREATE TABLE Activities (id INTEGER PRIMARY KEY AUTOINCREMENT, date TEXT, activity TEXT, description TEXT)');
    }, version: 1);
  }

  Future<void> insertActivity(
      String date, String activity, String description) async {
    final db = await getDatabase();
    await db.insert('Activities',
        {'date': date, 'activity': activity, 'description': description});
  }

  Future<List<Map<String, dynamic>>> getAllActivities() async {
    final db = await getDatabase();
    return await db.query('Activities');
  }
}
