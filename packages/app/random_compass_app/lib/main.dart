import 'package:compass/compass.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:location_service/location_service.dart';
import 'package:permission_service/permission_service.dart';

import 'src/app.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  getIt.registerLazySingleton<http.Client>(() => http.Client());
  getIt.registerLazySingleton<LocationService>(() => LocationService());
  getIt.registerLazySingleton<PermissionService>(() => PermissionService());
  setupCompassDependencies(getIt);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  if (!getIt.isRegistered<LocationService>()) {
    setupDependencies();
  }
  runApp(App());
}
