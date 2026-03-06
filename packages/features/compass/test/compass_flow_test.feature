Feature: Compass Flow
  As a user looking for somewhere new to go
  I want to pick a category and discover a place
  So that I can follow the compass to get there

  Background:
    Given the compass flow is running with mocked services

  After:
    Then I clean up dependencies

  Scenario: Choice selection page shows all categories
    Then I see {'Where to?'} text
    And I see {'Cafe'} text
    And I see {'Restaurant'} text
    And I see {'Bar'} text
    And I see {'Pub'} text
    And I see {'Discover'} text

  Scenario: Cafe is selected by default
    Then the cafe category is selected

  Scenario: User can select a different category
    When I tap {'Restaurant'} text
    And I wait
    Then the restaurant category is selected

  Scenario: User discovers a nearby cafe
    When I tap {'Discover'} text
    And I wait
    Then I see the compass page
    And I see a distance in kilometres
    And I see {'Cafe'} text

  Scenario: User discovers a nearby restaurant
    When I tap {'Restaurant'} text
    And I wait
    And I tap {'Discover'} text
    And I wait
    Then I see the compass page
    And I see {'Restaurant'} text

  Scenario: User discovers a nearby bar
    When I tap {'Bar'} text
    And I wait
    And I tap {'Discover'} text
    And I wait
    Then I see the compass page
    And I see {'Bar'} text

  Scenario: User discovers a nearby pub
    When I tap {'Pub'} text
    And I wait
    And I tap {'Discover'} text
    And I wait
    Then I see the compass page
    And I see {'Pub'} text

  Scenario: User can complete the flow from compass page
    When I tap {'Discover'} text
    And I wait
    Then I see the compass page
    When I tap {'New Adventure'} text
    And I wait
    Then the flow is completed

  Scenario: Permission denied keeps user on choice selection
    Given location permission is denied
    When I tap {'Discover'} text
    And I wait
    Then I see {'Where to?'} text
    And I see {'Discover'} text

  Scenario: Error is shown when no places are found
    Given there are no nearby places
    When I tap {'Discover'} text
    And I wait
    Then I see the error page
    Then when I tap {'Try again'}
    And I wait
    Then I see the Choice selection page


