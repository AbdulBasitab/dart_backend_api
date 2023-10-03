import 'dart:async';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:data_source/data_source.dart';

FutureOr<Response> onRequest(RequestContext context, String id) async {
  final dataSource = context.read<TodosDataSource>();
  final todo = await dataSource.read(id);

  if (todo == null) {
    return Response(body: 'Todo not found', statusCode: HttpStatus.notFound);
  }

  switch (context.request.method) {
    case HttpMethod.get:
      return _get(context, todo);
    case HttpMethod.put:
      return _put(context, id, todo);
    case HttpMethod.delete:
      return _delete(context, id);
    case HttpMethod.head:
    case HttpMethod.options:
    case HttpMethod.patch:
    case HttpMethod.post:
      return Response(statusCode: HttpStatus.methodNotAllowed);
  }
}

Future<Response> _get(RequestContext context, Todo todo) async {
  return Response.json(
    statusCode: HttpStatus.found,
    body: todo.toJson(),
  );
}

Future<Response> _put(RequestContext context, String id, Todo todo) async {
  final dataSource = context.read<TodosDataSource>();
  final updatedTodo = TodoJ.fromJson(
    await context.request.json() as Map<String, dynamic>,
  );

  final newTodo = await dataSource.update(
    Todo(
      updatedTodo.id,
      updatedTodo.title,
      updatedTodo.description,
      updatedTodo.isCompleted,
    ),
  );

  return Response.json(body: newTodo.toJson());
}

Future<Response> _delete(RequestContext context, String id) async {
  final dataSource = context.read<TodosDataSource>();
  await dataSource.delete(id);

  return Response(statusCode: HttpStatus.noContent);
}
