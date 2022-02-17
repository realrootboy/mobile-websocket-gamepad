import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'package:flutter_gaming_controller/arrow_buttons.dart';
import 'package:flutter_gaming_controller/cross_buttons.dart';
import 'package:flutter_gaming_controller/joystick_map.dart';
import 'package:flutter_gaming_controller/message_sender.dart';

class Joystick extends StatefulWidget {
  final WebSocketChannel? _channel;
  final int currentPlayer;
  const Joystick(this._channel, this.currentPlayer, {Key? key})
      : super(key: key);
  @override
  State<Joystick> createState() => _JoystickState();
}

class _JoystickState extends State<Joystick> {
  final ButtonStyle style =
      ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 12));

  @override
  Widget build(BuildContext context) {
    Map<String, String> joystickMap =
        widget.currentPlayer == 1 ? joystick1Map() : joystick2Map();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              GestureDetector(
                onTapDown: (details) =>
                    sendMessage(widget._channel, joystickMap['aKeyDown']),
                onTapUp: (details) =>
                    sendMessage(widget._channel, joystickMap['aKeyUp']),
                child: ElevatedButton(
                  style: style,
                  onPressed: null,
                  child: const Text('L1'),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTapDown: (details) =>
                    sendMessage(widget._channel, joystickMap['bKeyDown']),
                onTapUp: (details) =>
                    sendMessage(widget._channel, joystickMap['bKeyUp']),
                child: ElevatedButton(
                  style: style,
                  onPressed: null,
                  child: const Text('R1'),
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ArrowButtons(widget._channel, joystickMap),
              Row(
                children: [
                  GestureDetector(
                    onTapDown: (details) =>
                        sendMessage(widget._channel, joystickMap['cKeyDown']),
                    onTapUp: (details) =>
                        sendMessage(widget._channel, joystickMap['cKeyUp']),
                    child: ElevatedButton(
                      style: style,
                      onPressed: null,
                      child: const Text('Select'),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  GestureDetector(
                    onTapDown: (details) =>
                        sendMessage(widget._channel, joystickMap['dKeyDown']),
                    onTapUp: (details) =>
                        sendMessage(widget._channel, joystickMap['dKeyUp']),
                    child: ElevatedButton(
                      style: style,
                      onPressed: null,
                      child: const Text('Start'),
                    ),
                  ),
                ],
              ),
              CrossButtons(widget._channel, joystickMap),
            ],
          ),
        ],
      ),
    );
  }
}
