import 'package:masi_dam_2425/model/menu_category.dart';

enum StockStatus {
  inStock,
  outOfStock,
  limitedAvailability,
}

class Product {
  final String _name;
  final double _price;
  final MenuCategory _category;
  final List<String> _tags;

  Product({
    required String name,
    required double price,
    required MenuCategory category,
    StockStatus stockStatus = StockStatus.inStock,
    List<String> tags = const [],
  }) :  _name = name,
        _price = price,
        _category = category,
        _tags = List.from(tags);

  String getName(){
    return _name;
  }

  MenuCategory getCategory(){
    return _category;
  }

  double getPrice(){
    return _price;
  }

  List<String> get tags => List.unmodifiable(_tags);

  void addTag(String tag) {
    _tags.add(tag);
  }

  void removeTag(String tag) {
    _tags.remove(tag);
  }
}

class ProductItem {
  final Product product;
  int quantity;

  ProductItem({
    required this.product,
    int quantity = 1,
  }) : quantity = quantity > 0 ? quantity : 1;

  void addProduct() {
    quantity++;
  }

  void removeProduct() {
    if (quantity > 1) {
      quantity--;
    } else {
      throw Exception("Cannot decrease quantity below 1.");
    }
  }

  double get totalPrice => product.getPrice() * quantity;
}
