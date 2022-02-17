import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'package:flutter_gaming_controller/joystick.dart';
import 'package:flutter_gaming_controller/theme_scaffold.dart';
import 'package:prompt_dialog/prompt_dialog.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Remote Joystick',
      theme: defaultTheme(),
      home: const MyHomePage(title: 'Remote Joystick'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  WebSocketChannel? _channel;
  String _ipAddress = "";

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  void dispose() {
    _channel?.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).primaryColor,
        child: Row(
          children: [
            StreamBuilder(
              stream: _channel?.stream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  return Row(children: <Widget>[
                    IconButton(
                        icon: const Icon(Icons.play_arrow),
                        color: Colors.green,
                        onPressed: () {
                          setState(() {
                            _channel?.sink.close();

                            _channel = null;
                          });
                        }),
                    Text('Connected to ws://$_ipAddress:8001',
                        style: const TextStyle(color: Colors.green))
                  ]);
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Row(children: <Widget>[
                    IconButton(
                        icon:
                            const Icon(Icons.local_convenience_store_outlined),
                        color: Colors.blue,
                        onPressed: () {
                          setState(() {
                            _channel?.sink.close();
                            _channel = null;
                          });
                        }),
                    Text('Connecting to ws://$_ipAddress:8001',
                        style: const TextStyle(color: Colors.blue))
                  ]);
                } else {
                  return Row(children: <Widget>[
                    IconButton(
                        icon: const Icon(Icons.play_disabled),
                        color: Colors.red,
                        onPressed: () async {
                          _ipAddress = await prompt(context,
                                  title: const Text(
                                      'Websocket Server Address:')) ??
                              "";
                          setState(() {
                            _channel?.sink.close();
                            _channel = WebSocketChannel.connect(
                                Uri.parse('ws://$_ipAddress:8001'));
                          });
                        }),
                    const Text('Disconnected',
                        style: TextStyle(color: Colors.red))
                  ]);
                }
              },
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.gamepad_outlined),
                    color: Colors.green,
                    tooltip: 'Current Player',
                    onPressed: () {
                      setState(() {});
                    },
                  ),
                  const Text('Current player: 1',
                      style: TextStyle(color: Colors.green)),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.more_vert),
              color: Colors.white,
              tooltip: 'Menu',
              onPressed: () {
                setState(() {});
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Joystick(_channel, 1)],
        ),
      ),
    );
  }
}
