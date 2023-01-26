import 'package:dart_frog/dart_frog.dart';
import 'package:server/db/chat_operation_repo.dart';

Response onRequest(RequestContext context) {
  final repo = context.read<ChatOperationRepo>();

  return Response(body: 'Welcome to Dart Frog!');
}
