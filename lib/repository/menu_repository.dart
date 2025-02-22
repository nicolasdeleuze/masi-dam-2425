import 'package:masi_dam_2425/model/menu.dart';
import 'package:masi_dam_2425/repository/product_repository.dart';
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

  Future<List<Menu>> getMenus(ProductRepository productRepository) async {
    final menuResults = await _database.query('menus');
    final menuIds = menuResults.map((menu) => menu['id'] as int).toList();
    final menuProductsResults = await _database.query(
      'menu_products',
      where: 'menuId IN (${List.filled(menuIds.length, '?').join(', ')})',
      whereArgs: menuIds,
    );
    final menuProductsMap = <int, List<int>>{};
    for (final row in menuProductsResults) {
      final menuId = row['menuId'] as int;
      final productId = row['productId'] as int;
      menuProductsMap.putIfAbsent(menuId, () => []).add(productId);
    }
    return await Future.wait(menuResults.map((menuMap) async {
      final menuId = menuMap['id'] as int;
      final productIds = menuProductsMap[menuId] ?? [];
      final products = await productRepository.getProductsByIds(productIds);
      return Menu(
        name: menuMap['name'] as String,
        products: products,
      )..id = menuId;
    }));
  }

  Future<List<Menu>> getMenusByName(
      String name,
      ProductRepository productRepository,
      ) async {
    final menuResults = await _database.query(
      'menus',
      where: 'name LIKE ?',
      whereArgs: ['%$name%'],
    );
    if (menuResults.isEmpty) return [];
    final menuIds = menuResults.map((menu) => menu['id'] as int).toList();
    final menuProductsResults = await _database.query(
      'menu_products',
      where: 'menuId IN (${List.filled(menuIds.length, '?').join(', ')})',
      whereArgs: menuIds,
    );
    final menuProductsMap = <int, List<int>>{};
    for (final row in menuProductsResults) {
      final menuId = row['menuId'] as int;
      final productId = row['productId'] as int;
      menuProductsMap.putIfAbsent(menuId, () => []).add(productId);
    }
    return await Future.wait(menuResults.map((menuMap) async {
      final menuId = menuMap['id'] as int;
      final productIds = menuProductsMap[menuId] ?? [];
      final products = await productRepository.getProductsByIds(productIds);
      return Menu(
        name: menuMap['name'] as String,
        products: products,
      )..id = menuId;
    }));
  }

}
