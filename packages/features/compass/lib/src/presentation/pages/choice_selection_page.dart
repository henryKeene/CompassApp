import 'package:app_state/app_state.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:permission_service/permission_service.dart';

import '../cubits/place_discovery_cubit.dart';
import '../flow/compass_flow_state.dart';

class ChoiceSelectionPage extends StatefulWidget {
  const ChoiceSelectionPage({
    super.key,
    this.selectedCategory = 'cafe',
    this.isDiscovering = false,
  });

  final String selectedCategory;
  final bool isDiscovering;

  @override
  State<ChoiceSelectionPage> createState() => _ChoiceSelectionPageState();
}

class _ChoiceSelectionPageState extends State<ChoiceSelectionPage> {
  late String _selectedCategory;

  static const _categories = [
    ('cafe', Icons.coffee_rounded, 'Cafe'),
    ('restaurant', Icons.restaurant_rounded, 'Restaurant'),
    ('bar', Icons.local_bar_rounded, 'Bar'),
    ('pub', Icons.sports_bar_rounded, 'Pub'),
  ];

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.selectedCategory;
  }

  Future<void> _onDiscover() async {
    final granted = await GetIt.instance<PermissionService>()
        .requestLocationPermission(context);
    if (!granted || !mounted) return;

    context.flow<CompassFlowState>().update(
          (_) => DiscoveringPlace(category: _selectedCategory),
        );
    context.read<PlaceDiscoveryCubit>().discover(_selectedCategory);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return BlocListener<PlaceDiscoveryCubit, PlaceDiscoveryState>(
      listener: (context, state) {
        if (state is PlaceDiscoveryLoaded) {
          context.read<AppStateCubit>().recordDiscovery();
          context.flow<CompassFlowState>().update(
                (_) => ViewingCompass(place: state.place),
              );
        } else if (state is PlaceDiscoveryError) {
          context.flow<CompassFlowState>().update(
                (_) => ErrorPage(),
              );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Where to?'),
          centerTitle: true,
          leading: IconButton(onPressed: (){
            context.flow<CompassFlowState>().complete();
          }, icon: Icon(Icons.close)),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const Spacer(),
                GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  shrinkWrap: true,
                  childAspectRatio: 1.2,
                  children: _categories.map((cat) {
                    final (id, icon, label) = cat;
                    final isSelected = id == _selectedCategory;
                    return _CategoryCard(
                      icon: icon,
                      label: label,
                      isSelected: isSelected,
                      onTap: () => setState(() => _selectedCategory = id),
                    );
                  }).toList(),
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: FilledButton(
                    onPressed: widget.isDiscovering ? null : _onDiscover,
                    child: widget.isDiscovering
                        ? SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: colorScheme.onPrimary,
                            ),
                          )
                        : Text(
                            'Discover',
                            style: textTheme.titleMedium?.copyWith(
                              color: colorScheme.onPrimary,
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  const _CategoryCard({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Material(
      color: isSelected
          ? colorScheme.primaryContainer
          : colorScheme.surfaceContainerLow,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected
                  ? colorScheme.primary
                  : colorScheme.outlineVariant,
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 40,
                color: isSelected
                    ? colorScheme.onPrimaryContainer
                    : colorScheme.onSurfaceVariant,
              ),
              const SizedBox(height: 8),
              Text(
                label,
                style: textTheme.titleMedium?.copyWith(
                  color: isSelected
                      ? colorScheme.onPrimaryContainer
                      : colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
