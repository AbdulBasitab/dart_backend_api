// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Todo _$TodoFromJson(Map<String, dynamic> json) => _Todo()
  ..id = json['id'] as String?
  ..title = json['title'] as String
  ..description = json['description'] as String
  ..isCompleted = json['isCompleted'] as bool;

Map<String, dynamic> _$TodoToJson(_Todo instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'isCompleted': instance.isCompleted,
    };

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class Todo extends _Todo with RealmEntity, RealmObjectBase, RealmObject {
  Todo(
    String? id,
    String title,
    String description,
    bool isCompleted,
  ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'title', title);
    RealmObjectBase.set(this, 'description', description);
    RealmObjectBase.set(this, 'isCompleted', isCompleted);
  }

  Todo._();

  @override
  String? get id => RealmObjectBase.get<String>(this, 'id') as String?;
  @override
  set id(String? value) => throw RealmUnsupportedSetError();

  @override
  String get title => RealmObjectBase.get<String>(this, 'title') as String;
  @override
  set title(String value) => throw RealmUnsupportedSetError();

  @override
  String get description =>
      RealmObjectBase.get<String>(this, 'description') as String;
  @override
  set description(String value) => throw RealmUnsupportedSetError();

  @override
  bool get isCompleted =>
      RealmObjectBase.get<bool>(this, 'isCompleted') as bool;
  @override
  set isCompleted(bool value) => throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<Todo>> get changes =>
      RealmObjectBase.getChanges<Todo>(this);

  @override
  Todo freeze() => RealmObjectBase.freezeObject<Todo>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Todo._);
    return const SchemaObject(ObjectType.realmObject, Todo, 'Todo', [
      SchemaProperty('id', RealmPropertyType.string,
          optional: true, primaryKey: true),
      SchemaProperty('title', RealmPropertyType.string),
      SchemaProperty('description', RealmPropertyType.string),
      SchemaProperty('isCompleted', RealmPropertyType.bool),
    ]);
  }
}
