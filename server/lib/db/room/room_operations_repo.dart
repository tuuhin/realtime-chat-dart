import 'package:shared/shared.dart';

/// Chat room operations
abstract class RoomOperations {
  /// Creates a new room for the user to chat
  Future<RoomModel> createRoom();

  /// Check the room is available or not
  Future<RoomModel?> checkRoom(String room);
}
