import 'package:compass/src/presentation/pages/no_places_found_page.dart' show NoPlacesFoundPage;
import 'package:flutter_test/flutter_test.dart';

/// Usage: I see the error page
Future<void> iSeeTheErrorPage(WidgetTester tester,) async {
  expect(find.byType(NoPlacesFoundPage), findsOneWidget);
}
