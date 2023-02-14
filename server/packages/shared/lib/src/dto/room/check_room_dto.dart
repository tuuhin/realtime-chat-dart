import 'package:json_annotation/json_annotation.dart';
import 'package:shared/shared.dart';
import 'package:shared/src/dto/room/room_dto.dart';

part 'check_room_dto.g.dart';

///RoomState for check room data
enum RoomState {
  ///[MongoRoomEntity] found
  /// But the count equals to max so no more members are allowed
  full,

  ///[MongoRoomEntity] found
  /// The count for the number of participants is lesser than that of max
  joinable,

  /// [MongoRoomEntity] is undefined
  /// There is no room with the provided details
  undefined
}

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
      room: model.room != null ? RoomDto.fromModel(model.room!) : null);

  CheckRoomModel toModel() =>
      CheckRoomModel(state: state, room: room?.toModel());
}
