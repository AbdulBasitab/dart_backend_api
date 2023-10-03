import 'dart:async';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:data_source/data_source.dart';

FutureOr<Response> onRequest(RequestContext context) async {
  switch (context.request.method) {
    case HttpMethod.get:
      return _get(context);
    case HttpMethod.post:
      return _post(context);
    case HttpMethod.delete:
    case HttpMethod.head:
    case HttpMethod.options:
    case HttpMethod.patch:
    case HttpMethod.put:
      return Response(statusCode: HttpStatus.methodNotAllowed);
  }
}

Future<Response> _get(RequestContext context) async {
  final dataSource = context.read<UsersDataSource>();
  final users = await dataSource.readAll();
  final jsonUsers = <Map<String, dynamic>>[];
  for (final user in users) {
    jsonUsers.add(user.toJson());
  }
  return Response.json(
    body: {
      'result': jsonUsers,
    },
  );
}

Future<Response> _post(RequestContext context) async {
  final userdataSource = context.read<UsersDataSource>();
  final user =
      User.fromJson(await context.request.json() as Map<String, dynamic>);
  final responseUser = await userdataSource.create(user);
  return Response.json(
    statusCode: HttpStatus.created,
    body: {
      'result': responseUser.toJson(),
    },
  );
}
