import 'package:compass/src/presentation/pages/choice_selection_page.dart';
import 'package:flutter_test/flutter_test.dart';

/// Usage: I see the Choice selection page
Future<void> iSeeTheChoiceSelectionPage(WidgetTester tester) async {
  expect(find.text("Where to?"), findsOneWidget);
  expect(find.byType(ChoiceSelectionPage), findsOneWidget);
}
