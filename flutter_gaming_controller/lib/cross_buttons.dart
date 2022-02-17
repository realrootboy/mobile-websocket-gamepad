import 'package:flutter/material.dart';

import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:flutter_gaming_controller/message_sender.dart';

class CrossButtons extends StatefulWidget {
  final WebSocketChannel? _channel;
  final Map<String, String> joystickMap;
  const CrossButtons(this._channel, this.joystickMap, {Key? key})
      : super(key: key);
  @override
  State<CrossButtons> createState() => _CrossButtonsState();
}

class _CrossButtonsState extends State<CrossButtons> {
  final double _baseSize = 70;

  Widget _widgetButton(Color color, onTapDown, onTapUp) {
    return GestureDetector(
      onTapDown: onTapDown,
      onTapUp: onTapUp,
      onVerticalDragEnd: onTapUp,
      onHorizontalDragEnd: onTapUp,
      child: SizedBox(
        width: _baseSize,
        height: _baseSize,
        child: Ink(
          decoration: ShapeDecoration(
            color: color,
            shape: const CircleBorder(),
          ),
          child: const IconButton(
            color: Colors.white,
            icon: Icon(Icons.radio_button_unchecked_sharp),
            onPressed: null,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _widgetButton(
            Colors.yellow,
            (details) =>
                sendMessage(widget._channel, widget.joystickMap['iKeyDown']),
            (details) =>
                sendMessage(widget._channel, widget.joystickMap['iKeyUp'])),
        Row(
          children: [
            _widgetButton(
                Colors.blue,
                (details) => sendMessage(
                    widget._channel, widget.joystickMap['jKeyDown']),
                (details) =>
                    sendMessage(widget._channel, widget.joystickMap['jKeyUp'])),
            SizedBox(
              width: _baseSize,
              height: _baseSize,
            ),
            _widgetButton(
                Colors.red,
                (details) => sendMessage(
                    widget._channel, widget.joystickMap['kKeyDown']),
                (details) =>
                    sendMessage(widget._channel, widget.joystickMap['kKeyUp'])),
          ],
        ),
        _widgetButton(
            Colors.green,
            (details) =>
                sendMessage(widget._channel, widget.joystickMap['lKeyDown']),
            (details) =>
                sendMessage(widget._channel, widget.joystickMap['lKeyUp'])),
      ],
    );
  }
}
