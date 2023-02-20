import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mongo_dart/mongo_dart.dart';

import '../../../shared.dart';

part 'chat_dto.g.dart';

@JsonSerializable()
class ChatDto {
  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(name: "room")
  final String room;
  @JsonKey(name: "username")
  final String username;
  @JsonKey(name: "text")
  final String text;
  @JsonKey(name: "time")
  final DateTime time;

  ChatDto({
    this.id,
    required this.room,
    required this.username,
    required this.text,
    required this.time,
  });

  factory ChatDto.fromJson(Map<String, dynamic> json) =>
      _$ChatDtoFromJson(json);

  factory ChatDto.fromModel(ChatModel model) => ChatDto(
        id: model.id,
        username: model.username,
        text: model.text,
        time: model.time,
        room: model.room,
      );

  factory ChatDto.fromEntity(MongoChatEntity entity) => ChatDto(
        id: entity.id.$oid,
        room: entity.room,
        username: entity.username,
        text: entity.text,
        time: entity.time,
      );

  Map<String, dynamic> toJson() => _$ChatDtoToJson(this);

  ChatModel toModel() => ChatModel(
        id: id,
        room: room,
        username: username,
        text: text,
        time: time,
      );

  MongoChatEntity toEntity() {
    assert(id != null, "THE ID OF AN MONOGO ENTITY OBJECT CANNOT BE NULL");
    return MongoChatEntity(
      id: ObjectId.fromHexString(id!),
      room: room,
      username: username,
      text: text,
      time: time,
    );
  }
}
