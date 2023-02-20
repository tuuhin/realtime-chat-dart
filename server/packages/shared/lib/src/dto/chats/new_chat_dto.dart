import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared/shared.dart';
import 'package:shared/src/models/chat_model.dart';
part 'new_chat_dto.g.dart';

@JsonSerializable()
class NewChatDto {
  final String room;
  final String username;
  final String text;
  final DateTime time;

  NewChatDto({
    required this.room,
    required this.username,
    required this.text,
    required this.time,
  });

  factory NewChatDto.fromJson(Map<String, dynamic> json) =>
      _$NewChatDtoFromJson(json);

  Map<String, dynamic> toJson() => _$NewChatDtoToJson(this);

  factory NewChatDto.fromModel(ChatModel model) => NewChatDto(
        room: model.room,
        username: model.username,
        text: model.text,
        time: model.time,
      );

  ChatModel toModel() => ChatModel(
        room: room,
        username: username,
        text: text,
        time: time,
      );

  // MongoChatEntity toEntity() => MongoChatEntity(
  //     id: ObjectId.fromHexString(id), room: room, username: username, text: text, time: time);
}
