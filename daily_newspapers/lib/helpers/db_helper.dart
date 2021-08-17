import 'package:daily_newspapers/constants/newspapers.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelper {
  static final savedNewsTableName = "user_favourite_news";
  static final selectedNewsPapersTableName = "selected_newspapers";
  static AllNewsPapers firstNewsPaper;

  static Future<sql.Database> createDatabase(String tableName) async {
    final dbPath = await sql.getDatabasesPath();

    final selectedNewsPapersTableNameTable =
        "CREATE TABLE $selectedNewsPapersTableName(title TEXT , imageUrl TEXT PRIMARY KEY)";
    final savedNewsPapersTable =
        "CREATE TABLE $savedNewsTableName(id TEXT PRIMARY KEY, title TEXT, description TEXT, image TEXT, link TEXT)";
    return await sql.openDatabase(
      path.join(dbPath, "news.db"),
      onCreate: (db, version) async {
        await db.execute(selectedNewsPapersTableNameTable);
        await db.execute(savedNewsPapersTable);
        return;
      },
      version: 1,
    );
  }

  static Future<void> insert(
    String table,
    Map<String, Object> data,
  ) async {
    final db = await DBHelper.createDatabase(table);
    db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.createDatabase(table);
    if (table == DBHelper.selectedNewsPapersTableName) {
      var dataList = await db
          .rawQuery('SELECT * FROM ${DBHelper.selectedNewsPapersTableName}');
      return dataList;
    } else if (table == DBHelper.savedNewsTableName) {
      var dataList =
          await db.rawQuery('SELECT * FROM ${DBHelper.savedNewsTableName}');
      return dataList;
    }
    return null;
  }

  static Future<AllNewsPapers> getFirstNewsPaper() async {
    final newsPapersList = await getData(DBHelper.selectedNewsPapersTableName);
    if (newsPapersList.isNotEmpty) {
      final firstNewsPaperTitle = newsPapersList[0]["title"];
      print(firstNewsPaperTitle);
      AllNewsPapers.values.forEach((element) {
        if (element.toString() == firstNewsPaperTitle) {
          firstNewsPaper = element;
        }
      });
    }
    return null;
  }

  static Future<void> deleteData(String table, String newsPaper) async {
    final db = await DBHelper.createDatabase(table);
    db.delete(table, where: "title = ?", whereArgs: [newsPaper]);
  }
}
