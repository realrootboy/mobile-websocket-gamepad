import 'package:web_socket_channel/web_socket_channel.dart';

void sendMessage(WebSocketChannel? _channel, message) {
  if (_channel == null) {
    return;
  }

  _channel.sink.add(message);
}
