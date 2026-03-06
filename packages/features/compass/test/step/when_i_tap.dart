import 'package:flutter_test/flutter_test.dart';

/// Usage: when I tap {'Try again'}
Future<void> whenITap(WidgetTester tester, String param1) async {
  await tester.tap(find.text(param1));
}
