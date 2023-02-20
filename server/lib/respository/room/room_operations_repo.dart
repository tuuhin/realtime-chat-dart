import 'package:shared/shared.dart';

/// Abstract Chat Room Operations class that can be implemented for database
/// operation
abstract class RoomOperations {
  /// Creates a new room for the user to chat and returns  [RoomModel] instance
  Future<RoomModel> createRoom({required int max});

  /// Check the room is available or not and returns [CheckRoomModel] instance
  Future<CheckRoomModel> checkRoom({required String room});

  /// Updated the room count when a user joins or leave the room
  Future<void> updateRoom({required String room, required int newCount});
}
