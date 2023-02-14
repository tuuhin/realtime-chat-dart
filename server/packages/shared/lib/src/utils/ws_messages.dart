import 'dart:convert';

import 'package:shared/shared.dart';

/// The base messages associated with websockets like joined, messages and
/// dissconnected, this class is handy as we can just send string this will
/// convert them into string
class WsBaseMessages {
  /// The user joined message
  static String joined(String username) => ChatInfoDto.fromModel(
        ChatMessageInfoModel(
          type: ChatMessageDataType.joined,
          extra: '$username joined the room',
        ),
      ).toJson().toString();

  ///User dissconneted message
  static String dissconnected(String username, {String? reason}) =>
      ChatInfoDto.fromModel(
        ChatMessageInfoModel(
          type: ChatMessageDataType.disconnected,
          extra: '$username disconnected ${reason ?? ''}',
        ),
      ).toJson().toString();

  /// User sends a message to the other sockets
  static String message(ChatModel chat) => ChatInfoDto.fromModel(
        ChatMessageInfoModel(type: ChatMessageDataType.message, model: chat),
      ).toJson().toString();

  /// Parses the incomming message
  static ChatMessageInfoModel parseMessage(String data) {
    final jsonData = jsonDecode(data) as Map<String, dynamic>;

    return ChatInfoDto.fromJson(jsonData).toModel();
  }
}
