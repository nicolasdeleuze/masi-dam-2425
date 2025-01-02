import 'package:masi_dam_2425/model/menu.dart';
import 'package:masi_dam_2425/model/order.dart';
import 'package:masi_dam_2425/model/staff.dart';

class Event {
  String _id;
  DateTime _start;
  DateTime? _end;
  String _name;
  String _location;
  Menu _menu;
  List<Order>? _orders = [];
  List<Staff> _crew = [];

  Event(
    DateTime start,
    DateTime? end,
    String name,
    String location,
    Menu menu,
    List<Staff> crew,
  )   : _id = _createID(name, start),
        _start = start,
        _end = end,
        _name = name,
        _location = location,
        _menu = menu,
        _crew = crew;

  static String _createID(String name, DateTime date) {
    return '${name.toUpperCase()}-${date.toIso8601String()}';
  }

  String get id => _id;
  DateTime get start => _start;
  DateTime? get end => _end;
  String get name => _name;
  String get location => _location;
  Menu get menu => _menu;
  List<Order>? get orders => List.unmodifiable(_orders!);
  List<Staff> get staff => List.unmodifiable(_crew);

  void addOrders(List<Order> orders) {
    _orders!.addAll(orders);
  }

  void addOrder(Order order) {
    _orders!.add(order);
  }

  void addStaff(Staff staff) {
    _crew.add(staff);
  }

  void removeStaff(Staff staff) {
    _crew.remove(staff);
  }
}
