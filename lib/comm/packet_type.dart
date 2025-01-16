
enum PacketType {
  STRING,
  ORDER,
  WHO,
  PRODUCTS_FOR_SALE,
  ACK;

  static PacketType parse(int idx) {
    switch(idx) {
      case 0:
        return PacketType.STRING;
      case 1:
        return PacketType.ORDER;
      case 2:
        return PacketType.WHO;
      case 3:
        return PacketType.PRODUCTS_FOR_SALE;
      case 4:
        return PacketType.ACK;
      default:
        throw Exception('Invalid packet type');
    }
  }
}
