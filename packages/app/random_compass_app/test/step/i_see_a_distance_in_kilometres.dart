import 'package:flutter_test/flutter_test.dart';

Future<void> iSeeADistanceInKilometres(WidgetTester tester) async {
  expect(find.textContaining('km'), findsOneWidget);
}
