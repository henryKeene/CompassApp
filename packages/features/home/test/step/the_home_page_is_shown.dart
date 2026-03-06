import 'package:app_state/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home/home.dart';

bool onStartAdventureCalled = false;

Future<void> theHomePageIsShown(WidgetTester tester) async {
  onStartAdventureCalled = false;
  await tester.pumpWidget(
    MaterialApp(
      home: BlocProvider(
        create: (_) => AppStateCubit(),
        child: HomePage(
          onStartAdventure: () {
            onStartAdventureCalled = true;
          },
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
}
