import 'package:shared/shared.dart';

abstract class ChatRepository {
  Future<void> sendMessage(String message, String room);
  Stream<ChatMessageInfoModel> recieveChat();
  Stream<ChatMessageDataType> showChats();
}
