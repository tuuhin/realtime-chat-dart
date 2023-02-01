import 'package:shared/shared.dart';

abstract class RoomRepo {
  Stream<Resource<RoomModel>> createRoom();

  Stream<Resource<RoomModel?>> checkRoom(String room);
}
