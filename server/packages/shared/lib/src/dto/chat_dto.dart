import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared/src/models/chat_model.dart';

part 'chat_dto.g.dart';

@JsonSerializable()
class ChatDto {
  final String room;
  final String username;
  final String text;
  final DateTime time;

  ChatDto({
    required this.room,
    required this.username,
    required this.text,
    required this.time,
  });

  factory ChatDto.fromJson(Map<String, dynamic> json) =>
      _$ChatDtoFromJson(json);

  factory ChatDto.fromModel(ChatModel model) => ChatDto(
      username: model.username,
      text: model.text,
      time: model.time,
      room: model.room);

  Map<String, dynamic> toJson() => _$ChatDtoToJson(this);

  ChatModel toModel() =>
      ChatModel(room: room, username: username, text: text, time: time);
}
