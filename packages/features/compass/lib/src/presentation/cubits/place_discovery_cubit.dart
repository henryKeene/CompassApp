import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location_service/location_service.dart';

import '../../data/repositories/place_repository.dart';
import '../../domain/entities/place.dart';

sealed class PlaceDiscoveryState {}

class PlaceDiscoveryInitial extends PlaceDiscoveryState {}

class PlaceDiscoveryLoading extends PlaceDiscoveryState {}

class PlaceDiscoveryLoaded extends PlaceDiscoveryState {
  PlaceDiscoveryLoaded(this.place);
  final Place place;
}

class PlaceDiscoveryError extends PlaceDiscoveryState {
  PlaceDiscoveryError(this.message);
  final String message;
}

class PlaceDiscoveryCubit extends Cubit<PlaceDiscoveryState> {
  PlaceDiscoveryCubit({
    required PlaceRepository repository,
    required LocationService locationService,
  })  : _repository = repository,
        _locationService = locationService,
        super(PlaceDiscoveryInitial());

  final PlaceRepository _repository;
  final LocationService _locationService;

  Future<void> discover(String amenityType) async {
    emit(PlaceDiscoveryLoading());
    try {
      final position = await _locationService.getCurrentPosition();
      final place = await _repository.getRandomPlace(
        position.latitude,
        position.longitude,
        amenityType,
      );
      emit(PlaceDiscoveryLoaded(place));
    } catch (_) {
      emit(
        PlaceDiscoveryError(
          'Could not find nearby places. Please try again.',
        ),
      );
    }
  }
}
