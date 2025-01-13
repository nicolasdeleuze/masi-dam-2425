import 'package:masi_dam_2425/comm/packet_status.dart';
import 'package:masi_dam_2425/comm/packet_type.dart';

class Packet {
  static const String FIELD_SEPARATOR = ';';

  final String id;                  // unique identifier based on trunckated hash of the data and timestamp
  final String recipient;
  final String source;
  final String data;
  final PacketType type;
  final PacketStatus status;        // status not used in transmission, but helps MessageManager to manage packets

  Packet(
    {
      required this.id,
      required this.recipient,
      required this.source,
      required this.data,
      required this.type,
      required this.status
    }
  );

  Packet.create(
    {
      required String recipent,
      required String source,
      required String data,
      required PacketType type,
      required PacketStatus status
    }
  ) : this(
    id : _generateId(data),
    recipient: recipent,
    source: source,
    data: data,
    type: type,
    status: status
  );

  static Packet parse(String packet) {
    List<String> parts = packet.split(FIELD_SEPARATOR);
    if(parts.length == 5) {
      return Packet(
          id: parts[2],
          recipient: parts[0],
          source: parts[1],
          data: parts[4],
          type: PacketType.parse(int.parse(parts[3])),
          status: PacketStatus.RECEIVED
      );
    }
    throw Exception('Invalid packet format');
  }

  void debug() {
    print("Packet : ");
    print("\t id : $id");
    print("\t recipent : $recipient");
    print("\t source : $source");
    print("\t data : $data");
    print("\t type : $type");
    print("\t status : $status");
  }

  String serialize() {
    return '$recipient$FIELD_SEPARATOR$source$FIELD_SEPARATOR$id$FIELD_SEPARATOR${type.index}$FIELD_SEPARATOR$data';
  }

  static String _generateId(String data) {
    var time = DateTime.now().millisecondsSinceEpoch;
    var hash_time = time.hashCode.toRadixString(time.toString().length % 36);
    var hash_data = data.hashCode.toRadixString(data.length % 36);
    return '$hash_time$hash_data';
  }
}
