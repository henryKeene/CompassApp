import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> iSeeANoPlacesFoundError(WidgetTester tester) async {
  expect(find.byType(SnackBar), findsOneWidget);
  expect(find.textContaining('No places found'), findsOneWidget);
}
