
enum PacketType {
  String,
  Order,
  Who,
  ProductForSale,
  Ack;

  static PacketType parse(int idx) {
    switch(idx) {
      case 0:
        return PacketType.String;
      case 1:
        return PacketType.Order;
      case 2:
        return PacketType.Who;
      case 3:
        return PacketType.ProductForSale;
      case 4:
        return PacketType.Ack;
      default:
        throw Exception('Invalid packet type');
    }
  }
}
