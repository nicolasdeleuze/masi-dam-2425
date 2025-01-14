import 'dart:collection';

import 'package:masi_dam_2425/comm/com_service.dart';
import 'package:masi_dam_2425/comm/packet_status.dart';
import 'package:masi_dam_2425/comm/packet.dart';
import 'package:masi_dam_2425/comm/packet_type.dart';
import 'package:masi_dam_2425/model/order.dart';
import 'package:masi_dam_2425/model/roles.dart';
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
  String _source = "UNKNOWN";
  String _destination = "UNKNOWN";
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
    Role role = _comService.getRole();
    Packet packet = Packet.create(
      recipent: _destination,
      source: _source,
      data: "<R${role.index}>${_source}",
      type: PacketType.Who,
      status: PacketStatus.TO_SEND
    );
    _pkt_to_send.add(packet);
  }

  void addMessageToSend({required dynamic object, PacketType type = PacketType.Order}) {
    late Packet packet;
    packet = Packet.create(
      recipent: _destination,
      source: _source,
      data: _objectToString(object, type),
      type: type,
      status: PacketStatus.TO_SEND
    );
    _pkt_to_send.add(packet);
  }

  void addMessageReceived(String serializedMessage) {
    Packet packet = Packet.parse(serializedMessage);
    _pkt_received.add(packet);
  }

  String _objectToString(dynamic object, PacketType type) {
    String data = "";
    switch(type) {
      case PacketType.String:
        data = '${object as String}';
        break;
      case PacketType.Order:
        data = '${(object as Order).toJson()}';
        break;
      case(PacketType.Who):
        data = '${object as String}';
        break;
      case PacketType.Ack:
        data = '${object as String}';
        break;
      default:
        throw Exception("Unsupported type");
    }
    return data;
  }

  dynamic _stringToObject(String data, PacketType type) {
    dynamic object;
    switch(type) {
      case PacketType.String:
        object = data;
        break;
      case PacketType.Order:
        object = Order.fromJson(data);
        break;
      case PacketType.Who:
        object = data;
        break;
      case PacketType.Ack:
        object = data;
        break;
      default:
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
        if(packet.recipient == _source || packet.type == PacketType.Who) {

          if(packet.type == PacketType.Ack) {
            // remove packet from _pkt_in_transit
            _pkt_in_transit.removeWhere((element) => element.id == packet.data);
          } else {
            // send ACK
            Packet ack = Packet.create(
              recipent: packet.source,
              source: packet.recipient,
              data: "${packet.id}",
              type: PacketType.Ack,
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
    dynamic object = _stringToObject(packet.data, packet.type);
    switch(object.runtimeType) {
      case Order:
        Order order = object as Order;
        // TODO
        // mettre à jour le viewmodel Order
        break;
      case String:
        _comService.snack("${object as String}");
        break;
      case PacketType.Who:
        // data structure: <R${role.index}>${_source}
        String data = object as String;
        int roleIndex = int.parse(data.substring(2, 3));
        Role role = Role.parse(roleIndex);
        String source = data.substring(3);
        if (role == Role.bartender) {
          _destination = source;
        }
        break;
      case PacketType.Ack:
        _comService.snack("Received Ack for ${packet.id}");
        break;
      default:
        throw Exception("Unsupported type");
    }
  }
}
