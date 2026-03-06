import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import '../data/datasources/overpass_datasource.dart';
import '../data/repositories/place_repository.dart';

void setupCompassDependencies(GetIt getIt) {
  getIt.registerLazySingleton<OverpassDatasource>(
    () => OverpassDatasource(getIt<http.Client>()),
  );
  getIt.registerLazySingleton<PlaceRepository>(
    () => PlaceRepository(getIt<OverpassDatasource>()),
  );
}
