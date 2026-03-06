import 'package:compass/src/data/datasources/overpass_datasource.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers/mock_overpass_datasource.dart';
import 'helpers/test_setup.dart';

Future<void> thereAreNoNearbyPlaces(WidgetTester tester) async {
  (getIt<OverpassDatasource>() as MockOverpassDatasource).setPlaces([]);
}
