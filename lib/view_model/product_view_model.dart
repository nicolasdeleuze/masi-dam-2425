import 'package:flutter/foundation.dart';
import 'package:masi_dam_2425/model/menu_category.dart';
import 'package:masi_dam_2425/model/product.dart';
import 'package:masi_dam_2425/repository/product_repository.dart';

class ProductViewModel extends ChangeNotifier {
  final ProductRepository _repository;
  bool _isLoading = false;
  String? _errorMessage;
  List<Product> _products = [];
  List<bool> _selectedCategory = [];

  ProductViewModel(this._repository) {
    getProducts();
    _selectedCategory = List.filled(MenuCategory.values.length, false);
  }

  bool get isLoading => _isLoading;
  List<Product> get products => _products;
  int get nbProducts => _products.length;
  String? get errorMessage => _errorMessage;

  Future<void> createProduct(Product product) async {
    _setLoading(true);
    try {
      await _repository.insertProduct(product);
      _products.add(product);
      notifyListeners();
    } catch (e) {
      _errorMessage = "Failed to create product: $e";
      notifyListeners();
    } finally {
      _setLoading(false);
    }
  }

  Future<void> deleteProduct(Product product) async {
    _setLoading(true);
    try {
      await _repository.deleteProduct(product);
      //await _repository.deleteAll();
      product.id;
      _products.remove(product);
      notifyListeners();
    } catch (e) {
      _errorMessage = "Failed to delete product: $e";
      notifyListeners();
    } finally {
      _setLoading(false);
    }
  }

  Future<void> updateProduct(Product product) async {
    _setLoading(true);
    try {
      await _repository.updateProduct(product);
      _products[_products.indexWhere((p) => p.id ==product.id)]=product;
      notifyListeners();
    } catch (e) {
      _errorMessage = "Failed to update product: $e";
      notifyListeners();
    } finally {
      _setLoading(false);
    }
  }

  Future<void> getProducts() async {
    _setLoading(true);
    try {
      final products = await _repository.getProducts();
      _products = products;
      notifyListeners();
    } catch (e) {
      _errorMessage = "Failed to load products: $e";
      notifyListeners();
    } finally {
      _setLoading(false);
    }
  }

  Future<void> _getProductsByCategory() async {
    _setLoading(true);
    try {
      if (!_selectedCategory.contains(true)) {
        await getProducts();
      } else {
        List<MenuCategory> selectedCategories = [
          for (int i = 0; i < _selectedCategory.length; i++)
            if (_selectedCategory[i]) MenuCategory.values[i]
        ];
        final combinedProducts = await Future.wait(
          selectedCategories.map((category) async {
            final products = await _repository.getProductsByCategory(category.displayName);
            return products;
          }),
        );
        _products = combinedProducts.expand((x) => x).toList();
        notifyListeners();
      }
    } catch (e) {
      _errorMessage = "Failed to load products: $e";
      notifyListeners();
    } finally {
      _setLoading(false);
    }
  }

  void selectCategory(MenuCategory category) {
    _selectedCategory[category.index] = !_selectedCategory[category.index];
    _getProductsByCategory();
  }


  Future<void> getProductsByName(String value) async{
    try {
      final products = await _repository.getProductsByName(value);
      _products = products;
      notifyListeners();
    } catch (e) {
      _errorMessage = "Failed to load products: $e";
      notifyListeners();
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

}
