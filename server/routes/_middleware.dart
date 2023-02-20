import 'package:dart_frog/dart_frog.dart';
import 'package:server/middleware/db_middleware.dart';
import 'package:server/middleware/room_middleware.dart';

Handler middleware(Handler handler) =>
    handler.use(chatProvider()).use(roomMiddleWare()).use(requestLogger());
