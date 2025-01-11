import 'dart:async';
import 'package:flutter/material.dart';

import 'package:flutter_p2p_connection/flutter_p2p_connection.dart';
import 'package:masi_dam_2425/comm/msg_manager.dart';
import 'package:masi_dam_2425/model/roles.dart';


class ComService extends ChangeNotifier {
  static ComService? _instance;
  static BuildContext _context = null as dynamic;

  bool isConnected = false;
  bool _isInitialized = false;
  String? _networkName;
  Role? _role;
  FlutterP2pConnection? _connection;
  final List<DiscoveredPeers> peers = [];
  WifiP2PInfo? _wifiP2PInfo;
  StreamSubscription<WifiP2PInfo>? _streamWifiInfo;
  StreamSubscription<List<DiscoveredPeers>>? _streamPeers;

  MessageManager _msgManager = MessageManager.getInstance();

  // private constructor
  ComService._() {
    _connection = FlutterP2pConnection();
  }

  static ComService getInstance() {
    if(_instance == null) {
      _instance = ComService._();
    }
    return _instance!;
  }

  void setIsConnected(bool value) {
    isConnected = value;
    notifyListeners();
  }

  void setContext(BuildContext context) {
    _context = context;
  }

  void snack(String msg) async {
    ScaffoldMessenger.of(_context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        content: Text(
          msg,
        ),
      ),
    );
  }

  void on_connect_start_socket(String name, String address) {
    snack('Connected to $address');
  }

  void on_connect_connect(String address) {
    snack('Connected to $address');
  }

  void transferUpdate(TransferUpdate event) {
    throw UnimplementedError();
  }

  void receiveString(dynamic obj) {
    if (obj is String) {
      String message = obj;
      _msgManager.addMessageReceived(message);
    }
    else {
      snack('Received unknown message : $obj');
    }
  }

  Future<ConnectionState> init(String networkName, Role role) async {
    if(_isInitialized && _networkName != null && _role != null && _networkName == networkName && _role == role) {
      return ConnectionState.done;
    }
    else {
      _isInitialized = false;
      if(_networkName != null && _role != null) {
        await _connection!.unregister();
      }
    }
    _networkName = networkName;
    _role = role;

    // check authorization
    int isAllAuthorized = 0;
    do {
      isAllAuthorized = 0;

      if(await _connection!.checkLocationEnabled()) {
        isAllAuthorized++;
      } else {
        await _connection!.askLocationPermission();
      }

      if(await _connection!.checkStoragePermission()) {
        isAllAuthorized++;
      } else {
        await _connection!.askStoragePermission();
      }

      if(await _connection!.checkWifiEnabled()) {
        isAllAuthorized++;
      } else {
        if(await _connection!.enableWifiServices()) {
          isAllAuthorized++;
        }
      }

    } while(isAllAuthorized != 3);

    await _connection!.initialize();
    await _connection!.register();

    _streamWifiInfo = _connection!.streamWifiP2PInfo().listen((event) {
      _wifiP2PInfo = event;
      print("Listen Group Owner Address: ${_wifiP2PInfo!.groupOwnerAddress}");
    });

    _streamPeers = _connection!.streamPeers().listen((event) {
      peers.clear();
      peers.addAll(event);
      print("Listen Peers: ${peers.length}");
      print("Listen Peers: ${peers}");
      notifyListeners();
    });

    _isInitialized = true;

    if(_role == Role.waiter) {
      await _connection!.discover();
    }

    print("Init done");

    return ConnectionState.done;
  }

  void start() {
    if (_role == Role.bartender) {
      startAsBarman(_networkName!);
    }
  }

  void stop() async {
    await _connection!.removeGroup();
  }

  Future<void> startAsBarman(String networkName) async {
    while(_wifiP2PInfo == null) {
      await Future.delayed(Duration(milliseconds: 500));
    }

    if(_wifiP2PInfo!.groupFormed) {
      return;
    }
    await _connection!.createGroup();
  }

  void connectToPeer(int index) async {
    DiscoveredPeers peer = peers[index];
    await _connection!.connect(peer.deviceAddress);
  }

  Future<void> discoverPeers() async {
    print("Discover peers");
    do {
      await Future.delayed(Duration(milliseconds: 500));
    } while(_isInitialized == false);
    bool ret = await _connection!.discover();
    if(ret == false) {
      throw Exception('Failed to enable peers discovery');
    }
    print("Discover peers done");
  }

  void stopDiscoverPeers() async {
    bool ret = await _connection!.stopDiscovery();
    if(ret == false) {
      throw Exception('Failed to stop peers discovery');
    }
  }

  Future<void> startSocket () async {
    dynamic dyn_started;  // rustine ...
    bool started = false;
    int tryed = 0;

    do {
      while(_wifiP2PInfo == null) {
        await Future.delayed(Duration(milliseconds: 500));
      }

      while(!_wifiP2PInfo!.groupFormed) {
        await Future.delayed(Duration(milliseconds: 500));
      }

      dyn_started = _connection!.startSocket(
        groupOwnerAddress: _wifiP2PInfo!.groupOwnerAddress,
        downloadPath: '/storage/emulated/0/Download',
        maxConcurrentDownloads: 2,
        deleteOnError: true,
        onConnect: on_connect_start_socket,
        transferUpdate: transferUpdate,
        receiveString: receiveString,
      );
      if (dyn_started is bool) {
        started = dyn_started;
      }
      else {
        if (dyn_started is Future<bool>) {
          started = await dyn_started;
        }
      }

      if(!started) {
        tryed++;
        Future.delayed(Duration(seconds: 1));
      }
    } while(!started && tryed < 3);

    if(!started) {
      throw Exception('Failed to start socket');
    }
  }

  Future<void> connectToSocket() async {
    while(_wifiP2PInfo == null) {
      await Future.delayed(Duration(milliseconds: 500));
    }
    while(!_wifiP2PInfo!.groupFormed) {
      await Future.delayed(Duration(milliseconds: 500));
    }
    await _connection!.connectToSocket(
      groupOwnerAddress: _wifiP2PInfo!.groupOwnerAddress,
      downloadPath: '/storage/emulated/0/Download',
      maxConcurrentDownloads: 2,
      deleteOnError: true,
      onConnect: on_connect_connect,
      transferUpdate: transferUpdate,
      receiveString: receiveString,
    );
  }

  Future<void> closeSocket() async {
    bool s = _connection!.closeSocket();
    if(!s) {
      throw Exception('Failed to close socket');
    }
  }

  Future<void> sendString(String message) async {
    bool s = _connection!.sendStringToSocket(message);
    print("Send message: $message");
    if(!s) {
      throw Exception('Failed to send message');
    }
  }

  WifiP2PInfo getWifiP2PInfo() {
    return _wifiP2PInfo!;
  }

}
