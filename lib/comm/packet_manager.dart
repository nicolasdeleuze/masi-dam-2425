import 'dart:collection';

import 'package:masi_dam_2425/comm/com_service.dart';
import 'package:masi_dam_2425/comm/packet_status.dart';
import 'package:masi_dam_2425/comm/packet.dart';
import 'package:masi_dam_2425/model/order.dart';
import 'package:masi_dam_2425/view_model/order_view_model.dart';

class PacketManager {
  static PacketManager? _instance;

  PacketManager._({required ComService comService}) : _comService = comService;

  static PacketManager getInstance({ComService? comService}) {
    if(_instance == null) {
      if (comService == null) {
        throw Exception("ComService is required");
      }
      _instance = PacketManager._(comService : comService);
    }
    return _instance!;
  }

  late ComService _comService;
  late OrderViewModel _orderViewModel;
  String _source = "UNKNOWN_CLENT";
  String _destination = "UNKNOWN_ROOT";
  final Queue<Packet> _pkt_to_send = Queue<Packet>();       // contains messages serialized
  final Queue<Packet> _pkt_in_transit = Queue<Packet>();
  final Queue<Packet> _pkt_received = Queue<Packet>();
  bool _isRunning = false;

  void setOrderViewModel(OrderViewModel orderViewModel) {
    _orderViewModel = orderViewModel;
  }

  void setUserID(String userID) {
    _source = userID;
  }

  void start() async {
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

  void identifyToRoot() {
    Packet packet = Packet.create(
      recipent: _destination,
      source: _source,
      data: "<WHO>${_source}",
      status: PacketStatus.TO_SEND
    );
    _pkt_to_send.add(packet);
  }

  void addMessageToSend(dynamic object) {
    Packet packet = Packet.create(
      recipent: _destination,
      source: _source,
      data: _objectToString(object),
      status: PacketStatus.TO_SEND
    );
    _pkt_to_send.add(packet);
  }

  void addMessageReceived(String serializedMessage) {
    Packet packet = Packet.parse(serializedMessage);
    _pkt_received.add(packet);
  }

  String _objectToString(dynamic object) {
    String data = "";
    switch(object.runtimeType) {
      case String:
        data = '<STRING>${object as String}';
        break;
      case Packet:
        data = '<PACKET>${(object as Packet).data}';
        break;
      case Order:
        data = '<ORDER>${(object as Order).toJson()}';
        break;
      default:
        throw Exception("Unsupported type");
    }
    return data;
  }

  dynamic _stringToObject(String data) {
    dynamic object;
    if(data.startsWith("<STRING>")) {
      object = data.substring(8);
    } else if(data.startsWith("<PACKET>")) {
      object = Packet.parse(data.substring(8));
    } else if(data.startsWith("<ORDER>")) {
      object = Order.fromJson(data.substring(7));
    }
    else {
      throw Exception("Unsupported type");
    }
    return object;
  }

  void _run() async {
    while(_isRunning) {
      // manage messages
      while(_pkt_received.isEmpty && _pkt_to_send.isEmpty) {
        await Future.delayed(Duration(milliseconds: 500));
      }

      // send messages
      while(_pkt_to_send.isNotEmpty) {
        Packet packet = _pkt_to_send.removeFirst();
        _pkt_in_transit.add(packet);
        _comService.sendString(packet.serialize());
      }

      // receive messages
      while(_pkt_received.isNotEmpty) {
        Packet packet = _pkt_received.removeFirst();
        // test if packet is for me
        if(packet.recipient == _source) {
          if(packet.data.startsWith("ACK>")) {
            // remove packet from _pkt_in_transit
            _pkt_in_transit.removeWhere((element) => element.id == packet.data.substring(4));
          } else {
            // send ACK
            Packet ack = Packet.create(
              recipent: packet.source,
              source: packet.recipient,
              data: "ACK>${packet.id}",
              status: PacketStatus.TO_SEND
            );
            _pkt_to_send.add(ack);
            processReceivedPacket(packet);
          }
        }
      }
    }
  }

  void processReceivedPacket(Packet packet) {
    dynamic object = _stringToObject(packet.data);
    switch(object.runtimeType) {
      case Order:
        Order order = object as Order;
        // TODO
        // mettre à jour le viewmodel Order
        break;
      case Packet:
        Packet packet = object as Packet;
        _comService.snack("${packet.data}");
        break;
      case String:
        _comService.snack("${object as String}");
        break;
      default:
        throw Exception("Unsupported type");
    }
  }
}
