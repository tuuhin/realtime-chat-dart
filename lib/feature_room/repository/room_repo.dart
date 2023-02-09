import 'package:shared/shared.dart';

abstract class RoomRepo {
  Stream<Resource<RoomModel>> createRoom();

  Stream<Resource<CheckRoomModel?>> checkRoom(String room);
}
