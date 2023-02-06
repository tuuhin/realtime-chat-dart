import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_room_dto.g.dart';

@JsonSerializable()
class CreateRoomDto {
  @JsonKey(name: "roomId")
  final String roomId;
  @JsonKey(name: "max")
  final int maxAttendes;
  @JsonKey(name: "count")
  final int count;
  CreateRoomDto({
    this.count = 0,
    required this.roomId,
    required this.maxAttendes,
  });

  factory CreateRoomDto.fromJson(Map<String, dynamic> json) =>
      _$CreateRoomDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CreateRoomDtoToJson(this);
}
