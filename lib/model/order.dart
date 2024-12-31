import 'package:masi_dam_2425/model/product.dart';
import 'package:masi_dam_2425/model/status.dart';

/// This class represents an order, uniquely identified by its ID (order number).
///
/// An optional tag can be associated with the order to facilitate retrieval.
/// Products can be dynamically added or removed from the order, with the total
/// price being automatically recalculated as changes occur.
///
/// The order's progression is tracked using its status, which evolves through
/// the following states:
///   NewOrder -> Queued -> Preparing -> Ready -> Served
///
/// Additionally, a transfer status is maintained to track the order's state
/// on the network. This allows the order to be held locally and retried later
/// in case the recipient is temporarily unavailable.
class Order {
  final int _id;
  double _price;
  OrderStatus _status;
  TransferStatus _transfer;
  String? _tag;
  final List<Product> _order;
  final List<int> _quantity;
  final List<int> _missing;

  Order({
    required int id,
    double price = 0.0,
    OrderStatus status = OrderStatus.newOrder,
    TransferStatus transfer = TransferStatus.onHold,
    List<Product>? order,
    List<int>? quantity,
    List<int>? missingProducts,
    String? tag,
  })  : _id = id,
        _tag = tag,
        _price = price,
        _status = status,
        _transfer = transfer,
        _order = order ?? [],
        _quantity = quantity ?? [],
        _missing = missingProducts ?? [];

  void nextStatus() {
    if (_status.isFinalState) {
      return;
    }
    _status = OrderStatus.values[_status.index + 1];
  }

  int get id => _id;
  double get price => _price;
  OrderStatus get status => _status;
  String get statusToString => _status.displayName;
  TransferStatus get transfer => _transfer;
  String get transferToString => _transfer.displayName;
  String? get tag => _tag;

  List<Product> get products => List.unmodifiable(_order);
  List<int> get quantities => List.unmodifiable(_quantity);
  List<int> get missing => List.unmodifiable(_missing);

  void setTag(String tag) {
    _tag = tag;
  }

  void removeTag() {
    _tag = null;
  }

  void addProduct(Product product, {int quantity = 1}) {
    int index = _order.indexOf(product);
    if (index == -1) {
      _order.add(product);
      _quantity.add(quantity);
      _missing.add(0);
      _price += product.price * quantity;
    } else {
      _price += product.price * quantity;
      _quantity[index] += quantity;
    }
  }

  void removeProduct(Product product, {int quantity = 1}) {
    int index = _order.indexOf(product);
    if (index != -1) {
      int remainingQuantity = _quantity[index] - quantity;
      if (remainingQuantity <= 0) {
        _price -= product.price * _quantity[index];
        _order.removeAt(index);
        _quantity.removeAt(index);
        _missing.removeAt(index);
      } else {
        _price -= product.price * quantity;
        _quantity[index] = remainingQuantity;
      }
    }
  }

  void addMissingProduct(Product product, {int quantity = 1}) {
    int index = _order.indexOf(product);
    if (index != -1) {
      int remainingQuantity = _quantity[index] - quantity;
      if (remainingQuantity <= 0) {
        _price -= product.price * _quantity[index];
        _missing[index] += _quantity[index];
      } else {
        _price -= product.price * quantity;
        _missing[index] += quantity;
      }
    }
  }

  void removeMissingProduct(Product product, {int quantity = 1}) {
    int index = _order.indexOf(product);
    if (index != -1) {
      int remainingQuantity = _quantity[index] - quantity;
      if (remainingQuantity >= _quantity[index]) {
        throw Exception('Cannot remove more missing products than available');
      } else {
        _price += product.price * quantity;
        _missing[index] -= quantity;
      }
    }
  }

  void send() {
    if (_status == OrderStatus.newOrder) {
      nextStatus(); //Queued
    } else {
      throw Exception('Order status must be New');
    }
  }

  void prepare() {
    if (_status == OrderStatus.queued && _transfer == TransferStatus.received) {
      nextStatus(); // Preparing
      _transfer == TransferStatus.onHold;
    } else {
      throw Exception('Order status must be Queued');
    }
  }

  void prepared() {
    if (_status == OrderStatus.preparing) {
      nextStatus(); // Ready
    } else {
      throw Exception('Order status must be Preparing');
    }
  }

  void pay() {
    if (_status == OrderStatus.ready && _transfer == TransferStatus.received) {
      nextStatus(); // Served
      _transfer == TransferStatus.onHold;
    } else {
      throw Exception('Order status must be Ready');
    }
  }

  void cancel() {
    _status = OrderStatus.canceled; //Canceled
    _transfer = TransferStatus.onHold;
  }

  bool isComplete() {
    return _status.isFinalState;
  }

  void startTransfer() {
    if (_status != OrderStatus.newOrder || _status != OrderStatus.ready) {
      throw Exception('Cannot start transfer. Order is not ready.');
    }
    if (_transfer == TransferStatus.onHold) {
      _transfer = TransferStatus.sending; //Sending
    } else {
      throw Exception('Cannot start transfer. Current status: $_transfer');
    }
  }

  void completeTransfer() {
    if (_transfer == TransferStatus.sending) {
      _transfer = TransferStatus.received; // Received
    } else {
      throw Exception('Cannot complete transfer. Current status: $_transfer');
    }
  }

  void failTransfer() {
    if (_transfer == TransferStatus.sending) {
      _transfer = TransferStatus.onHold; // OnHold
    } else {
      throw Exception('Cannot complete transfer. Current status: $_transfer');
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'id': _id,
      'price': _price,
      'status': _status.displayName,
      'transfer': _transfer.displayName,
      'tag': _tag,
    };
  }

  static Order fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'],
      price: map['price'] ?? 0.0,
      status: OrderStatus.values.firstWhere(
        (e) => e.displayName == map['status'],
        orElse: () => OrderStatus.newOrder,
      ),
      transfer: TransferStatus.values.firstWhere(
        (e) => e.displayName == map['transfer'],
        orElse: () => TransferStatus.onHold,
      ),
      order: (map['products'] as List)
          .map((productMap) => Product.fromMap(productMap))
          .toList(),
      quantity: List<int>.from(map['quantities'] ?? []),
      tag: map['tag'],
    );
  }
}
