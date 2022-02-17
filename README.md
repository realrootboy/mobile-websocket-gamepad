# mobile-websocket-gamepad
 A cross-platform mobile application that simulates a gamepad for games, communicating with peripherals via websockets.

## Server Setup

To install python server requeriments:
```
pip install websockets
pip install pyautogui
```
Set your IP Address in main.py:
```
start_server = websockets.serve(handler, <IP_ADDRESS>, 8001)
```
Run the code:
```
python3 main.py
```

## Server Setup

To install flutter client requeriments:
```
flutter pub get
```
Run the code:
```
flutter run lib/main.dart
```
