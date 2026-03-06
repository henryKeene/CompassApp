import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> cafeIsSelectedByDefault(WidgetTester tester) async {
  final chip = tester.widget<ChoiceChip>(
    find.ancestor(
      of: find.text('Cafe'),
      matching: find.byType(ChoiceChip),
    ),
  );
  expect(chip.selected, isTrue);
}
