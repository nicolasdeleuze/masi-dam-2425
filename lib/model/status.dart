enum OrderStatus{
  newOrder,
  queued,
  preparing,
  ready,
  served,
  canceled,
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
      default:
        return "Unknown";
    }
  }

  bool get isFinalState {
    return this == OrderStatus.served || this == OrderStatus.canceled;
  }
}

extension TransferStatusExtension on TransferStatus {
  String get displayName {
    switch (this) {
      case TransferStatus.sending:
        return "Sending";
      case TransferStatus.sent:
        return "Sent";
      case TransferStatus.received:
        return "Received";
      case TransferStatus.onHold:
        return "On Hold";
      default:
        return "Unknown";
    }
  }

  bool get isInProgress {
    return this == TransferStatus.sending || this == TransferStatus.onHold;
  }
}
