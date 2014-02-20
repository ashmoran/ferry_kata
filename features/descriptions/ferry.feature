Feature: Ferry
  In order to cross the river
  As a traveller
  I want a ferry

  Background:
	  Given a Ferry has space capacity 6
    And there is a Port

  Scenario: No vehicles
    Given no vehicles have arrived
    Then a Ferry does not sail

  Scenario: One vehicle, not full
    When a van arrives
    Then a Ferry does not sail

  Scenario: Two vehicles, now full
    When a van arrives
    And another van arrives
    Then a Ferry sails

