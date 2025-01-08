import 'package:masi_dam_2425/model/menu.dart';
import 'package:masi_dam_2425/model/product.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MenuRepository {

  static final MenuRepository _instance = MenuRepository._internal();
  late Database _database;

  factory MenuRepository() => _instance;

  MenuRepository._internal();

  Future<void> initDatabase() async {
    final dbPath = await getDatabasesPath();
    _database = await openDatabase(
      join(dbPath, 'app_database.db'),
      onConfigure: (db) async {
        await db.execute('PRAGMA foreign_keys = ON');
      },
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE menus(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            productId INTEGER,
            FOREIGN KEY(productId) REFERENCES products(id) ON DELETE CASCADE,
          )
        ''');
      },
      version: 1,
    );
  }

  Future<void> insertMenu(Menu menu) async {
    final id = await _database.insert('menus', menu.toMap());
    menu.id = id;
  }

  Future<void> updateMenu(Menu menu) async {
    await _database.update(
      'menus',
      menu.toMap(),
      where: 'id = ?',
      whereArgs: [menu.id],
    );
  }

  Future<void> deleteMenu(Menu menu) async {
    try {
      await _database.delete(
        'menus',
        where: 'id = ?',
        whereArgs: [menu.id],
      );
    } catch (e) {
      throw Exception('Couldn\'t delete ${menu.name}');
    }
  }

  Future<List<Product>> getMenus() async {
    final result = await _database.query('menus');
    return result.map((map) => Product.fromMap(map)).toList();
  }

}