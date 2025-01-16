import 'package:masi_dam_2425/model/product.dart';
import 'package:sqflite/sqflite.dart';

class ProductRepository {

  static final ProductRepository _instance = ProductRepository._internal();
  late Database _database;

  factory ProductRepository() => _instance;

  ProductRepository._internal();

  Future<void> initDatabase(Database db) async {
    _database = db;
  }

  Future<void> insertProduct(Product product) async {
    final id = await _database.insert('products', product.toMap());
    product.id = id;
  }

  Future<void> updateProduct(Product product) async {
    await _database.update(
      'products',
      product.toMap(),
      where: 'id = ?',
      whereArgs: [product.id],
    );
  }

  Future<void> deleteAll() async {
    try {
      await _database.delete('products');
    } catch (e) {
      throw Exception('Couldn\'t delete all');
    }
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

  Future<List<Product>> getProductsByName(String name) async {
    final result = await _database.query(
      'products',
      where: 'name LIKE ?',
      whereArgs: ['%$name%'],
    );
    return result.map((map) => Product.fromMap(map)).toList();
  }

  Future<List<Product>> getProductsByIds(List<int> ids) async {
    if (ids.isEmpty) return [];
    final idPlaceholders = List.filled(ids.length, '?').join(', ');
    final results = await _database.query(
      'products',
      where: 'id IN ($idPlaceholders)',
      whereArgs: ids,
    );
    return results.map((map) => Product.fromMap(map)).toList();
  }

}