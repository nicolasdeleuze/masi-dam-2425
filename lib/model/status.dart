enum OrderStatus{
  canceled,
  newOrder,
  queued,
  preparing,
  ready,
  served,
}

enum TransferStatus{
  sending,
  sent,
  received,
  onHold,
}

extension OrderStatusExtension on OrderStatus {
  String get displayName {
    switch (this) {
      case OrderStatus.newOrder:
        return "New Order";
      case OrderStatus.queued:
        return "Queued";
      case OrderStatus.preparing:
        return "Preparing";
      case OrderStatus.ready:
        return "Ready for Pickup";
      case OrderStatus.served:
        return "Served";
      case OrderStatus.canceled:
        return "Canceled";
    }
  }

  static OrderStatus fromString(String value){
    switch (value) {
      case 'New Order':
        return OrderStatus.newOrder;
      case 'Queued':
        return OrderStatus.queued;
      case 'Preparing':
        return OrderStatus.preparing;
      case "Ready for Pickup":
        return OrderStatus.ready;
      case "Served":
        return OrderStatus.served;
      case "Canceled":
        return OrderStatus.canceled;
      default:
        throw ArgumentError('Invalid OrderStatus: $value');
    }
  }

  bool get isFinalState {
    return this == OrderStatus.served || this == OrderStatus.canceled;
  }
}

extension TransferStatusExtension on TransferStatus {
  String get displayName {
    switch (this) {

      default:
        return "Unknown";
    }
  }

  static TransferStatus fromString(String value) {
    switch (value) {
      case "Sending":
        return TransferStatus.sending;
      case "Sent":
        return TransferStatus.sent;
      case "Received":
        return TransferStatus.received;
      case "On Hold":
        return TransferStatus.onHold;
      default:
        throw ArgumentError('Invalid TransferStatus: $value');
    }
  }

  bool get isInProgress {
    return this == TransferStatus.sending || this == TransferStatus.onHold;
  }
}
