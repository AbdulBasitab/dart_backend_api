// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:isar/isar.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
@Collection()
class User {
  final Id isarId = Isar.autoIncrement;
  final String? id;
  final String name;
  final int age;
  User({
    required this.id,
    required this.name,
    required this.age,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
