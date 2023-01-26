import 'package:freezed_annotation/freezed_annotation.dart';

part 'room_model.freezed.dart';

@freezed
class RoomModel with _$RoomModel {
  factory RoomModel({
    required String roomId,
    required int maxAttendes,
  }) = _RoomModel;
}
