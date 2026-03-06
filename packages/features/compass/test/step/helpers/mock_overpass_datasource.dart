import 'package:compass/src/data/datasources/overpass_datasource.dart';
import 'package:compass/src/domain/entities/place.dart';
import 'package:http/http.dart' as http;

class MockOverpassDatasource extends OverpassDatasource {
  MockOverpassDatasource() : super(http.Client());

  List<Place> _places = [
    const Place(
      name: 'Test Cafe',
      latitude: 51.5080,
      longitude: -0.1280,
      amenityType: 'cafe',
    ),
    const Place(
      name: 'Test Restaurant',
      latitude: 51.5090,
      longitude: -0.1270,
      amenityType: 'restaurant',
    ),
    const Place(
      name: 'Test Bar',
      latitude: 51.5070,
      longitude: -0.1290,
      amenityType: 'bar',
    ),
    const Place(
      name: 'Test Pub',
      latitude: 51.5060,
      longitude: -0.1300,
      amenityType: 'pub',
    ),
  ];

  void setPlaces(List<Place> places) {
    _places = places;
  }

  @override
  Future<List<Place>> fetchNearbyPlaces(
    double lat,
    double lon,
    String amenityType,
  ) async {
    return _places.where((p) => p.amenityType == amenityType).toList();
  }
}
