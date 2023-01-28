import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:shared/src/models/room_model.dart';

import '../../convertors/objectid_covertor.dart';

part 'room_dto.g.dart';

@JsonSerializable(converters: [ObjectIdConvertor()])
class RoomDto {
  @JsonKey(name: '_id')
  final ObjectId id;
  final String roomId;

  RoomDto({
    required this.id,
    required this.roomId,
  });

  factory RoomDto.fromJson(Map<String, dynamic> json) =>
      _$RoomDtoFromJson(json);

  factory RoomDto.fromModel(RoomModel room) =>
      RoomDto(id: ObjectId.fromHexString(room.id), roomId: room.roomId);

  Map<String, dynamic> toJson() => _$RoomDtoToJson(this);

  RoomModel toModel() => RoomModel(
        id: id.$oid,
        roomId: roomId,
      );
}
