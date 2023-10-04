import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:isar/isar.dart';

Future<void> init(InternetAddress ip, int port) async {
  // Any code initialized within this method will only run on server start, any hot reloads
  // afterwards will not trigger this method until a hot restart.
  await Isar.initializeIsarCore(download: true);
}

Future<HttpServer> run(Handler handler, InternetAddress ip, int port) {
  return serve(handler, ip, port);
}
