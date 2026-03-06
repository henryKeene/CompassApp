// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import './step/the_home_page_is_shown.dart';
import './step/i_see_text.dart';
import './step/i_tap_text.dart';
import './step/the_on_start_adventure_callback_is_triggered.dart';

void main() {
  group('''Home Screen''', () {
    Future<void> bddSetUp(WidgetTester tester) async {
      await theHomePageIsShown(tester);
    }

    testWidgets('''Home screen displays all key elements''', (tester) async {
      await bddSetUp(tester);
      await iSeeText(tester, 'Random Compass');
      await iSeeText(tester, 'Discover somewhere new');
      await iSeeText(tester, 'Start Adventure');
      await iSeeText(tester, 'Adventures');
    });
    testWidgets('''Adventure counter starts at zero''', (tester) async {
      await bddSetUp(tester);
      await iSeeText(tester, '0');
    });
    testWidgets('''Tapping start adventure triggers callback''',
        (tester) async {
      await bddSetUp(tester);
      await iTapText(tester, 'Start Adventure');
      await theOnStartAdventureCallbackIsTriggered(tester);
    });
  });
}
