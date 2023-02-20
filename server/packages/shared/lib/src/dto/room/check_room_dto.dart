import 'package:json_annotation/json_annotation.dart';
import 'package:shared/shared.dart';

part 'check_room_dto.g.dart';

@JsonSerializable()
class CheckRoomDto {
  @JsonKey(name: "state")
  final RoomState state;

  @JsonKey(name: "room")
  final RoomDto? room;

  CheckRoomDto({required this.state, this.room});

  factory CheckRoomDto.fromJson(Map<String, dynamic> json) =>
      _$CheckRoomDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CheckRoomDtoToJson(this);

  factory CheckRoomDto.fromModel(CheckRoomModel model) => CheckRoomDto(
        state: model.state,
        room: model.room != null ? RoomDto.fromModel(model.room!) : null,
      );

  CheckRoomModel toModel() =>
      CheckRoomModel(state: state, room: room?.toModel());
}
