import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> theCafeCategoryIsSelected(WidgetTester tester) async {
  final container = tester.widget<Container>(
    find.ancestor(
      of: find.text('Cafe'),
      matching: find.byType(Container),
    ).last,
  );
  final decoration = container.decoration! as BoxDecoration;
  expect(decoration.border?.top.width, 2);
}
