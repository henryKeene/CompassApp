import 'package:flutter_test/flutter_test.dart';

import 'helpers/test_setup.dart';

Future<void> iCleanUpDependencies(WidgetTester tester) async {
  await teardownTestDependencies();
}
