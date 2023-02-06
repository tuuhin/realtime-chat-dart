import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared/src/dto/room/check_room_dto.dart';
import 'package:shared/src/models/room_model.dart';

part 'check_room_model.freezed.dart';

@freezed
class CheckRoomModel with _$CheckRoomModel {
  factory CheckRoomModel({
    required RoomState state,
    RoomModel? room,
  }) = _CheckRoomModel;
}
