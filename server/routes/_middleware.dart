import 'package:dart_frog/dart_frog.dart';
import 'package:server/middleware/db_middleware.dart';

Handler middleware(Handler handler) {
  return handler.use(chatProvider()).use(requestLogger());
}
