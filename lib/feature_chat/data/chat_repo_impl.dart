import 'package:shared/shared.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../core/local_data_repo.dart';
import '../repository/chat_repository.dart';

class ChatRepoImpl implements ChatRepository {
  final LocalDataRepo _storage;
  final WebSocketChannel _handler;

  ChatRepoImpl(this._storage, this._handler);

  @override
  Stream<List<ChatMessageInfoModel>> recieveChat() {
    return _handler.stream
        .asyncMap((event) => WsBaseMessages.parseMessage(event as String))
        .addConsec();
  }

  @override
  Future<void> sendMessage(String message, RoomModel room) async {
    final username = await _storage.getUsername();

    final model = ChatModel(
      room: room.roomId,
      username: username ?? 'anonymous',
      text: message,
      time: DateTime.now(),
    );
    _handler.sink.add(WsBaseMessages.message(model, owner: ChatOwner.client));
  }

  @override
  Stream<List<ChatMessageInfoModel>> recievePreviousChats() {
    // TODO: implement recievePreviousChats
    throw UnimplementedError();
  }
}
