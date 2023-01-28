import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_room_dto.g.dart';

@JsonSerializable(createToJson: false)
class CreateRoomDto {
  final String? roomId;
  final int? maxAttendes;

  CreateRoomDto({this.roomId, this.maxAttendes});

  factory CreateRoomDto.fromJson(Map<String, dynamic> json) =>
      _$CreateRoomDtoFromJson(json);
}
