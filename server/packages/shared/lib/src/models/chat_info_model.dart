import 'package:shared/shared.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_info_model.freezed.dart';

enum ChatMessageDataType {
  ///When a new member joins the chat
  joined,

  ///When the user sends the message
  message,

  ///When the user is disconnected or leaves the room
  disconnected
}

@freezed
class ChatMessageInfoModel with _$ChatMessageInfoModel {
  // @Assert("type==ChatMessageDataType.message && model==null",
  //     "Message type should alawys have an model")
  // @Assert("type!=ChatMessageDataType.message && extra==null",
  //     "A non message side should have extra")
  factory ChatMessageInfoModel({
    required ChatMessageDataType type,
    required ChatOwner owner,
    ChatModel? model,
    String? extra,
  }) = _ChatMessageInfoModel;
}
