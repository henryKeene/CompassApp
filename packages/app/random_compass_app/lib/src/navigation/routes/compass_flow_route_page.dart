import 'package:app_state/app_state.dart';
import 'package:auto_route/auto_route.dart';
import 'package:compass/compass.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class CompassFlowRoutePage extends StatelessWidget {
  const CompassFlowRoutePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<AppStateCubit>(),
      child: const CompassFlow(),
    );
  }
}
