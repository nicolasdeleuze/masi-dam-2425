import 'package:masi_dam_2425/model/status.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:masi_dam_2425/model/product.dart';
import 'package:masi_dam_2425/model/order.dart';

class AppRepository {
  static final AppRepository _instance = AppRepository._internal();
  late Database _database;

  factory AppRepository() => _instance;

  AppRepository._internal();

  Future<void> initDatabase() async {
    final dbPath = await getDatabasesPath();
    _database = await openDatabase(
      join(dbPath, 'app_database.db'),
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE products(
            id INTEGER PRIMARY KEY,
            name TEXT NOT NULL,
            price REAL NOT NULL,
            category TEXT NOT NULL
          )
        ''');
        await db.execute('''
          CREATE TABLE orders(
            id INTEGER PRIMARY KEY,
            price REAL NOT NULL,
            status TEXT NOT NULL,
            transfer TEXT NOT NULL,
            tag TEXT
          )
        ''');
        await db.execute('''
          CREATE TABLE order_products(
            orderId INTEGER,
            productId INTEGER,
            quantity INTEGER NOT NULL,
            missing INTEGER NOT NULL DEFAULT 0,
            FOREIGN KEY(orderId) REFERENCES orders(id) ON DELETE CASCADE,
            FOREIGN KEY(productId) REFERENCES products(id) ON DELETE CASCADE,
            PRIMARY KEY(orderId, productId)
          )
        ''');
      },
      version: 1,
    );
  }

  Future<void> insertProduct(Product product) async {
    await _database.insert('products', product.toMap());
  }

  Future<void> updateProduct (Product product) async {
   //TODO
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

  Future<void> insertOrder(Order order) async {
    final orderId = await _database.insert(
      'orders',
      order.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    for (int i = 0; i < order.products.length; i++) {
      await _database.insert(
        'order_products',
        {
          'orderId': orderId,
          'productId': order.products[i].id,
          'quantity': order.quantities[i],
          'missing': order.missing[i],
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<List<Order>> getOrders() async {
    final ordersData = await _database.query('orders');
    List<Order> orders = [];

    for (var orderMap in ordersData) {
      final orderId = orderMap['id'] as int;
      final productsData = await _database.rawQuery('''
        SELECT products.*, order_products.quantity, order_products.missing
        FROM products 
        INNER JOIN order_products 
        ON products.id = order_products.productId 
        WHERE order_products.orderId = ?
      ''', [orderId]);

      final products = productsData.map((map) => Product.fromMap(map)).toList();
      final quantity = productsData.map((map) => map['quantity'] as int).toList();
      final missing = productsData.map((map) => map['missing'] as int).toList();

      orders.add(Order(
        id: orderId,
        price: orderMap['price'] as double,
        status: OrderStatusExtension.fromString(orderMap['status'] as String),
        transfer: TransferStatusExtension.fromString(orderMap['transfer'] as String),
        tag: orderMap['tag'] as String,
        order: products,
        quantity: quantity,
        missingProducts: missing,
      ));
    }
    return orders;
  }
}
