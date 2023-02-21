import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared/shared.dart';

class RoomApi {
  static final _endpoint =
      dotenv.get('SERVER_HOST', fallback: 'http://10.0.2.2:8080');

  static final _dio = Dio(
    BaseOptions(
      baseUrl: _endpoint,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
      responseType: ResponseType.json,
      contentType: 'application/json',
    ),
  );

  Future<RoomDto> createRoom(int max) async {
    Response resp = await _dio.post(
      '/create_room',
      data: jsonEncode(<String, int>{"max": max}),
    );
    return RoomDto.fromJson(resp.data);
  }

  Future<CheckRoomDto> checkRoom(String room) async {
    Response resp = await _dio.post(
      '/check_room',
      data: jsonEncode(<String, String>{"roomId": room}),
    );
    return CheckRoomDto.fromJson(resp.data);
  }
}
