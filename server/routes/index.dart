import 'package:dart_frog/dart_frog.dart';

final _info = {
  'title': 'Realtime chat app (Server)',
  'description':
      'This is the server for realtime chat app made with dart_frog and flutter'
};

Response onRequest(RequestContext context) => Response.json(body: _info);
