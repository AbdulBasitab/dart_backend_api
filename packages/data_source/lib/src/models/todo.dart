// ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:realm_dart/realm.dart';

part 'todo.g.dart';

@RealmModel()
@JsonSerializable()
class _Todo {
  @PrimaryKey()
  late final String? id;
  late final String title;
  late final String description;
  late final bool isCompleted;

  // @override
  // List<Object?> get props => [id, title, description, isCompleted];

  // @override
  // bool get stringify => true;

  // _Todo copyWith({
  //   String? id,
  //   String? title,
  //   String? description,
  //   bool? isCompleted,
  // }) {
  //   return _Todo(
  //     id: id ?? this.id,
  //     title: title ?? this.title,
  //     description: description ?? this.description,
  //     isCompleted: isCompleted ?? this.isCompleted,
  //   );
  // }
}

extension TodoJ on Todo {
  static Todo toRealmObject(_Todo todo) {
    return Todo(
      todo.id,
      todo.title,
      todo.description,
      todo.isCompleted,
    );
  }

  static Todo fromJson(Map<String, dynamic> json) =>
      toRealmObject(_$TodoFromJson(json));
  Map<String, dynamic> toJson() => _$TodoToJson(this);
}
