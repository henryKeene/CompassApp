Feature: Home Screen
  As a user opening the app
  I want to see a welcoming home screen
  So that I can start an adventure

  Background:
    Given the home page is shown

  Scenario: Home screen displays all key elements
    Then I see {'Random Compass'} text
    And I see {'Discover somewhere new'} text
    And I see {'Start Adventure'} text
    And I see {'Adventures'} text

  Scenario: Adventure counter starts at zero
    Then I see {'0'} text

  Scenario: Tapping start adventure triggers callback
    When I tap {'Start Adventure'} text
    Then the on start adventure callback is triggered
