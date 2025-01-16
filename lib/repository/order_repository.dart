import 'package:masi_dam_2425/model/status.dart';
import 'package:masi_dam_2425/repository/product_repository.dart';
import 'package:sqflite/sqflite.dart';
import 'package:masi_dam_2425/model/order.dart';

class OrderRepository {
  static final OrderRepository _instance = OrderRepository._internal();
  late Database _database;

  factory OrderRepository() => _instance;

  OrderRepository._internal();

  Future<void> initDatabase(Database db) async {
    _database = db;
  }

  Future<void> insertOrder(Order order) async {
    try {
      final orderId = await _database.insert(
        'orders',
        order.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      order.id = orderId;
      if (order.products.length != order.quantities.length ||
          order.products.length != order.missing.length) {
        throw Exception(
            'Mismatch in product, quantity, or missing lists length');
      }
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
      throw Exception('Could not insert new order: $e');
    }
  }

  Future<List<Order>> getOrders(ProductRepository productRepository) async {
    try {
      final ordersResults = await _database.query('orders');

      if (ordersResults.isEmpty) {
        return [];
      }

      final ordersIds =
          ordersResults.map((order) => order['id'] as int).toList();
      final orderProductsResults = await _database.query(
        'order_products',
        where: 'orderId IN (${List.filled(ordersIds.length, '?').join(', ')})',
        whereArgs: ordersIds,
      );

      final orderProductsMap = <int, List<Map<String, dynamic>>>{};
      for (final row in orderProductsResults) {
        final orderId = row['orderId'] as int;
        orderProductsMap.putIfAbsent(orderId, () => []).add(row);
      }

      return await Future.wait(ordersResults.map((orderMap) async {
        final orderId = orderMap['id'] as int;

        final productRows = orderProductsMap[orderId] ?? [];
        final productIds =
            productRows.map((row) => row['productId'] as int).toList();
        final products = await productRepository.getProductsByIds(productIds);

        final quantities =
            productRows.map((row) => row['quantity'] as int).toList();
        final missing =
            productRows.map((row) => row['missing'] as int).toList();

        return Order(
          price: (orderMap['price'] as num?)?.toDouble() ?? 0.0,
          status: OrderStatus.values.firstWhere(
            (e) => e.displayName == orderMap['status'],
            orElse: () => OrderStatus.newOrder,
          ),
          transfer: TransferStatus.values.firstWhere(
            (e) => e.displayName == orderMap['transfer'],
            orElse: () => TransferStatus.onHold,
          ),
          order: products,
          quantity: quantities,
          missingProducts: missing,
          tag: orderMap['tag'] as String?,
        )..id = orderId;
      }));
    } catch (e) {
      throw Exception('Could not retrieve orders: $e');
    }
  }
}
