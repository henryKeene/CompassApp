import 'package:location_service/location_service.dart';

class MockLocationService extends LocationService {
  Position _position = Position(
    latitude: 51.5074,
    longitude: -0.1278,
    timestamp: DateTime(2026),
    accuracy: 10,
    altitude: 0,
    altitudeAccuracy: 0,
    heading: 0,
    headingAccuracy: 0,
    speed: 0,
    speedAccuracy: 0,
  );

  void setPosition({required double lat, required double lon}) {
    _position = Position(
      latitude: lat,
      longitude: lon,
      timestamp: DateTime.now(),
      accuracy: 10,
      altitude: 0,
      altitudeAccuracy: 0,
      heading: 0,
      headingAccuracy: 0,
      speed: 0,
      speedAccuracy: 0,
    );
  }

  @override
  Future<Position> getCurrentPosition() async => _position;

  @override
  Stream<Position> getPositionStream() => Stream.value(_position);

  @override
  Future<double> distanceBetween(
    double startLat,
    double startLon,
    double endLat,
    double endLon,
  ) async {
    return 1500;
  }
}
