import 'dart:convert';

import 'package:compass/src/domain/constants/compass_constants.dart';
import 'package:http/http.dart' as http;

import '../../domain/entities/place.dart';

class OverpassDatasource {
  OverpassDatasource(this.client);

  final http.Client client;

  static const _allowedTypes = {'cafe', 'restaurant', 'bar', 'pub'};

  Future<List<Place>> fetchNearbyPlaces(
    double lat,
    double lon,
    String amenityType,
  ) async {
    if (!_allowedTypes.contains(amenityType)) {
      throw ArgumentError('Invalid amenity type: $amenityType');
    }

    final truncatedLat = (lat * 1000).round() / 1000;
    final truncatedLon = (lon * 1000).round() / 1000;

    final query =
        '[out:json][timeout:25];(nwr["amenity"="$amenityType"](around:${CompassConstants.furthestDistanceFromUserMeters},$truncatedLat,$truncatedLon););out center body;';

    final response = await client
        .post(
          Uri.parse(CompassConstants.overpassEndpoint),
          body: {'data': query},
        )
        .timeout(const Duration(seconds: 30));

    if (response.statusCode != 200) {
      throw Exception('API request failed');
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    final elements = json['elements'] as List<dynamic>;
    

    return elements
        .map((e) {
          final element = e as Map<String, dynamic>;
          final tags = element['tags'] as Map<String, dynamic>? ?? {};
          final center = element['center'] as Map<String, dynamic>?;

          final double? latitude = (element['lat'] as num?)?.toDouble() ??
              (center?['lat'] as num?)?.toDouble();
          final double? longitude = (element['lon'] as num?)?.toDouble() ??
              (center?['lon'] as num?)?.toDouble();

          if (latitude == null || longitude == null) return null;

          return Place(
            name: tags['name'] as String? ?? 'Unknown',
            latitude: latitude,
            longitude: longitude,
            amenityType: tags['amenity'] as String? ?? amenityType,
          );
        })
        .whereType<Place>()
        .toList();
  }
}
