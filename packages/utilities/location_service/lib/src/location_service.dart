import 'package:geolocator/geolocator.dart';

class LocationService {
  Future<Position> getCurrentPosition() {
    return Geolocator.getCurrentPosition(
      locationSettings:
          const LocationSettings(accuracy: LocationAccuracy.high),
    );
  }

  Stream<Position> getPositionStream() {
    return Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 5,
      ),
    );
  }

  Future<double> distanceBetween(
    double startLat,
    double startLon,
    double endLat,
    double endLon,
  ) async {
    return Geolocator.distanceBetween(startLat, startLon, endLat, endLon);
  }
}
