import 'dart:math';

import '../../domain/entities/place.dart';
import '../datasources/overpass_datasource.dart';

class PlaceRepository {
  PlaceRepository(this.datasource);

  final OverpassDatasource datasource;

  Future<Place> getRandomPlace(
    double lat,
    double lon,
    String amenityType,
  ) async {
    final places = await datasource.fetchNearbyPlaces(lat, lon, amenityType);

    if (places.isEmpty) {
      throw Exception('No places found nearby');
    }

    return places[Random().nextInt(places.length)];
  }
}
