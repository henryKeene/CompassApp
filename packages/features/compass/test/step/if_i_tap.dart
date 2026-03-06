import 'package:flutter_test/flutter_test.dart';

/// Usage: if I tap {'Try again'}
Future<void> ifITap(WidgetTester tester, String param1) async {
  tester.tap(find.text(param1));
}
