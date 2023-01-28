import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:server/db/room/room_operations_repo.dart';
import 'package:server/responses/api_expection.dart';
import 'package:shared/shared.dart';

Future<Response> onRequest(RequestContext context) async {
  if (context.request.method != HttpMethod.post) {
    return Response(statusCode: HttpStatus.methodNotAllowed);
  }

  final data = await context.request.json();
  if (data is! Map<String, dynamic>) {
    return ApiException.failedDependency(
        details: 'Content type should be json found ${data.runtimeType}');
  }
  final key = data.containsKey('roomId');
  if (!key) {
    return ApiException.failedDependency(details: 'RoomId not found');
  }
  final check =
      await context.read<RoomOperations>().checkRoom(data['roomId']! as String);

  if (check == null) {
    return ApiException.badRequest(details: 'No rooms with this id found');
  }

  return Response.json(body: RoomDto.fromModel(check).toJson());
}
