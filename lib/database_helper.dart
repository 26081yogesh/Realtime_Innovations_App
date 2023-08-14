import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE employee(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, 
      name VARCHAR(20),
      role VARCHAR(20),
      startDate VARCHAR(10),
      endDate VARCHAR(10)
    )""");
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase('mydatabase.db', version: 1,
        onCreate: (sql.Database database, int version) async {
      await createTables(database);
    });
  }

  static Future<void> insertItem(Map<String, dynamic> item) async {
    final database = await SQLHelper
        .db(); // Replace with your database initialization method

    await database.insert(
      'employee', // Replace with your table name
      item,
    );
  }

  static Future<int> createItem(
      String name, String role, String startDate, String endDate) async {
    final db = await SQLHelper.db();
    print(endDate);
    final data = {
      'name': name,
      'role': role,
      'startDate': startDate,
      'endDate': endDate
    };
    final id = await db.insert('employee', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await SQLHelper.db();
    return db.query('employee', orderBy: "id");
  }

  static Future<void> deleteItem(int id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete("employee", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      print("Something went wrong when deleting an item: $err");
    }
  }

  static Future<void> deleteAllItems() async {
    final db = await SQLHelper.db();
    try {
      await db.delete("employee"); // Assuming your table is named "employee"
    } catch (err) {
      print("Something went wrong when deleting all items: $err");
    }
  }
}
