# 🗨️  Reatime Chat App

A chat app made using using Flutter and Dart Frog and websockets

## :apple: App

The App is a simple flutter app with a custom backend for chatting service with websockets.

## :construction_worker: Structure

The app is streatured in a feature based way.There are mainly two features

- **Core**
    Core contains the localstorage logic,localStorage here is key-value pair for storing the username and that is easily done with the help of `sharedpreferences` package.

- **Feature Chats**
  
    This includes all the chatting features including the websocket connection managing the state of the incomming messages and more.

- **Features Room**

    Before joining a chat room one requires to create or check room. These are handle by the room feture checking the room credentials and allowing the user to join the room or not.

### :racehorse: Start the App

- Get the depedencies

    ```bash
        flutter pub get
    ```

- Make sure you read the instructions on the [shared](./server/packages/shared/README.md) and [server](./server/README.md)

- Start the server
- Start the app

    ```bash
        flutter run
    ```

### :orange: Server

For information regarding the [server](./server/README.md)

### :1234: Conclusion

The app was created to try out `websockets` and `dart_frog` with flutter. The chats are working fine .Thus it was a good project
