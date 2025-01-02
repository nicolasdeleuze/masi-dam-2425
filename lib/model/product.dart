import 'package:masi_dam_2425/model/menu_category.dart';

/// Class represents a product
/// The product is identified by its ID
/// It has a name and a price. The price can be changed (for promotion or else)
/// Category field is used to group products of the same kind.
class Product {
  final int _id;
  final String _name;
  double _price;
  final MenuCategory _category;

  Product({
    required int id,
    required String name,
    required double price,
    required MenuCategory category,
  }) :  _id = id,
        _name = name,
        _price = price,
        _category = category;

  int get id => _id;
  String get name => _name;
  MenuCategory get category => _category;
  double get price => _price;

  void setPrice(price){
    _price = price;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': _id,
      'name': _name,
      'price': _price,
      'category': _category,
    };
  }

  static Product fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'],
      price: map['price'],
      category: map['category'],
    );
  }
}