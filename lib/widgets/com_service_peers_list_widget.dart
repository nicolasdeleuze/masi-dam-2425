
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../comm/com_service.dart';

class ComServicePeersListWidget extends StatefulWidget {
  ComServicePeersListWidget({super.key});

  @override
  State<ComServicePeersListWidget> createState() => _ComServicePeersListWidgetState();
}

class _ComServicePeersListWidgetState extends State<ComServicePeersListWidget> {

  @override
  Widget build(BuildContext context) {

    return Consumer<ComService>(
      builder: (context, comService, child) {
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: comService.peers.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ElevatedButton(
                      onPressed: () {
                        comService.connectToPeer(index);
                        comService.connectToSocket();
                        comService.setIsConnected(true);
                      },
                      child: Text(comService.peers[index].deviceName),
                    );
                  }
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}
