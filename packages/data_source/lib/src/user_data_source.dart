// ignore_for_file: public_member_api_docs

import 'package:data_source/data_source.dart';

abstract class UsersDataSource {
  Future<User> create(User user);

  Future<List<User>> readAll();

  Future<User?> read(String id);

  Future<User> update(User user);

  Future<void> delete(String id);
}
