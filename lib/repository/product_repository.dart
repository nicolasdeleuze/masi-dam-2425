import 'package:masi_dam_2425/model/product.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ProductRepository {

  static final ProductRepository _instance = ProductRepository._internal();
  late Database _database;

  factory ProductRepository() => _instance;

  ProductRepository._internal();

  Future<void> initDatabase() async {
    final dbPath = await getDatabasesPath();
    _database = await openDatabase(
      join(dbPath, 'app_database.db'),
      onConfigure: (db) async {
        await db.execute('PRAGMA foreign_keys = ON');
      },
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE products(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            price REAL NOT NULL,
            category TEXT NOT NULL
          )
        ''');
      },
      version: 1,
    );
  }

  Future<void> insertProduct(Product product) async {
    await _database.insert('products', product.toMap());
  }

  Future<void> updateProduct(Product product) async {
    await _database.update(
      'products',
      product.toMap(),
      where: 'id = ?',
      whereArgs: [product.id],
    );
  }

  Future<void> deleteProduct(Product product) async {
    try {
      await _database.delete(
        'products',
        where: 'id = ?',
        whereArgs: [product.id],
      );
    } catch (e) {
      throw Exception('Couldn\'t delete ${product.name}');
    }
  }

  Future<List<Product>> getProducts() async {
    final result = await _database.query('products');
    return result.map((map) => Product.fromMap(map)).toList();
  }

  Future<List<Product>> getProductsByCategory(String category) async {
    final result = await _database.query(
      'products',
      where: 'category = ?',
      whereArgs: [category],
    );
    return result.map((map) => Product.fromMap(map)).toList();
  }
}