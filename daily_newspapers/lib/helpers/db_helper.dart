import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelper {
  static final newsTableName = "user_favourite_news";
  static final selectedNewsPapers = "selected_newspapers";

  // static final _selectedNewsPapersTableStructure =  "CREATE TABLE $tableName(id TEXT PRIMARY KEY, title TEXT, description TEXT, image TEXT, link TEXT)");

  static Future<sql.Database> createDatabase(String tableName) async {
    final dbPath = await sql.getDatabasesPath();
    String tableStructure;
    if (tableName == newsTableName) {
      tableStructure =
          "CREATE TABLE $tableName(id TEXT PRIMARY KEY, title TEXT, description TEXT, image TEXT, link TEXT)";
    } else if (tableName == selectedNewsPapers) {
      tableStructure =
          "CREATE TABLE $tableName(title TEXT , imageUrl TEXT PRIMARY KEY)";
    }
    return sql.openDatabase(
      path.join(dbPath, "news.db"),
      onCreate: (db, version) {
        return db.execute(tableStructure);
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
    var dataList =
        await db.rawQuery('SELECT * FROM ${DBHelper.selectedNewsPapers}');
    print(dataList);
    return dataList;
  }

  static Future<void> deleteData(String table, String newsPaper) async {
    await getData(table);
    final db = await DBHelper.createDatabase(table);
    db.delete(table, where: "title = ?", whereArgs: [newsPaper]);
    print(newsPaper);
    await getData(table);
  }
}
