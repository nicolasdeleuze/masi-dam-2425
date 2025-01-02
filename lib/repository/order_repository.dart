import 'package:masi_dam_2425/model/status.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:masi_dam_2425/model/product.dart';
import 'package:masi_dam_2425/model/order.dart';

class OrderRepository {
  static final OrderRepository _instance = OrderRepository._internal();
  late Database _database;

  factory OrderRepository() => _instance;

  OrderRepository._internal();

  Future<void> initDatabase() async {
    final dbPath = await getDatabasesPath();
    _database = await openDatabase(
      join(dbPath, 'app_database.db'),
      onConfigure: (db) async {
        await db.execute('PRAGMA foreign_keys = ON');
      },
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE orders(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
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

  Future<void> insertOrder(Order order) async {
    try {
      final orderId = await _database.insert(
        'orders',
        order.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      order.id=orderId;

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
    } catch (e) {
      throw Exception('Could not insert new order');
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
