import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:server/db/room/room_operations_repo.dart';
import 'package:shared/shared.dart';

Future<Response> onRequest(RequestContext context) async {
  if (context.request.method != HttpMethod.get) {
    return Response(statusCode: HttpStatus.methodNotAllowed);
  }

  final resp = await context.read<RoomOperations>().createRoom();

  return Response.json(body: RoomDto.fromModel(resp).toJson());
}
