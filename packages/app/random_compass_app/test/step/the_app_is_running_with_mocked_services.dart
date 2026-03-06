import 'package:flutter_test/flutter_test.dart';
import 'package:random_compass_app/src/app.dart';

import 'helpers/test_setup.dart';

Future<void> theAppIsRunningWithMockedServices(WidgetTester tester) async {
  await setupTestDependencies();
  await tester.pumpWidget(App());
  await tester.pumpAndSettle();
}
