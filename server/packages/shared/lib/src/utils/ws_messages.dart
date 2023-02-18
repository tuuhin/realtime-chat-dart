import 'dart:convert';

import 'package:shared/shared.dart';

/// The base messages associated with websockets like joined, messages and
/// dissconnected, this class is handy as we can just send string this will
/// convert them into string
class WsBaseMessages {
  /// The user joined message
  static String joined(String username) => jsonEncode(ChatInfoDto.fromModel(
        ChatMessageInfoModel(
          owner: ChatOwner.server,
          type: ChatMessageDataType.joined,
          extra: '$username joined the room',
        ),
      ).toJson());

  ///User dissconneted message
  static String dissconnected(String username, {String? reason}) =>
      jsonEncode(ChatInfoDto.fromModel(
        ChatMessageInfoModel(
          owner: ChatOwner.server,
          type: ChatMessageDataType.disconnected,
          extra: '$username disconnected ${reason ?? ''}',
        ),
      ).toJson());

  /// User sends a message to the other sockets
  static String message(ChatModel chat, {required ChatOwner owner}) =>
      jsonEncode(ChatInfoDto.fromModel(
        ChatMessageInfoModel(
          type: ChatMessageDataType.message,
          model: chat,
          owner: owner,
        ),
      ).toJson());

  /// Parses the incomming message
  static ChatMessageInfoModel parseMessage(String data) {
    final jsonData = jsonDecode(data) as Map<String, dynamic>;

    return ChatInfoDto.fromJson(jsonData).toModel();
  }
}
