
import 'package:masi_dam_2425/model/order.dart';
import 'package:masi_dam_2425/view_model/view_model.dart';
import 'package:masi_dam_2425/view_model/observer.dart';
import 'package:masi_dam_2425/repository/app_repository.dart';

class OrderViewModel extends EventViewModel {
  final AppRepository _repository;

  OrderViewModel(this._repository);

  void createOrder(Order order){
    notify(LoadingEvent(isLoading: true));
    _repository.insertOrder(order).then((value){
      notify(OrderCreatedEvent(order));
      notify(LoadingEvent(isLoading: false));
    });
  }

  void getOrders(){
    notify(LoadingEvent(isLoading: true));
    _repository.getOrders().then((value){
      notify(OrdersLoadedEvent(orders: value));
      notify(LoadingEvent(isLoading: false));
    });
  }
}

class LoadingEvent extends ViewEvent {
  bool isLoading;
  LoadingEvent({required this.isLoading}) : super("LoadingEvent");
}

class OrdersLoadedEvent extends ViewEvent {
  final List<Order> orders;
  OrdersLoadedEvent({required this.orders}) : super("OrderLoadedEvent");
}

class OrderCreatedEvent extends ViewEvent {
  final Order order;
  OrderCreatedEvent(this.order) : super("OrderCreatedEvent");
}