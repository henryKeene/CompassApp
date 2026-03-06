import 'dart:async';
import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:location_service/location_service.dart';

import '../../domain/entities/place.dart';

sealed class CompassState {}

class CompassInitial extends CompassState {}

class CompassActive extends CompassState {
  CompassActive({required this.arrowAngle, required this.distanceKm});
  final double arrowAngle;
  final double distanceKm;
}

class CompassError extends CompassState {
  CompassError(this.message);
  final String message;
}

class CompassCubit extends Cubit<CompassState> {
  CompassCubit({required LocationService locationService})
      : _locationService = locationService,
        super(CompassInitial());

  final LocationService _locationService;
  Place? _targetPlace;
  StreamSubscription<CompassEvent>? _compassSubscription;
  StreamSubscription<Position>? _positionSubscription;
  double _currentHeading = 0;
  double _smoothedHeading = 0;
  Position? _currentPosition;
  double? _cachedDistanceKm;

  static const _emitInterval = Duration(milliseconds: 200);
  DateTime _lastEmit = DateTime.fromMillisecondsSinceEpoch(0);

  void startTracking(Place place) {
    _targetPlace = place;
    _cachedDistanceKm = null;

    _compassSubscription?.cancel();
    _positionSubscription?.cancel();

    _compassSubscription = FlutterCompass.events?.listen(
      (event) {
        final heading = event.heading ?? 0;
        _currentHeading = heading;
        _smoothHeading();
        _updateCompass();
      },
      onError: (Object _) {
        emit(CompassError('Compass sensor unavailable.'));
      },
    );

    _positionSubscription = _locationService.getPositionStream().listen(
      (position) {
        _currentPosition = position;
        _cachedDistanceKm = null;
        _updateCompass();
      },
      onError: (Object _) {
        emit(CompassError('Location tracking unavailable.'));
      },
    );
  }

  void _smoothHeading() {
    const alpha = 0.15;
    final diff = _currentHeading - _smoothedHeading;
    final adjustedDiff =
        atan2(sin(diff * pi / 180), cos(diff * pi / 180)) * 180 / pi;
    _smoothedHeading = (_smoothedHeading + alpha * adjustedDiff + 360) % 360;
  }

  Future<void> _updateCompass() async {
    final now = DateTime.now();
    if (now.difference(_lastEmit) < _emitInterval) return;

    final position = _currentPosition;
    final target = _targetPlace;
    if (position == null || target == null) return;

    final lat1 = position.latitude * pi / 180;
    final lon1 = position.longitude * pi / 180;
    final lat2 = target.latitude * pi / 180;
    final lon2 = target.longitude * pi / 180;
    final dLon = lon2 - lon1;

    final y = sin(dLon) * cos(lat2);
    final x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon);
    final targetBearing = (atan2(y, x) * 180 / pi + 360) % 360;

    final arrowAngle = (targetBearing - _smoothedHeading + 360) % 360;

    _cachedDistanceKm ??= await _locationService.distanceBetween(
          position.latitude,
          position.longitude,
          target.latitude,
          target.longitude,
        ) /
        1000;

    _lastEmit = now;
    emit(CompassActive(arrowAngle: arrowAngle, distanceKm: _cachedDistanceKm!));
  }

  void stopTracking() {
    _compassSubscription?.cancel();
    _compassSubscription = null;
    _positionSubscription?.cancel();
    _positionSubscription = null;
  }

  @override
  Future<void> close() {
    stopTracking();
    return super.close();
  }
}
