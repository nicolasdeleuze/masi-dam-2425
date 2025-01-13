import 'package:flutter/material.dart';
import 'package:masi_dam_2425/comm/packet_manager.dart';
import 'package:masi_dam_2425/model/id_generator.dart';
import 'package:masi_dam_2425/model/order.dart';
import 'package:masi_dam_2425/repository/order_repository.dart';

class OrderViewModel extends ChangeNotifier {
  static OrderViewModel? _instance;

  static OrderViewModel getInstance({OrderRepository? repository}){
    if (_instance == null){
      if (repository == null){
        throw Exception("OrderRepository is required");
      }
      _instance = OrderViewModel._(repository);
    }
    return _instance!;
  }

  final OrderRepository _repository;
  bool _isLoading = false;
  List<Order> _orders = [];
  final List<Order> _activeOrders = [];
  String? _errorMessage;
  final PacketManager _packetManager = PacketManager.getInstance();

  OrderViewModel._(this._repository){
    getOrders();
  }

  bool get isLoading => _isLoading;
  List<Order> get orders => _orders;
  List<Order> get activeOrders => _activeOrders;
  String? get errorMessage => _errorMessage;

  Future<void> createOrder(Order order) async {
    _setLoading(true);
    try {
      order.id = await IdGenerator.generateNewId('order');
      await _repository.insertOrder(order);
      if (orders.isEmpty){
        getOrders();
      } else {
        _orders.add(order);
      }
      // send to root the new order
      _packetManager.addMessageToSend(order);
      notifyListeners();
    } catch (e) {
      _errorMessage = "Failed to create order: $e";
      notifyListeners();
    } finally {
      _setLoading(false);
    }
  }

  Future<void> addReceivedOrder(Order order) async {
    _setLoading(true);
    try {
      await _repository.insertOrder(order);
      if (orders.isEmpty){
        getOrders();
      } else {
        _orders.add(order);
      }
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