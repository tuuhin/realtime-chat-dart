import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared/shared.dart';

part 'chat_info_dto.g.dart';

@JsonSerializable()
class ChatInfoDto {
  final ChatMessageDataType type;
  final ChatDto? chat;
  final String? extra;
  final ChatOwner owner;

  ChatInfoDto({
    required this.type,
    this.chat,
    this.extra,
    required this.owner,
  });

  factory ChatInfoDto.fromJson(Map<String, dynamic> json) =>
      _$ChatInfoDtoFromJson(json);

  factory ChatInfoDto.fromModel(ChatMessageInfoModel model) => ChatInfoDto(
        type: model.type,
        chat: model.model != null ? ChatDto.fromModel(model.model!) : null,
        extra: model.extra,
        owner: model.owner,
      );

  Map<String, dynamic> toJson() => _$ChatInfoDtoToJson(this);

  ChatMessageInfoModel toModel() => ChatMessageInfoModel(
        type: type,
        model: chat?.toModel(),
        extra: extra,
        owner: owner,
      );
}
