import 'package:masi_dam_2425/comm/packet.dart';
import 'package:masi_dam_2425/comm/packet_status.dart';
import 'package:masi_dam_2425/comm/packet_type.dart';

void main() {

  Packet packet  = Packet.create(
      recipent: "MINE_ID",
      source: "ROOT_ID",
      data: "AZERTY1234",
      type: PacketType.Who,
      status: PacketStatus.TO_SEND
  );

  packet.debug();

  String str_packet = packet.serialize();

  print(str_packet);

  Packet packet2 = Packet.parse(str_packet);

  packet2.debug();

}
