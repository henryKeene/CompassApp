Feature: Compass Discovery
  As a user looking for somewhere new to go
  I want to discover a random nearby place
  So that I can follow the compass to get there

  Background:
    Given the app is running with mocked services

  After:
    Then I clean up dependencies

  Scenario: Home screen shows category options and discover button
    Then I see {'Random Compass'} text
    And I see {'Cafe'} text
    And I see {'Restaurant'} text
    And I see {'Bar'} text
    And I see {'Discover'} text
    And I see {'Adventures: 0'} text

  Scenario: User discovers a nearby cafe
    Given cafe is selected by default
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

  Scenario: Discovery count increases after finding a place
    When I tap {'Discover'} text
    And I wait
    And I go back to the home page
    Then I see {'Adventures: 1'} text

  Scenario: Multiple discoveries increment the count correctly
    When I tap {'Discover'} text
    And I wait
    And I go back to the home page
    And I tap {'Restaurant'} text
    And I wait
    And I tap {'Discover'} text
    And I wait
    And I go back to the home page
    Then I see {'Adventures: 2'} text

  Scenario: User can start a new adventure from the compass page
    When I tap {'Discover'} text
    And I wait
    Then I see the compass page
    When I go back to the home page
    Then I see {'Random Compass'} text
    And I see {'Discover'} text

  Scenario: Permission denied keeps user on home page
    Given location permission is denied
    When I tap {'Discover'} text
    And I wait
    Then I see {'Random Compass'} text
    And I see {'Adventures: 0'} text

  Scenario: Error is shown when no places are found nearby
    Given there are no nearby places
    When I tap {'Discover'} text
    And I wait
    Then I see a no places found error
