import 'package:dart_frog/dart_frog.dart';
import 'package:data_repository/data_repository.dart';
import 'package:data_source/data_source.dart';
import 'package:realm_dart/realm.dart';

Handler middleware(Handler handler) {
  final config = Configuration.local([Todo.schema]);
  final realm = Realm(config);
  return handler.use(requestLogger()).use(
        provider<TodosDataSource>(
          (_) => TodosDataRepository(
            realm: realm,
          ),
        ),
      );
}
