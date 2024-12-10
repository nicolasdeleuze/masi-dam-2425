import 'package:masi_dam_2425/model/product.dart';
import 'package:masi_dam_2425/model/status.dart';

class Order {
  final int _orderNumber;
  bool _isPayed;
  bool _isCanceled;
  final double _price;
  double _refund;
  OrderStatus _orderStatus;
  TransferStatus _transferStatus;
  bool _hasMissingProduct;
  final List<ProductItem> _order;
  final List<ProductItem> _finalOrder;

  Order({
    required int orderNumber,
    bool isCanceled = false,
    bool isPayed = false,
    double price = 0,
    double refund = 0,
    orderStatus = OrderStatus.newOrder,
    transferStatus = TransferStatus.onHold,
    List<ProductItem>? order,
    List<ProductItem>? finalOrder,
    bool hasMissingProduct = false,
  })  : _orderNumber = orderNumber,
        _price = price,
        _refund = refund,
        _orderStatus = orderStatus,
        _transferStatus = transferStatus,
        _order = order ?? [],
        _finalOrder = finalOrder ?? [],
        _isPayed = isPayed,
        _isCanceled = isCanceled,
        _hasMissingProduct = hasMissingProduct;

  void cancel() {
    _isCanceled = true;
  }

  double calculateTotalPrice() {
    return _order.fold(0, (sum, productItem) => sum + productItem.totalPrice);
  }

  double calculateRefund() {
    if (areOrdersDifferent()) {
      //calculate difference
    }
    if (_orderStatus == OrderStatus.canceled) {
      _refund = _price;
    }
    return _refund;
  }

  bool areOrdersDifferent() {
    return false;
  }

  void nextStatus() {
    if (!_orderStatus.isFinalState) {
      if (_isCanceled) {
        _orderStatus = OrderStatus.canceled;
      } else if (_orderStatus == OrderStatus.newOrder) {
        _orderStatus = OrderStatus.queued;
      } else if (_orderStatus == OrderStatus.queued) {
        _orderStatus = OrderStatus.preparing;
      } else if (_orderStatus == OrderStatus.preparing) {
        _orderStatus = OrderStatus.ready;
      } else if (_orderStatus == OrderStatus.ready) {
        _orderStatus = OrderStatus.served;
      }
    }
  }

  int getOrderNumber() {
    return _orderNumber;
  }

  String getStatus() {
    return _orderStatus.displayName;
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
  }

  List<ProductItem> getOrder() {
    return _order;
  }

  bool isClosed() {
    return _orderStatus.isFinalState;
  }
}
