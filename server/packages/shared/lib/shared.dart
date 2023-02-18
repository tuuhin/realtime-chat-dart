/// Support for doing something awesome.
///
/// More dartdocs go here.
library shared;

export './src/dto/chats/chat_dto.dart';
export 'src/dto/room/room_dto.dart';
export './src/dto/room/create_room_dto.dart';
export './src/dto/chats/new_chat_dto.dart';
export './src/dto/room/check_room_dto.dart';
export './src/dto/chats/chat_info_dto.dart';

export './src/mongo_entity/mongo_room_entity.dart';
export 'src/mongo_entity/mongo_chat_entity.dart';

export './src/models/chat_model.dart';
export './src/models/room_model.dart';
export './src/models/check_room_model.dart';
export './src/models/chat_info_model.dart';
export './src/models/chat_handler_model.dart';

export './src/utils/utils.dart';
export './src/utils/resource.dart';
export './src/utils/ws_messages.dart';
export './src/utils/room_state.dart';
export './src/utils/ws_close_codes.dart';
export './src/utils/stream_extensions.dart';
export './src/utils/date_formatters.dart';

// TODO: Export any libraries intended for clients of this package.
