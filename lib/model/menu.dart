import 'package:masi_dam_2425/model/menu_category.dart';
import 'package:masi_dam_2425/model/product.dart';

class Menu {
  int? id;
  final String _name;
  final List<Product> _products;

  Menu({
    required String name,
    List<Product>? products,
  })  : _name = name,
        _products = products ?? [];

  String get name => _name;
  List<Product> get products => _products;
  int get nbProduct => _getNbProduct();

  int _getNbProduct() {
    return _products.length;
  }

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
    };
  }

}
