import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> iSeeAnErrorSnackbar(WidgetTester tester) async {
  expect(find.byType(SnackBar), findsOneWidget);
}
