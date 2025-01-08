import 'package:shared_preferences/shared_preferences.dart';

class IdGenerator {
  static const String _productIdKey = 'currentProductId';
  static const String _orderIdKey = 'currentOrderId';

  static Future<int> getCurrentId(String type) async {
    final prefs = await SharedPreferences.getInstance();
    if (type == 'product') {
      return prefs.getInt(_productIdKey) ?? 0;
    } else if (type == 'order') {
      return prefs.getInt(_orderIdKey) ?? 0;
    }
    return 0;
  }

  static Future<int> generateNewId(String type) async {
    final currentId = await getCurrentId(type);
    final newId = currentId + 1;
    await _saveId(type, newId);
    return newId;
  }

  static Future<void> _saveId(String type, int id) async {
    final prefs = await SharedPreferences.getInstance();
    if (type == 'product') {
      await prefs.setInt(_productIdKey, id);
    } else if (type == 'order') {
      await prefs.setInt(_orderIdKey, id);
    }
  }
}
