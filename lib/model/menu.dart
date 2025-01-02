import 'package:masi_dam_2425/model/menu_category.dart';
import 'package:masi_dam_2425/model/product.dart';

class Menu {
  int? id;
  final String _name;
  List<Product> _products = [];

  Menu({
    required String name,
    List<Product>? products,
  })  : _name = name,
        _products = products ?? [];

  String get name => _name;

  void addProduct(Product product) {
    _products.add(product);
  }

  void removeProduct(Product product) {
    if (_products.contains(product)) {
      _products.remove(product);
    } else {
      throw Exception('No such product in the menu');
    }
  }

  List<Product> findProductByCategory(MenuCategory category) {
    List<Product> result = [];
    for (Product product in _products) {
      if (product.category == category) {
        result.add(product);
      }
    }
    return result;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': _name,
      'products': _products.map((product) => product.toMap()).toList(),
    };
  }

  static Menu fromMap(Map<String, dynamic> map) {
    return Menu(
      name: map['name'],
      products: (map['products'] as List)
          .map((productMap) => Product.fromMap(productMap))
          .toList(),
    )..id = map['id'] as int?;
  }
}
