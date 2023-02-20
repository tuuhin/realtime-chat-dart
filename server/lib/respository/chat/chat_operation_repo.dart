import 'package:shared/shared.dart';

/// Repository for CHATS OPERAIONS
/// The abstact class contains  functionality of a chat fucntionality
abstract class ChatOperationRepo {
  /// Get all the [ChatModel]s with the current room as a [Future]
  Future<List<ChatModel>> getAllChats({required String room});

  /// Add new [ChatModel] into the database
  Future<ChatModel> insertChat({required ChatModel chat});

  /// Delete the provided [ChatModel]
  Future<void> deleteChat({required ChatModel chat});

  /// Get [ChatModel]s via a stream
  Stream<ChatModel> streamChats({required String room});
}
