import 'package:shared/shared.dart';

/// Repository for chats operations
abstract class ChatOperationRepo {
  /// Get all the chats assoctated with the current room
  Future<List<ChatModel>> getAllChats({required String room});

  /// Add new chat info to the room
  Future<void> insertChat({required ChatModel chat});
}
