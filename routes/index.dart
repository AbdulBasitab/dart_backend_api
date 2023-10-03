import 'package:dart_frog/dart_frog.dart';

Response onRequest(RequestContext context) {
  return Response(
    body:
        '\tWelcome to dart api backend below are the endpoints \n\n \t /users, /users/[id] and /todos, /todos/[id].',
  );
}
