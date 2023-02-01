import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared/shared.dart';

class RoomApi {
  static final _endpoint =
      dotenv.get('SERVER_HOST', fallback: 'http://10.0.2.2:8080');

  final _dio = Dio(BaseOptions(baseUrl: _endpoint));

  Future<RoomDto> createRoom() async {
    Response resp = await _dio.get('create_room');
    return RoomDto.fromJson(resp.data);
  }

  Future<RoomDto> checkRoom() async {
    Response resp = await _dio.get('check_room');
    return RoomDto.fromJson(resp.data);
  }
}
