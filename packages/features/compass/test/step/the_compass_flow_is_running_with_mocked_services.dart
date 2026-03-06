import 'package:app_state/app_state.dart';
import 'package:compass/compass.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers/test_setup.dart';

bool flowCompleted = false;

Future<void> theCompassFlowIsRunningWithMockedServices(
  WidgetTester tester,
) async {
  await setupTestDependencies();
  flowCompleted = false;

  // Use a phone-sized surface to avoid overflow in the grid layout.
  tester.view.physicalSize = const Size(1080, 1920);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(() {
    tester.view.resetPhysicalSize();
    tester.view.resetDevicePixelRatio();
  });

  await tester.pumpWidget(
    MaterialApp(
      home: BlocProvider(
        create: (_) => AppStateCubit(),
        child: const CompassFlow(),
      ),
    ),
  );
  await tester.pumpAndSettle();
}
