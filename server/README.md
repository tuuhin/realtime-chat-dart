# 🧱 Server

[![Powered by Dart Frog](https://img.shields.io/endpoint?url=https://tinyurl.com/dartfrog-badge)](https://dartfrog.vgv.dev)

The backend of the app made using `dart_frog`.

## 🛰️ Description

The `server` is a  chat server meant for realtime chat communication using websockets. The server is written in `dart` and made using `dart_frog`.

### :fishing_pole_and_fish: Activate CLI

```bash
    dart pub global activate dart_frog_cli
```

This will activate the dart_frog cli ,thus providing the dart_frog executable to run and start the server

### :running: Run the server

```bash
    dart pub get
    dart_frog dev
```

## :tanabata_tree: Rest Api

The example and the endpoints to the restapi is provided below

- **Index route**

- **Create Room**

  - Endpoint: `/create-room`
  - type: `POST`

  Required a `max` in body to create a room
  
  ```bash
    curl -i -H 'Accept: application/json' -d '{"max":3}' http://localhost:8080/create_room
  ```

  Response

  ```json
    {
        "_id":"63f61e230a98bac932793734",
        "roomId":"QNQT",
        "max":3,
        "count":0
    }

  ```

  Creates a unique `roomId` and returns the roomId along with max attendes count and number of attendes that are already joined that is obious to be zero as the room is just now created

- **Check Room**

  - Endpoint: `/check_room`
  - type: `POST`

  Required a `roomId` in body to create a room
  
  ```bash
    curl -i -H 'Accept: application/json' -d '{"roomId":"QNQT"}' http://localhost:8080/check_room
  ```

  Response

  ```json
    {
        "state":"joinable",
        "room":{
            "_id":"63f61e230a98bac932793734",
            "roomId":"QNQT",
            "max":3,
            "count":0
            }
    }

  ```

  Checks the roomId and provides the state of the room whether is full,joinable or undefined,if joinable then return  the room details

- **Chat route**

  - Endpoint: `ws://<server>/ws/:roomId?username=:some`
  - type: `WEBSOCKET_CONNECTION`

  Its a dynamic route that takes the generated roomId checked or created along with the username of the user and returns a chat stream
  