import 'package:masi_dam_2425/comm/packet_status.dart';


/*
    Sended Packet Structure

    recipent;source;id;data
*/

class Packet {
  static const String FIELD_SEPARATOR = ';';

  final String id;                  // unique identifier based on trunckated hash of the data
  final String recipient_peer;      // recipient = peer address
  final String source_peer;
  final String data;
  final PacketStatus status;

  Packet(
    {
      required this.id,
      required this.recipient_peer,
      required this.source_peer,
      required this.data,
      required this.status
    }
  );

  Packet.create(
    {
      required String recipent,
      required String source,
      required String data,
      required PacketStatus status
    }
  ) : this(
    id : _generateId(data),
    recipient_peer: recipent,
    source_peer: source,
    data: data,
    status: status
  );

  static Packet parse(String packet) {
    List<String> parts = packet.split(FIELD_SEPARATOR);
    if(parts.length == 4) {
      return Packet(
          id: parts[2],
          recipient_peer: parts[0],
          source_peer: parts[1],
          data: parts[3],
          status: PacketStatus.RECEIVED
      );
    }
    throw Exception('Invalid packet format');
  }

  String serialize() {
    return '$recipient_peer$FIELD_SEPARATOR$source_peer$FIELD_SEPARATOR$id$FIELD_SEPARATOR$data';
  }

  static String _generateId(String data) {
    return data.hashCode.toRadixString(16).substring(0, 8);
  }
}
