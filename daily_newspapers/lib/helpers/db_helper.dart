import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelper {
  static final newsTableName = "user_favourite_news";
  static Future<sql.Database> createDatabase() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, "news.db"),
      onCreate: (db, version) {
        return db.execute(
            "CREATE TABLE user_favourite_news(id TEXT PRIMARY KEY, title TEXT, description TEXT, image TEXT, link TEXT)");
      },
      version: 1,
    );
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DBHelper.createDatabase();
    db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
    // await doesDbContainsNews(newsTableName, data["id"]);
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.createDatabase();
    return db.query(table);
  }

//   static Future<void> doesDbContainsNews(String tableName, String id) async {
//     final db = await DBHelper.createDatabase();
//     final table = db.query(tableName);
//     final news =
//         await db.rawQuery('SELECT * FROM user_favourite_news WHERE title = ${table["title"]}');
//     if(news.isEmpty){
//       print("Empty");
//     }else{
//       print("NotEmpty");
//     }
//   }

}
