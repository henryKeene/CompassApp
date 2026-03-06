// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import './../test/step/the_app_is_running_with_mocked_services.dart';
import './../test/step/i_clean_up_dependencies.dart';
import './../test/step/i_see_text.dart';
import './../test/step/cafe_is_selected_by_default.dart';
import './../test/step/i_tap_text.dart';
import './../test/step/i_wait.dart';
import './../test/step/i_see_the_compass_page.dart';
import './../test/step/i_see_a_distance_in_kilometres.dart';
import './../test/step/i_go_back_to_the_home_page.dart';
import './../test/step/location_permission_is_denied.dart';
import './../test/step/there_are_no_nearby_places.dart';
import './../test/step/i_see_a_no_places_found_error.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('''Compass Discovery''', () {
    Future<void> bddSetUp(WidgetTester tester) async {
      await theAppIsRunningWithMockedServices(tester);
    }

    Future<void> bddTearDown(WidgetTester tester) async {
      await iCleanUpDependencies(tester);
    }

    testWidgets('''Home screen shows category options and discover button''',
        (tester) async {
      try {
        await bddSetUp(tester);
        await iSeeText(tester, 'Random Compass');
        await iSeeText(tester, 'Cafe');
        await iSeeText(tester, 'Restaurant');
        await iSeeText(tester, 'Bar');
        await iSeeText(tester, 'Discover');
        await iSeeText(tester, 'Adventures: 0');
      } finally {
        await bddTearDown(tester);
      }
    });
    testWidgets('''User discovers a nearby cafe''', (tester) async {
      try {
        await bddSetUp(tester);
        await cafeIsSelectedByDefault(tester);
        await iTapText(tester, 'Discover');
        await iWait(tester);
        await iSeeTheCompassPage(tester);
        await iSeeADistanceInKilometres(tester);
        await iSeeText(tester, 'Cafe');
      } finally {
        await bddTearDown(tester);
      }
    });
    testWidgets('''User discovers a nearby restaurant''', (tester) async {
      try {
        await bddSetUp(tester);
        await iTapText(tester, 'Restaurant');
        await iWait(tester);
        await iTapText(tester, 'Discover');
        await iWait(tester);
        await iSeeTheCompassPage(tester);
        await iSeeText(tester, 'Restaurant');
      } finally {
        await bddTearDown(tester);
      }
    });
    testWidgets('''User discovers a nearby bar''', (tester) async {
      try {
        await bddSetUp(tester);
        await iTapText(tester, 'Bar');
        await iWait(tester);
        await iTapText(tester, 'Discover');
        await iWait(tester);
        await iSeeTheCompassPage(tester);
        await iSeeText(tester, 'Bar');
      } finally {
        await bddTearDown(tester);
      }
    });
    testWidgets('''Discovery count increases after finding a place''',
        (tester) async {
      try {
        await bddSetUp(tester);
        await iTapText(tester, 'Discover');
        await iWait(tester);
        await iGoBackToTheHomePage(tester);
        await iSeeText(tester, 'Adventures: 1');
      } finally {
        await bddTearDown(tester);
      }
    });
    testWidgets('''Multiple discoveries increment the count correctly''',
        (tester) async {
      try {
        await bddSetUp(tester);
        await iTapText(tester, 'Discover');
        await iWait(tester);
        await iGoBackToTheHomePage(tester);
        await iTapText(tester, 'Restaurant');
        await iWait(tester);
        await iTapText(tester, 'Discover');
        await iWait(tester);
        await iGoBackToTheHomePage(tester);
        await iSeeText(tester, 'Adventures: 2');
      } finally {
        await bddTearDown(tester);
      }
    });
    testWidgets('''User can start a new adventure from the compass page''',
        (tester) async {
      try {
        await bddSetUp(tester);
        await iTapText(tester, 'Discover');
        await iWait(tester);
        await iSeeTheCompassPage(tester);
        await iGoBackToTheHomePage(tester);
        await iSeeText(tester, 'Random Compass');
        await iSeeText(tester, 'Discover');
      } finally {
        await bddTearDown(tester);
      }
    });
    testWidgets('''Permission denied keeps user on home page''',
        (tester) async {
      try {
        await bddSetUp(tester);
        await locationPermissionIsDenied(tester);
        await iTapText(tester, 'Discover');
        await iWait(tester);
        await iSeeText(tester, 'Random Compass');
        await iSeeText(tester, 'Adventures: 0');
      } finally {
        await bddTearDown(tester);
      }
    });
    testWidgets('''Error is shown when no places are found nearby''',
        (tester) async {
      try {
        await bddSetUp(tester);
        await thereAreNoNearbyPlaces(tester);
        await iTapText(tester, 'Discover');
        await iWait(tester);
        await iSeeANoPlacesFoundError(tester);
      } finally {
        await bddTearDown(tester);
      }
    });
  });
}
