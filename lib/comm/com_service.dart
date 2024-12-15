import 'dart:async';
import 'package:flutter/material.dart';

import 'package:flutter_p2p_connection/flutter_p2p_connection.dart';

import 'user_role.dart';

class ComService {
  static ComService? _instance;

  bool _isInitialized = false;
  String? _networkName;
  UserRole? _role;
  FlutterP2pConnection? _connection;
  final List<DiscoveredPeers> peers = [];
  WifiP2PInfo? _wifiP2PInfo;
  StreamSubscription<WifiP2PInfo>? _streamWifiInfo;
  StreamSubscription<List<DiscoveredPeers>>? _streamPeers;

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

  Future<ConnectionState> init(String networkName, UserRole role) async {
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
    });

    _isInitialized = true;

    return ConnectionState.done;
  }

  void start() {
    if (_role == UserRole.barman) {
      startAsBarman(_networkName!);
    } else if (_role == UserRole.waiter) {
      // TODO
    }
  }

  void stop() {
    _connection!.removeGroup();
  }

  Future<void> startAsBarman(String networkName) async {
    if(_wifiP2PInfo!.groupFormed) {
      return;
    }
    await _connection!.createGroup();
  }

  void removeGroup() async {
    await _connection!.removeGroup();
  }

  void discoverPeers() async {
    bool ret = await _connection!.discover();
    if(ret == false) {
      throw Exception('Failed to enable peers discovery');
    }
  }

  void stopDiscoverPeers() async {
    bool ret = await _connection!.stopDiscovery();
    if(ret == false) {
      throw Exception('Failed to stop peers discovery');
    }
  }

  Future<void> startSocket (
      void Function(String, String) onConnect,
      void Function(TransferUpdate) transferUpdate,
      void Function(dynamic) receiveString,
      ) async {
    bool started = false;
    int tryed = 0;

    if(_wifiP2PInfo != null) {

      do {
        started = await _connection!.startSocket(
          groupOwnerAddress: _wifiP2PInfo!.groupOwnerAddress,
          downloadPath: '/storage/emulated/0/Download',
          maxConcurrentDownloads: 2,
          deleteOnError: true,
          onConnect: onConnect,
          transferUpdate: transferUpdate,
          receiveString: receiveString,
        );
        if(!started) {
          tryed++;
          await Future.delayed(Duration(seconds: 1));
        }
      } while(!started && tryed < 3);


      if(!started) {
        throw Exception('Failed to start socket');
      }
    }
  }

  Future<void> connectToSocket(
      void Function(String) onConnect,
      void Function(TransferUpdate) transferUpdate,
      void Function(dynamic) receiveString,
      ) async {
    await _connection!.connectToSocket(
      groupOwnerAddress: _wifiP2PInfo!.groupOwnerAddress,
      downloadPath: '/storage/emulated/0/Download',
      maxConcurrentDownloads: 2,
      deleteOnError: true,
      onConnect: onConnect,
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
    if(!s) {
      throw Exception('Failed to send message');
    }
  }

  WifiP2PInfo getWifiP2PInfo() {
    return _wifiP2PInfo!;
  }

}
