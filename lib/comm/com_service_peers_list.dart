
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'com_service.dart';

class ComServicePeersList extends StatefulWidget {
  ComServicePeersList({super.key});

  @override
  State<ComServicePeersList> createState() => _ComServicePeersListState();
}

class _ComServicePeersListState extends State<ComServicePeersList> {

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

                        () async {
                          comService.connectToPeer(index);
                          comService.connectToSocket();
                        }();

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
