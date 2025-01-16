import 'package:masi_dam_2425/repository/menu_repository.dart';
import 'package:masi_dam_2425/repository/order_repository.dart';
import 'package:masi_dam_2425/repository/product_repository.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DataService {
  static const String _dbName = 'app_database.db';
  static const int _dbVersion = 1;

  final ProductRepository _productRepository = ProductRepository();
  final OrderRepository _orderRepository = OrderRepository();
  final MenuRepository _menuRepository = MenuRepository();
  late Database _database;

  Future<void> initialize() async {
    try {
      final dbPath = await getDatabasesPath();
      _database = await openDatabase(
        join(dbPath, _dbName),
        version: _dbVersion,
        onConfigure: (db) async {
          await db.execute('PRAGMA foreign_keys = ON');
        },
        onCreate: (db, version) async {
          await _createTables(db);
        },
      );

      await _productRepository.initDatabase(_database);
      await _orderRepository.initDatabase(_database);
      await _menuRepository.initDatabase(_database);
    } catch (e) {
      throw Exception('Could not initialize database: $e');
    }
  }

  Future<void> _createTables(Database db) async {
    await db.execute(''' 
      CREATE TABLE IF NOT EXISTS products(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        price REAL NOT NULL,
        category TEXT NOT NULL
      )
    ''');

    await db.execute(''' 
      CREATE TABLE IF NOT EXISTS orders(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        price REAL NOT NULL,
        status TEXT NOT NULL,
        transfer TEXT NOT NULL,
        tag TEXT
      )
    ''');

    await db.execute(''' 
      CREATE TABLE IF NOT EXISTS order_products(
        orderId INTEGER,
        productId INTEGER,
        quantity INTEGER NOT NULL,
        missing INTEGER NOT NULL DEFAULT 0,
        FOREIGN KEY(orderId) REFERENCES orders(id) ON DELETE CASCADE,
        FOREIGN KEY(productId) REFERENCES products(id) ON DELETE CASCADE,
        PRIMARY KEY(orderId, productId)
      )
    ''');

    await db.execute(''' 
      CREATE TABLE IF NOT EXISTS menus(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL
      )
    ''');

    await db.execute(''' 
      CREATE TABLE IF NOT EXISTS menu_products(
        menuId INTEGER NOT NULL,
        productId INTEGER NOT NULL,
        PRIMARY KEY(menuId, productId),
        FOREIGN KEY(menuId) REFERENCES menus(id) ON DELETE CASCADE,
        FOREIGN KEY(productId) REFERENCES products(id) ON DELETE CASCADE
      )
    ''');
  }


  OrderRepository get orderRepository => _orderRepository;
  ProductRepository get productRepository => _productRepository;
  MenuRepository get menuRepository => _menuRepository;
}
