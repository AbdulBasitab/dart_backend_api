import 'dart:async';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:data_source/data_source.dart';

FutureOr<Response> onRequest(RequestContext context, String id) async {
  final dataSource = context.read<UsersDataSource>();
  final user = await dataSource.read(id);

  if (user == null) {
    return Response(body: 'User not found', statusCode: HttpStatus.notFound);
  }

  switch (context.request.method) {
    case HttpMethod.get:
      return _get(context, user);
    case HttpMethod.put:
      return _put(context, user);
    case HttpMethod.delete:
      return _delete(context, id);
    case HttpMethod.head:
    case HttpMethod.options:
    case HttpMethod.patch:
    case HttpMethod.post:
      return Response(statusCode: HttpStatus.methodNotAllowed);
  }
}

Future<Response> _get(RequestContext context, User user) async {
  return Response.json(
    statusCode: HttpStatus.found,
    body: user.toJson(),
  );
}

Future<Response> _put(RequestContext context, User user) async {
  final dataSource = context.read<UsersDataSource>();
  final updatedUser = User.fromJson(
    await context.request.json() as Map<String, dynamic>,
  );

  final newUser = await dataSource.update(
    User(
      id: updatedUser.id,
      name: updatedUser.name,
      age: updatedUser.age,
    ),
  );

  return Response.json(body: newUser.toJson());
}

Future<Response> _delete(RequestContext context, String id) async {
  final dataSource = context.read<UsersDataSource>();
  await dataSource.delete(id);

  return Response(statusCode: HttpStatus.noContent);
}
