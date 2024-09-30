import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

class DiaryDatabase {
  static const String dbName = 'diary_data_base.db';

  Future<Database> getDatabase() async {
    final databasePath = await getDatabasesPath();
    final fullPath = path.join(databasePath, dbName);
    return await openDatabase(fullPath, onCreate: (dataBase, version) {
      dataBase.execute(
          'CREATE TABLE Diary (id INTEGER PRIMARY KEY AUTOINCREMENT, date TEXT, activity TEXT, description TEXT)',);
    }, version: 1,);
  }

  Future<void> insertActivity(
      String date, String activity, String description,) async {
    final dataBase = await getDatabase();
    await dataBase.insert('Diary',
        {'date': date, 'activity': activity, 'description': description},);
  }

  Future<List<Map<String, dynamic>>> getAllDiary() async {
    final dataBase = await getDatabase();
    return await dataBase.query('Diary');
  }
}
