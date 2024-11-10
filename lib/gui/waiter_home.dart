import 'package:flutter/material.dart';

import 'theme.dart';

class WaiterHomeWidget extends StatelessWidget {
  const WaiterHomeWidget({Key? key}) : super(key: key);

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
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Spacer(),


            // TODO
            // List all available networks
            // make it selecteable



            ElevatedButton(
              onPressed: () {

                // TODO
                // Join selected network
                // launch communication service as waiter
                // Go to waiter orders page

              },
              style: homeButtonStyle,
              child: const Text(
                'Join network',
                style: homeButtonTextStyle,
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}