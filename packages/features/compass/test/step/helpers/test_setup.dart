import 'package:compass/src/data/datasources/overpass_datasource.dart';
import 'package:compass/src/data/repositories/place_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:location_service/location_service.dart';
import 'package:permission_service/permission_service.dart';

import 'mock_location_service.dart';
import 'mock_overpass_datasource.dart';
import 'mock_permission_service.dart';

final getIt = GetIt.instance;

late MockLocationService mockLocationService;
late MockOverpassDatasource mockOverpassDatasource;
late MockPermissionService mockPermissionService;

Future<void> setupTestDependencies() async {
  await getIt.reset();

  mockLocationService = MockLocationService();
  mockOverpassDatasource = MockOverpassDatasource();
  mockPermissionService = MockPermissionService();

  getIt.registerSingleton<LocationService>(mockLocationService);
  getIt.registerSingleton<PermissionService>(mockPermissionService);
  getIt.registerSingleton<OverpassDatasource>(mockOverpassDatasource);
  getIt.registerSingleton<PlaceRepository>(
    PlaceRepository(mockOverpassDatasource),
  );
}

Future<void> teardownTestDependencies() async {
  await getIt.reset();
}
