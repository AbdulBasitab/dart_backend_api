// ignore_for_file: public_member_api_docs

import 'package:data_source/data_source.dart';
import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';

class UserDataRepository implements UsersDataSource {
  UserDataRepository({
    required Isar? isar,
  }) : _isar = isar;

  final Isar? _isar;

  @override
  Future<User> create(User user) async {
    final createdUser = User(
      id: const Uuid().v4(),
      name: user.name,
      age: user.age,
    );
    if (_isar?.isOpen ?? false) {
      await _isar?.writeTxn(() async {
        await _isar?.users.put(createdUser);
      });
    } else {
      print('Isar is not open or is null');
    }
    return createdUser;
  }

  @override
  Future<void> delete(String id) async {
    await _isar?.writeTxn(() async {
      await _isar?.users.filter().idEqualTo(id).deleteFirst();
    });
  }

  @override
  Future<User?> read(String id) async {
    User? user;
    await _isar?.writeTxn(() async {
      user = await _isar?.users.filter().idEqualTo(id).findFirst();
    });
    return user;
  }

  @override
  Future<List<User>> readAll() async {
    var users = <User>[];
    _isar?.writeTxnSync(() {
      users = _isar?.users.where().findAllSync() ?? [];
    });
    return users;
  }

  @override
  Future<User> update(User user) async {
    final createdUser = User(
      id: const Uuid().v4(),
      name: user.name,
      age: user.age,
    );
    await _isar?.writeTxn(() async {
      await _isar?.users.put(createdUser);
    });
    return createdUser;
  }
}
