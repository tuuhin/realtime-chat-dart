import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mongo_dart/mongo_dart.dart';

import '../../../shared.dart';

part 'room_dto.g.dart';

@JsonSerializable()
class RoomDto {
  @JsonKey(name: '_id')
  final String id;
  final String roomId;
  @JsonKey(name: "max")
  final int maxAttendes;
  @JsonKey(name: "count")
  final int count;

  RoomDto({
    required this.count,
    required this.id,
    required this.roomId,
    required this.maxAttendes,
  });

  factory RoomDto.fromJson(Map<String, dynamic> json) =>
      _$RoomDtoFromJson(json);

  factory RoomDto.fromModel(RoomModel room) => RoomDto(
        count: room.count,
        id: room.id,
        roomId: room.roomId,
        maxAttendes: room.maxAttendes,
      );

  factory RoomDto.fromEntity(MongoRoomEntity room) => RoomDto(
        count: room.count,
        id: room.id.$oid,
        roomId: room.roomId,
        maxAttendes: room.maxAttendes,
      );

  MongoRoomEntity toEntity() => MongoRoomEntity(
        id: ObjectId.fromHexString(id),
        roomId: roomId,
        maxAttendes: maxAttendes,
        count: count,
      );

  Map<String, dynamic> toJson() => _$RoomDtoToJson(this);

  RoomModel toModel() => RoomModel(
        id: id,
        roomId: roomId,
        maxAttendes: maxAttendes,
        count: count,
      );
}
