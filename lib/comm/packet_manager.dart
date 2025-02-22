import 'dart:collection';

import 'package:masi_dam_2425/comm/com_service.dart';
import 'package:masi_dam_2425/comm/packet_status.dart';
import 'package:masi_dam_2425/comm/packet.dart';
import 'package:masi_dam_2425/comm/packet_type.dart';
import 'package:masi_dam_2425/model/order.dart';
import 'package:masi_dam_2425/model/roles.dart';
import 'package:masi_dam_2425/view_model/order_view_model.dart';
import 'package:masi_dam_2425/view_model/product_view_model.dart';

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

  int _idx_received_order = 0;
  final ComService _comService;
  late OrderViewModel _orderViewModel;
  late ProductViewModel _productViewModel;
  String _source = "UNKNOWN";
  String _destination = "UNKNOWN";
  final List<String> _knownPeers = [];
  final Queue<Packet> _pkt_to_send = Queue<Packet>();       // contains messages serialized
  final Queue<Packet> _pkt_in_transit = Queue<Packet>();
  final Queue<Packet> _pkt_received = Queue<Packet>();
  bool _isRunning = false;

  void setViewModel(
    {
      required OrderViewModel orderViewModel,
      required ProductViewModel productViewModel
    }
  ) {
    _orderViewModel = orderViewModel;
    _productViewModel = productViewModel;
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
      data: "<R${role.index}>$_source",
      type: PacketType.WHO,
      status: PacketStatus.TO_SEND
    );
    _pkt_to_send.add(packet);
  }

  void addMessageToSend({required dynamic object, PacketType type = PacketType.ORDER}) {
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
      case PacketType.STRING:
        data = object as String;
        break;
      case PacketType.ORDER:
        data = (object as Order).toJson();
        break;
      case(PacketType.WHO):
        data = object as String;
        break;
      case PacketType.PRODUCTS_FOR_SALE:
        break;
      case PacketType.ACK:
        data = object as String;
        break;
      default:
        throw Exception("Unsupported type");
    }
    return data;
  }

  dynamic _stringToObject(String data, PacketType type) {
    dynamic object;
    switch(type) {
      case PacketType.STRING:
        object = data;
        break;
      case PacketType.ORDER:
        object = Order.fromJson(data);
        break;
      case PacketType.WHO:
        object = data;
        break;
      case PacketType.PRODUCTS_FOR_SALE:
        break;
      case PacketType.ACK:
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

        // print("PcktManager : ${_source}");
        // packet.debug();

        // test if packet is for me
        if(packet.recipient == _source || packet.type == PacketType.WHO) {
          _processReceivedPacket(packet);
        }
      }
    }
  }

  void _processReceivedPacket(Packet packet) {
    dynamic object = _stringToObject(packet.data, packet.type);
    switch(packet.type) {
      case PacketType.ORDER:
        // send ACK
        Packet ack = Packet.create(
            recipent: packet.source,
            source: packet.recipient,
            data: packet.id,
            type: PacketType.ACK,
            status: PacketStatus.TO_SEND
        );
        _pkt_to_send.add(ack);
        Order order = object as Order;
        order.id = _getWaiterIDFromSource(packet.source);
        _orderViewModel.addReceivedOrder(order);
        break;
      case PacketType.WHO:
        // data structure:
        // <R${role.index}>${_source} in case of identification
        // <ACK>${packet.source} in case of ACK
        String data = object as String;
        if (data.startsWith("<R")) {
          Role mine = _comService.getRole();
          Role role = Role.parse(int.parse(data.substring(2, 3)));
          String source = data.substring(4);
          if(!_knownPeers.contains(source)) {
            _knownPeers.add(source);
            // send response
            Packet response = Packet.create(
                recipent: packet.source,
                source: _source,
                data: "<R${mine.index}>$_source",
                type: PacketType.WHO,
                status: PacketStatus.TO_SEND
            );
            _pkt_to_send.add(response);
            Packet productSaleExchange = Packet.create(
                recipent: packet.source,
                source: _source,
                data: _productViewModel.toJson(),
                type: PacketType.PRODUCTS_FOR_SALE,
                status: PacketStatus.TO_SEND
            );
            _pkt_to_send.add(productSaleExchange);
          }
          else {
            // send ACK
            Packet ack = Packet.create(
                recipent: packet.source,
                source: packet.recipient,
                data: "<ACK>${packet.source}",
                type: PacketType.WHO,
                status: PacketStatus.TO_SEND
            );
            _pkt_to_send.add(ack);
          }
          if (role == Role.bartender) {
            _destination = source;
          }
        } else if (data.startsWith("<ACK>")) {
          String source = data.substring(5);
          if(!_knownPeers.contains(source)) {
            _knownPeers.add(source);
          }
        }
        break;
      case PacketType.PRODUCTS_FOR_SALE:
        _productViewModel.fromJson(packet.data);
        Packet ack = Packet.create(
            recipent: packet.source,
            source: packet.recipient,
            data: packet.id,
            type: PacketType.ACK,
            status: PacketStatus.TO_SEND
        );
        _pkt_to_send.add(ack);
        break;
      case PacketType.ACK:
        // remove packet from _pkt_in_transit
        _pkt_in_transit.removeWhere((element) => element.id == packet.data);
        break;
      default:
        throw Exception("Unsupported type");
    }
  }

  int _getWaiterIDFromSource(String source) {
    int idxFirstInt = source.indexOf(RegExp(r'[0-9]'));
    int idFirstPart = int.parse(source.substring(idxFirstInt));
    int idSecondPart = _idx_received_order;
    _idx_received_order++;
    String strSecondId = idSecondPart.toString();
    int padding = 4 - strSecondId.length;
    strSecondId = "0" * padding + strSecondId;
    return int.parse("$idFirstPart$strSecondId");
  }
}
