import 'dart:collection';

import 'package:masi_dam_2425/comm/com_service.dart';
import 'package:masi_dam_2425/comm/packet_status.dart';
import 'package:masi_dam_2425/comm/packet.dart';

class MessageManager {
  static MessageManager? _instance;

  static MessageManager getInstance() {
    if(_instance == null) {
      _instance = MessageManager._();
    }
    return _instance!;
  }

  final ComService _comService = ComService.getInstance();


  // TODO
  // a récuperer depuis ComService
  final String source_peer_address = "";
  final String dest_peer_address = "";

  // contains messages serialized
  final Queue<Packet> _pkt_to_send = Queue<Packet>();
  final Queue<Packet> _pkt_in_transit = Queue<Packet>();
  final Queue<Packet> _pkt_received = Queue<Packet>();
  bool _isRunning = false;

  MessageManager._();

  void start() {
    if(_isRunning) {
      return;
    }
    _isRunning = true;
    _run();
  }

  void stop() {
    if(!_isRunning) {
      return;
    }
    _isRunning = false;
  }

  void addMessageToSend(String message) {
    Packet packet = Packet.create(
      recipent: dest_peer_address,
      source: source_peer_address,
      data: message,
      status: PacketStatus.TO_SEND
    );
    _pkt_to_send.add(packet);
  }

  void addMessageReceived(String serializedMessage) {
    Packet packet = Packet.parse(serializedMessage);
    _pkt_received.add(packet);
  }

  void _run() async {
    while(_isRunning) {
      // TODO
      // manage messages
    }
  }
}
