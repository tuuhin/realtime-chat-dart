import 'package:freezed_annotation/freezed_annotation.dart';

import '../../shared.dart';

part 'check_room_model.freezed.dart';

@freezed
class CheckRoomModel with _$CheckRoomModel {
  factory CheckRoomModel({
    required RoomState state,
    RoomModel? room,
  }) = _CheckRoomModel;
}
