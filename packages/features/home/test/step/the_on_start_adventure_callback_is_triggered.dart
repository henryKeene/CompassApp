import 'package:flutter_test/flutter_test.dart';

import 'the_home_page_is_shown.dart';

Future<void> theOnStartAdventureCallbackIsTriggered(
  WidgetTester tester,
) async {
  expect(onStartAdventureCalled, isTrue);
}
