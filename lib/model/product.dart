import 'dart:convert';
import 'package:masi_dam_2425/model/menu_category.dart';

/// Class represents a product
/// The product is identified by its ID
/// It has a name and a price. The price can be changed (for promotion or else)
/// Category field is used to group products of the same kind.
class Product {
  int? id;
  final String _name;
  double _price;
  final MenuCategory _category;

  Product({
    this.id,
    required String name,
    required double price,
    required MenuCategory category,
  }) :  _name = name,
        _price = price,
        _category = category;
  String get name => _name;
  MenuCategory get category => _category;
  double get price => _price;

  void setPrice(price){
    _price = price;
  }

  Map<String, dynamic> toMap() {
    return {
      'id' : id,
      'name': _name,
      'price': _price,
      'category': _category.displayName,
    };
  }

  static Product fromMap(Map<String, dynamic> map) {
    return Product(
      name: map['name'],
      price: map['price'],
      category: MenuCategory.values.firstWhere(
            (e) => e.displayName == map['category'],
        orElse: () => MenuCategory.exotic,
      ),
    )..id = map['id'] as int?;
  }

  String toJson() {
    return jsonEncode(toMap());
  }

  static Product fromJson(String jsonString) {
    return Product.fromMap(jsonDecode(jsonString));
  }
}