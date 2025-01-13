import 'package:flutter/foundation.dart';
import 'package:masi_dam_2425/model/menu.dart';
import 'package:masi_dam_2425/repository/menu_repository.dart';
import 'package:masi_dam_2425/repository/product_repository.dart';

class MenuViewModel extends ChangeNotifier {
  final MenuRepository _menuRepository;
  final ProductRepository _productRepository;
  bool _isLoading = false;
  String? _errorMessage;
  List<Menu> _menus = [];

  MenuViewModel(this._menuRepository, this._productRepository) {
    getMenus();
  }

  bool get isLoading => _isLoading;
  List<Menu> get menus => _menus;
  int get nbMenus => _menus.length;
  String? get errorMessage => _errorMessage;

  Future<void> createMenu(Menu menu) async {
    _setLoading(true);
    try {
      await _menuRepository.insertMenu(menu);
      _menus.add(menu);
      notifyListeners();
    } catch (e) {
      _errorMessage = "Failed to create menu: $e";
      notifyListeners();
    } finally {
      _setLoading(false);
    }
  }

  Future<void> deleteMenu(Menu menu) async {
    _setLoading(true);
    try {
      await _menuRepository.deleteMenu(menu);
      menu.id;
      _menus.remove(menu);
      notifyListeners();
    } catch (e) {
      _errorMessage = "Failed to delete menu: $e";
      notifyListeners();
    } finally {
      _setLoading(false);
    }
  }

  Future<void> updateMenu(Menu menu) async {
    _setLoading(true);
    try {
      await _menuRepository.updateMenu(menu);
      _menus[_menus.indexWhere((p) => p.id ==menu.id)]=menu;
      notifyListeners();
    } catch (e) {
      _errorMessage = "Failed to update product: $e";
      notifyListeners();
    } finally {
      _setLoading(false);
    }
  }

  Future<void> getMenus() async {
    _setLoading(true);
    try {
      final menus = await _menuRepository.getMenus(_productRepository);
      _menus = menus;
      notifyListeners();
    } catch (e) {
      _errorMessage = "Failed to load products: $e";
      notifyListeners();
    } finally {
      _setLoading(false);
    }
  }

  Future<void> getMenusByName(String value) async{
    try {
      final products = await _menuRepository.getMenusByName(value, _productRepository);
      _menus = products;
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
