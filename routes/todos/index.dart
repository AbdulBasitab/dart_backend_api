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
  final dataSource = context.read<TodosDataSource>();
  final todos = await dataSource.readAll();
  final jsonTodos = <Map<String, dynamic>>[];
  for (final todo in todos) {
    jsonTodos.add(todo.toJson());
  }
  return Response.json(
    body: {
      'results': jsonTodos,
    },
  );
}

Future<Response> _post(RequestContext context) async {
  final dataSource = context.read<TodosDataSource>();
  final todo =
      TodoJ.fromJson(await context.request.json() as Map<String, dynamic>);
  final responseTodo = await dataSource.create(todo);
  return Response.json(
    statusCode: HttpStatus.created,
    body: {
      'result': responseTodo.toJson(),
    },
  );
}
