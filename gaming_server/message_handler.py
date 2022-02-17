import json
import pyautogui

def handle_message(websocket, message):
    print("Received message: " + message)
    try:
        print(message)
        message = json.loads(message)
        key = message["key"]
        action = message["action"]

        if(action=='keyDown'):
            pyautogui.keyDown(key)
        elif(action=='keyUp'):
            pyautogui.keyUp(key)
    except:
        print("error")