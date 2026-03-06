import 'package:compass/compass.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> theFlowIsCompleted(WidgetTester tester) async {
  // After flow.complete(), the FlowBuilder pops and we should no longer
  // see the compass flow pages. The choice selection page should be gone.
  expect(find.text('Navigate'), findsNothing);
  expect(find.byType(CompassFlow), findsNothing);
}
