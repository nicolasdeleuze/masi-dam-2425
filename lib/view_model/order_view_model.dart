import 'package:flutter/material.dart';
import 'package:masi_dam_2425/comm/packet_manager.dart';
import 'package:masi_dam_2425/model/order.dart';
import 'package:masi_dam_2425/repository/order_repository.dart';
import 'package:masi_dam_2425/repository/product_repository.dart';

class OrderViewModel extends ChangeNotifier {
  final OrderRepository _orderRepository;
  final ProductRepository _productRepository;
  bool _isLoading = false;
  List<Order> _orders = [];
  final List<Order> _activeOrders = [];
  String? _errorMessage;
  final PacketManager _packetManager = PacketManager.getInstance();

  OrderViewModel(this._orderRepository, this._productRepository) {
    getOrders();
  }

  bool get isLoading => _isLoading;
  List<Order> get orders => _orders;
  List<Order> get activeOrders => _activeOrders;
  String? get errorMessage => _errorMessage;

  Future<void> createOrder(Order order) async {
    _setLoading(true);
    try {
      await _orderRepository.insertOrder(order);
      _orders.add(order);
      notifyListeners();
    } catch (e) {
      _errorMessage = "Failed to create order: $e";
      notifyListeners();
    } finally {
      _packetManager.addMessageToSend(object:order,);
      _setLoading(false);
    }
  }

  Future<void> addReceivedOrder(Order order) async {
    _setLoading(true);
    try {
      await _orderRepository.insertOrder(order);
      if (orders.isEmpty){
        getOrders();
      } else {
        _orders.add(order);
      }
      notifyListeners();
    } catch (e) {
      _errorMessage = "Failed to create order: $e";
      print("OrderViewModel addReceivedOrder error: $e");
      notifyListeners();
    } finally {
      _setLoading(false);
    }
  }

  Future<void> getOrders() async {
    _setLoading(true);
    try {
      final orders = await _orderRepository.getOrders(_productRepository);
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
      final orders = await _orderRepository.getOrders(_productRepository);
      for (Order order in orders) {
        if (!order.isComplete()) {
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
