import 'package:flutter_test/flutter_test.dart';

Future<void> iGoBackToTheHomePage(WidgetTester tester) async {
  await tester.tap(find.text('New Adventure'));
  await tester.pumpAndSettle();
}
