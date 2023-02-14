import 'package:freezed_annotation/freezed_annotation.dart';
part 'chat_handler_model.freezed.dart';

@freezed
class ChatHandlerModel with _$ChatHandlerModel {
  factory ChatHandlerModel({
    required String room,
    required String username,
  }) = _ChatHandlerModel;
}
