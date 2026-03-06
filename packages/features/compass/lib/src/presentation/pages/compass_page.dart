import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/place.dart';
import '../cubits/compass_cubit.dart';
import '../flow/compass_flow_state.dart';

class CompassPage extends StatefulWidget {
  const CompassPage({super.key, required this.place});

  final Place place;

  @override
  State<CompassPage> createState() => _CompassPageState();
}

class _CompassPageState extends State<CompassPage> {
  late final CompassCubit _compassCubit;
  double _previousAngle = 0;
  double _turns = 0;

  @override
  void initState() {
    super.initState();
    _compassCubit = context.read<CompassCubit>();
    _compassCubit.startTracking(widget.place);
  }

  @override
  void dispose() {
    _compassCubit.stopTracking();
    super.dispose();
  }

  void _updateTurns(double newAngle) {
    double delta = newAngle - _previousAngle;
    if (delta > 180) delta -= 360;
    if (delta < -180) delta += 360;
    _turns += delta / 360;
    _previousAngle = newAngle;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Navigate'),
        centerTitle: true,
      ),
      body: BlocBuilder<CompassCubit, CompassState>(
        builder: (context, state) {
          if (state is CompassInitial) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is CompassError) {
            return Center(child: Text(state.message));
          }

          if (state is CompassActive) {
            _updateTurns(state.arrowAngle);

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedRotation(
                    turns: _turns,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeOut,
                    child: Icon(
                      Icons.navigation,
                      size: 120,
                      color: colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    '${state.distanceKm.toStringAsFixed(1)} km',
                    style: textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.place.amenityType[0].toUpperCase() +
                        widget.place.amenityType.substring(1),
                    style: textTheme.labelMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 48),
                  FilledButton.tonal(
                    onPressed: () {
                      context.flow<CompassFlowState>().complete();
                    },
                    child: const Text('New Adventure'),
                  ),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
