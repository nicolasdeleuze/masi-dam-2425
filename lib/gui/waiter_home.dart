import 'package:flutter/material.dart';
import 'package:masi_dam_2425/comm/com_service.dart';
import 'package:masi_dam_2425/comm/com_service_peers_list.dart';
import 'package:masi_dam_2425/theme/colors/light_colors.dart';

import 'theme.dart';

class WaiterHomeWidget extends StatelessWidget {
  WaiterHomeWidget({super.key, required this.comService});

  ComService comService;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Waiter'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Spacer(),


            // TODO
            // List all available networks
            // make it selecteable

            Expanded(
                child:  ComServicePeersList(comService: comService),
            ),



            ElevatedButton(
              onPressed: () {

                // TODO
                // Join selected network
                // launch communication service as waiter
                // Go to waiter orders page

              },
              style: homeButtonStyle(LightColors.kLightGreen, LightColors.kDarkBlue),
              child: const Text(
                'Join network',
                style: homeButtonTextStyle,
              ),
            ),
            Spacer()
          ],
        ),
      ),
    );
  }
}