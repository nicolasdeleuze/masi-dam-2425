import 'package:masi_dam_2425/model/menu.dart';
import 'package:masi_dam_2425/model/product.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MenuRepository {
  static final MenuRepository _instance = MenuRepository._internal();
  late Database _database;

  factory MenuRepository() => _instance;

  MenuRepository._internal();

  Future<void> initDatabase(Database db) async {
    _database = db;
  }

  Future<void> insertMenu(Menu menu) async {
    final id = await _database.insert('menus', menu.toMap());
    menu.id = id;

    for (final product in menu.products) {
      await _database.insert('menu_products', {
        'menuId': id,
        'productId': product.id,
      });
    }
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

  Future<List<Menu>> getMenus() async {
    final result = await _database.query('menus');
    return result.map((map) => Menu.fromMap(map)).toList();
  }

  Future<List<Menu>> getMenusByName(String name) async {
    final result = await _database.query(
      'menus',
      where: 'name LIKE ?',
      whereArgs: ['%$name%'],
    );
    return result.map((map) => Menu.fromMap(map)).toList();
  }
}
