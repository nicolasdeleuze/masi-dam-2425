
import 'package:flutter/material.dart';
import 'package:masi_dam_2425/widgets/buttons/peer_button_widget.dart';
import 'package:provider/provider.dart';

import '../comm/com_service.dart';

class ComServicePeersListWidget extends StatefulWidget {
  const ComServicePeersListWidget({super.key});

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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: comService.peers.length,
                  itemBuilder: (BuildContext context, int index) {
                    return PeerButton(
                        width: MediaQuery.of(context).size.width,
                        onPressed: () {
                          comService.connectToPeer(index);
                          comService.connectToSocket();
                          comService.setIsConnected(true);
                        },
                        label: comService.peers[index].deviceName
                    );
                  }, separatorBuilder: (BuildContext context, int index) { return const SizedBox(height: 10); },
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}
