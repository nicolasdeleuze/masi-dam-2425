
import 'package:flutter/foundation.dart';
import 'package:masi_dam_2425/model/order.dart';
import 'package:masi_dam_2425/repository/app_repository.dart';

class OrderViewModel extends ChangeNotifier {
  final AppRepository _repository;
  bool _isLoading = false;
  List<Order> _orders = [];
  List<Order> _activeOrders = [];
  String? _errorMessage;

  OrderViewModel(this._repository);

  bool get isLoading => _isLoading;
  List<Order> get orders => _orders;
  List<Order> get activeOrders => _activeOrders;
  String? get errorMessage => _errorMessage;

  Future<void> createOrder(Order order) async {
    _setLoading(true);
    try {
      await _repository.insertOrder(order);
      _orders.add(order);
      notifyListeners();
    } catch (e) {
      _errorMessage = "Failed to create order: $e";
      notifyListeners();
    } finally {
      _setLoading(false);
    }
  }

  Future<void> getOrders() async {
    _setLoading(true);
    try {
      final orders = await _repository.getOrders();
      _orders = orders;
      notifyListeners();
    } catch (e) {
      _errorMessage = "Failed to load orders: $e";
      notifyListeners();
    } finally {
      _setLoading(false);
    }
  }

  Future<void> getActiveOrders() async {
    _setLoading(true);
    try {
      final orders = await _repository.getOrders();
      for (Order order in orders){
        if (!order.isComplete()){
          _activeOrders.add(order);
        }
      }
      notifyListeners();
    } catch (e) {
      _errorMessage = "Failed to load orders: $e";
      notifyListeners();
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}