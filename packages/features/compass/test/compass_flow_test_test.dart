// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import './step/the_compass_flow_is_running_with_mocked_services.dart';
import './step/i_clean_up_dependencies.dart';
import './step/i_see_text.dart';
import './step/the_cafe_category_is_selected.dart';
import './step/i_tap_text.dart';
import './step/i_wait.dart';
import './step/the_restaurant_category_is_selected.dart';
import './step/i_see_the_compass_page.dart';
import './step/i_see_a_distance_in_kilometres.dart';
import './step/the_flow_is_completed.dart';
import './step/location_permission_is_denied.dart';
import './step/there_are_no_nearby_places.dart';
import './step/i_see_the_error_page.dart';
import './step/when_i_tap.dart';
import './step/i_see_the_choice_selection_page.dart';

void main() {
  group('''Compass Flow''', () {
    Future<void> bddSetUp(WidgetTester tester) async {
      await theCompassFlowIsRunningWithMockedServices(tester);
    }

    Future<void> bddTearDown(WidgetTester tester) async {
      await iCleanUpDependencies(tester);
    }

    testWidgets('''Choice selection page shows all categories''',
        (tester) async {
      try {
        await bddSetUp(tester);
        await iSeeText(tester, 'Where to?');
        await iSeeText(tester, 'Cafe');
        await iSeeText(tester, 'Restaurant');
        await iSeeText(tester, 'Bar');
        await iSeeText(tester, 'Pub');
        await iSeeText(tester, 'Discover');
      } finally {
        await bddTearDown(tester);
      }
    });
    testWidgets('''Cafe is selected by default''', (tester) async {
      try {
        await bddSetUp(tester);
        await theCafeCategoryIsSelected(tester);
      } finally {
        await bddTearDown(tester);
      }
    });
    testWidgets('''User can select a different category''', (tester) async {
      try {
        await bddSetUp(tester);
        await iTapText(tester, 'Restaurant');
        await iWait(tester);
        await theRestaurantCategoryIsSelected(tester);
      } finally {
        await bddTearDown(tester);
      }
    });
    testWidgets('''User discovers a nearby cafe''', (tester) async {
      try {
        await bddSetUp(tester);
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
    testWidgets('''User discovers a nearby pub''', (tester) async {
      try {
        await bddSetUp(tester);
        await iTapText(tester, 'Pub');
        await iWait(tester);
        await iTapText(tester, 'Discover');
        await iWait(tester);
        await iSeeTheCompassPage(tester);
        await iSeeText(tester, 'Pub');
      } finally {
        await bddTearDown(tester);
      }
    });
    testWidgets('''User can complete the flow from compass page''',
        (tester) async {
      try {
        await bddSetUp(tester);
        await iTapText(tester, 'Discover');
        await iWait(tester);
        await iSeeTheCompassPage(tester);
        await iTapText(tester, 'New Adventure');
        await iWait(tester);
        await theFlowIsCompleted(tester);
      } finally {
        await bddTearDown(tester);
      }
    });
    testWidgets('''Permission denied keeps user on choice selection''',
        (tester) async {
      try {
        await bddSetUp(tester);
        await locationPermissionIsDenied(tester);
        await iTapText(tester, 'Discover');
        await iWait(tester);
        await iSeeText(tester, 'Where to?');
        await iSeeText(tester, 'Discover');
      } finally {
        await bddTearDown(tester);
      }
    });
    testWidgets('''Error is shown when no places are found''', (tester) async {
      try {
        await bddSetUp(tester);
        await thereAreNoNearbyPlaces(tester);
        await iTapText(tester, 'Discover');
        await iWait(tester);
        await iSeeTheErrorPage(tester);
        await whenITap(tester, 'Try again');
        await iWait(tester);
        await iSeeTheChoiceSelectionPage(tester);
      } finally {
        await bddTearDown(tester);
      }
    });
  });
}
