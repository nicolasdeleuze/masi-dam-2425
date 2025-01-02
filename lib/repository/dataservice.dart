import 'package:masi_dam_2425/repository/order_repository.dart';
import 'package:masi_dam_2425/repository/product_repository.dart';

class DataService {
  final ProductRepository _productRepository = ProductRepository();
  final OrderRepository _orderRepository = OrderRepository();

  Future<void> initialize() async {
    await _productRepository.initDatabase();
    await _orderRepository.initDatabase();
  }

  OrderRepository get orderRepository => _orderRepository;
  ProductRepository get productRepository => _productRepository;
}
