import 'package:masi_dam_2425/model/menu.dart';
import 'package:masi_dam_2425/model/order.dart';
import 'package:masi_dam_2425/model/user.dart';

class Event {
  final String _id;
  final DateTime _start;
  final DateTime? _end;
  final String _name;
  final String _location;
  final Menu _menu;
  final List<Order> _orders = [];
  final List<User> _crew = [];

  Event(
    DateTime start,
    DateTime? end,
    String name,
    String location,
    Menu menu,
    List<User> crew,
  )   : _id = _createID(name, start),
        _start = start,
        _end = end,
        _name = name,
        _location = location,
        _menu = menu;


  static String _createID(String name, DateTime date) {
    return '${name.toUpperCase()}-${date.toIso8601String()}';
  }

  String get id => _id;
  DateTime get start => _start;
  DateTime? get end => _end;
  String get name => _name;
  String get location => _location;
  Menu get menu => _menu;
  List<Order>? get orders => List.unmodifiable(_orders);
  List<User> get staff => List.unmodifiable(_crew);

  void addOrders(List<Order> orders) {
    _orders.addAll(orders);
  }

  void addOrder(Order order) {
    _orders.add(order);
  }

  void addStaff(User staff) {
    _crew.add(staff);
  }

  void removeStaff(User staff) {
    _crew.remove(staff);
  }
}
