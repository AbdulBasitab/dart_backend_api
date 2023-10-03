// ignore_for_file: public_member_api_docs, flutter_style_todos,
// ignore_for_file: depend_on_referenced_packages

import 'package:data_source/data_source.dart';
import 'package:realm_dart/realm.dart';
import 'package:uuid/uuid.dart' as uid;

class TodosDataRepository implements TodosDataSource {
  TodosDataRepository({
    required Realm realm,
  }) : _realm = realm;

  final Realm _realm;

  @override
  Future<Todo> create(Todo todo) async {
    final id = const uid.Uuid().v4();
    final createdTodo = Todo(
      id,
      todo.title,
      todo.description,
      todo.isCompleted,
    );
    await _realm.writeAsync<Todo>(
      () => _realm.add<Todo>(createdTodo),
    );
    return createdTodo;
  }

  @override
  Future<void> delete(String id) async {
    final todo = _realm.find<Todo>(id);
    if (todo != null) {
      await _realm.writeAsync(
        () => _realm.delete<Todo>(todo),
      );
    }
  }

  @override
  Future<Todo?> read(String id) async {
    final todo = _realm.find<Todo>(id);
    return todo;
  }

  @override
  Future<List<Todo>> readAll() async {
    return _realm.all<Todo>().toList();
  }

  @override
  Future<Todo> update(Todo todo) async {
    return _realm.writeAsync<Todo>(() {
      return _realm.add<Todo>(todo, update: true);
    });
  }
}
