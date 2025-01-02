import 'package:masi_dam_2425/model/menu_category.dart';
import 'package:masi_dam_2425/model/product.dart';

class Menu {
  final List<Product> _products = [];

  Menu();

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

  List<Product> findProductByCategory (MenuCategory category){
    List<Product> result = [];
    for (Product product in _products){
      if (product.category == category){
        result.add(product);
      }
    }
    return result;
  }
}
