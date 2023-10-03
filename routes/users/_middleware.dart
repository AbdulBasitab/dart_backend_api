// import 'dart:async';
import 'package:dart_frog/dart_frog.dart';
import 'package:data_repository/data_repository.dart';
import 'package:data_source/data_source.dart';
import 'package:isar/isar.dart';

Isar? isar;

Handler middleware(Handler handler) {
  return (context) async {
    if (isar?.isOpen ?? false) {
    } else {
      await Isar.initializeIsarCore(download: true);
      isar = await Isar.open(
        [UserSchema],
        directory: '',
      );
    }
    final response = await handler.use(requestLogger()).use(
      provider<UsersDataSource>(
        (_) {
          return UserDataRepository(
            isar: isar,
          );
        },
      ),
    )(context);
    return response;
  };
}
