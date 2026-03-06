import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> iSeeTheCompassPage(WidgetTester tester) async {
  expect(find.text('Navigate'), findsOneWidget);
  expect(find.byIcon(Icons.navigation), findsOneWidget);
}
