import 'package:shared/shared.dart';

abstract class ChatRepository {
  Future<void> sendMessage(String message, RoomModel room);
  Stream<List<ChatMessageInfoModel>> recieveChat();
  Stream<List<ChatMessageInfoModel>> recievePreviousChats();
}
