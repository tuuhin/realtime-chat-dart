import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:shared/src/models/chat_model.dart';

import '../convertors/objectid_covertor.dart';

part 'chat_dto.g.dart';

@JsonSerializable(converters: [ObjectIdConvertor()])
class ChatDto {
  @JsonKey(name: '_id')
  final ObjectId id;
  final String room;
  final String username;
  final String text;
  final DateTime time;

  ChatDto({
    required this.id,
    required this.room,
    required this.username,
    required this.text,
    required this.time,
  });

  factory ChatDto.fromJson(Map<String, dynamic> json) =>
      _$ChatDtoFromJson(json);

  factory ChatDto.fromModel(ChatModel model) => ChatDto(
        id: ObjectId.fromHexString(model.id!),
        username: model.username,
        text: model.text,
        time: model.time,
        room: model.room,
      );

  Map<String, dynamic> toJson() => _$ChatDtoToJson(this);

  ChatModel toModel() => ChatModel(
        id: id.$oid,
        room: room,
        username: username,
        text: text,
        time: time,
      );
}
