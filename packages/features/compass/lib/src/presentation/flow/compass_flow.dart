import 'package:compass/src/presentation/pages/no_places_found_page.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:location_service/location_service.dart';

import '../../data/repositories/place_repository.dart';
import '../cubits/compass_cubit.dart';
import '../cubits/place_discovery_cubit.dart';
import '../pages/choice_selection_page.dart';
import '../pages/compass_page.dart';
import 'compass_flow_state.dart';

class CompassFlow extends StatelessWidget {
  const CompassFlow({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => PlaceDiscoveryCubit(
            repository: GetIt.instance<PlaceRepository>(),
            locationService: GetIt.instance<LocationService>(),
          ),
        ),
        BlocProvider(
          create: (_) => CompassCubit(
            locationService: GetIt.instance<LocationService>(),
          ),
        ),
      ],
      child: FlowBuilder<CompassFlowState>(
        state: const SelectingCategory(),
        onGeneratePages: _onGeneratePages,
      ),
    );
  }

  static List<Page<dynamic>> _onGeneratePages(
    CompassFlowState state,
    List<Page<dynamic>> pages,
  ) {
    return switch (state) {
      SelectingCategory(:final category) => [
          MaterialPage<void>(
            key: const ValueKey('choice-selection'),
            child: ChoiceSelectionPage(selectedCategory: category),
          ),
        ],
      DiscoveringPlace(:final category) => [
          MaterialPage<void>(
            key: const ValueKey('choice-selection'),
            child: ChoiceSelectionPage(
              selectedCategory: category,
              isDiscovering: true,
            ),
          ),
        ],
      ViewingCompass(:final place) => [
          const MaterialPage<void>(
            key: ValueKey('choice-selection'),
            child: ChoiceSelectionPage(),
          ),
          MaterialPage<void>(
            key: const ValueKey('compass'),
            child: CompassPage(place: place),
          ),
        ],
      ErrorPage() => [
        const MaterialPage<void>(
            key: ValueKey('choice-selection'),
            child: ChoiceSelectionPage(),
          ),
          MaterialPage<void>(
            key: const ValueKey('no-places-found-page'),
            child: NoPlacesFoundPage(),
          ),
      ]
    };
  }
}
