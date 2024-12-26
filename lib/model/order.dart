import 'package:masi_dam_2425/model/product.dart';
import 'package:masi_dam_2425/model/status.dart';

class Order {
  final int _id;
  bool _isPayed;
  bool _isCanceled;
  double _price;
  OrderStatus _status;
  final List<ProductItem> _order;
  final List<ProductItem> _missingProducts;

  Order({
    required int id,
    bool isCanceled = false,
    bool isPayed = false,
    double price = 0,
    orderStatus = OrderStatus.newOrder,
    transferStatus = TransferStatus.onHold,
    List<ProductItem>? order,
    List<ProductItem>? missingProducts,
  })  : _id = id,
        _price = price,
        _status = orderStatus,
        _order = order ?? [],
        _missingProducts = missingProducts ?? [],
        _isCanceled = isCanceled,
        _isPayed = isPayed;

  void nextStatus() {
    if (!_status.isFinalState) {
      if (_isCanceled) {
        _status = OrderStatus.canceled;
      } else if (_status == OrderStatus.newOrder) {
        _status = OrderStatus.queued;
      } else if (_status == OrderStatus.queued) {
        _status = OrderStatus.preparing;
      } else if (_status == OrderStatus.preparing) {
        _status = OrderStatus.ready;
      } else if (_status == OrderStatus.ready) {
        _status = OrderStatus.served;
      }
    }
  }

  int getOrderNumber() {
    return _id;
  }

  String getStatus() {
    return _status.displayName;
  }

  void addProduct(Product product, {int quantity = 1}) {
    final existingItem = _order.firstWhere(
          (item) => item.product == product,
      orElse: () => ProductItem(product: product, quantity: 0),
    );

    if (existingItem.quantity > 0) {
      existingItem.quantity += quantity;
    } else {
      _order.add(ProductItem(product: product, quantity: quantity));
    }

    _updateTotalPrice();
  }

  void removeProduct(Product product, {int quantity = 1}) {
    final existingItem = _order.firstWhere(
          (item) => item.product == product,
      orElse: () => ProductItem(product: product, quantity: 0),
    );

    if (existingItem.quantity > quantity) {
      existingItem.quantity -= quantity;
    } else {
      _order.remove(existingItem);
    }

    _updateTotalPrice();
  }

  List<ProductItem> getOrder() {
    return _order;
  }

  void _updateTotalPrice() {
    _price = _order.fold(0, (sum, productItem) => sum + productItem.totalPrice);
  }

  double getTotalPrice() {
    return _price;
  }

  void cancel() {
    _isCanceled = true;
  }

  void pay() {
    _isPayed = true;
  }

  bool isClosed() {
    return _status.isFinalState && _isPayed;
  }
}
