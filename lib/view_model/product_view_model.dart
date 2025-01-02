import 'package:flutter/foundation.dart';
import 'package:masi_dam_2425/model/product.dart';
import 'package:masi_dam_2425/repository/product_repository.dart';

class ProductViewModel extends ChangeNotifier {
  final ProductRepository _repository;
  bool _isLoading = false;
  String? _errorMessage;
  List<Product> _products = [];

  ProductViewModel(this._repository) {
    getProducts();
  }

  bool get isLoading => _isLoading;
  List<Product> get products => _products;
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
      _products[_products.indexOf(product)]=product;
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

  Future<void> getProductsByCategory(String category) async {
    _setLoading(true);
    try {
      final products = await _repository.getProductsByCategory(category);
      _products = products;
      notifyListeners();
    } catch (e) {
      _errorMessage = "Failed to load products: $e";
      notifyListeners();
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
