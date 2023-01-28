import 'package:dart_frog/dart_frog.dart';
import 'package:server/db/room/room_operation_repo_impl.dart';
import 'package:server/db/room/room_operations_repo.dart';
import 'package:server/middleware/db_middleware.dart';

///Provies room fucntions
Middleware roomMiddleWare() {
  return provider<RoomOperations>(
    (context) => RoomOperaionRepoImpl(database.db, collectionName: 'rooms'),
  );
}
