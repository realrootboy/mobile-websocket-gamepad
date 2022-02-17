import 'package:flutter/material.dart';

import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:flutter_gaming_controller/message_sender.dart';

enum Direction {
  Up,
  Down,
  Left,
  Right,
}

class ArrowButtons extends StatefulWidget {
  final WebSocketChannel? _channel;
  final Map<String, String> joystickMap;
  const ArrowButtons(this._channel, this.joystickMap, {Key? key})
      : super(key: key);
  @override
  State<ArrowButtons> createState() => _ArrowButtonsState();
}

class _ArrowButtonsState extends State<ArrowButtons> {
  final double _baseSize = 70;

  Widget _widgetButton(Color color, Direction d, onTapDown, onTapUp) {
    Icon defaultArrowIcon;

    switch (d) {
      case Direction.Up:
        defaultArrowIcon = const Icon(Icons.keyboard_arrow_up);
        break;
      case Direction.Down:
        defaultArrowIcon = const Icon(Icons.keyboard_arrow_down);
        break;
      case Direction.Left:
        defaultArrowIcon = const Icon(Icons.keyboard_arrow_left);
        break;
      case Direction.Right:
        defaultArrowIcon = const Icon(Icons.keyboard_arrow_right);
        break;
    }

    return GestureDetector(
      onTapDown: onTapDown,
      onTapUp: onTapUp,
      onVerticalDragEnd: onTapUp,
      onHorizontalDragEnd: onTapUp,
      child: Container(
        width: _baseSize,
        height: _baseSize,
        color: color,
        child: IconButton(
          color: Colors.white,
          icon: defaultArrowIcon,
          onPressed: null,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _widgetButton(
            Colors.grey,
            Direction.Up,
            (details) =>
                sendMessage(widget._channel, widget.joystickMap['eKeyDown']),
            (details) =>
                sendMessage(widget._channel, widget.joystickMap['eKeyUp'])),
        Row(
          children: [
            _widgetButton(
                Colors.grey,
                Direction.Left,
                (details) => sendMessage(
                    widget._channel, widget.joystickMap['fKeyDown']),
                (details) =>
                    sendMessage(widget._channel, widget.joystickMap['fKeyUp'])),
            Container(
                width: _baseSize, height: _baseSize, color: Colors.grey[400]),
            _widgetButton(
                Colors.grey,
                Direction.Right,
                (details) => sendMessage(
                    widget._channel, widget.joystickMap['gKeyDown']),
                (details) =>
                    sendMessage(widget._channel, widget.joystickMap['gKeyUp'])),
          ],
        ),
        _widgetButton(
            Colors.grey,
            Direction.Down,
            (details) =>
                sendMessage(widget._channel, widget.joystickMap['hKeyDown']),
            (details) =>
                sendMessage(widget._channel, widget.joystickMap['hKeyUp'])),
      ],
    );
  }
}
