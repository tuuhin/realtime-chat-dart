import 'package:dart_frog/dart_frog.dart';
import 'package:server/middleware/db_middleware.dart';
import 'package:server/respository/repository.dart';

///Provies room fucntions
Middleware roomMiddleWare() {
  return provider<RoomOperations>(
    (context) => RoomOperationRepoImpl(database.db),
  );
}
