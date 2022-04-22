import 'package:jaspr/server.dart' hide Router;
import 'package:jaspr_pad/app.dart';
import 'package:shelf_router/shelf_router.dart';

import 'server/server_api.dart';

void main(List<String> args) {
  if (args.isEmpty) {
    throw 'Missing sdk path argument.';
  }

  runApp(() => App(), id: 'playground')
    ..addMiddleware(logRequests())
    ..addMiddleware((handler) {
      var router = Router(notFoundHandler: handler);
      router.mount('/api', apiRouter(args[0]));
      return router;
    });
}
