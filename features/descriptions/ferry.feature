Feature: Ferry
  In order to cross the river
  As a traveller
  I want a ferry

  Background:
	  Given a Ferry has space capacity 6 and weight capacity 10
    And there is 1 Ferry

  Scenario: No vehicles
    Given no vehicles have arrived
    Then a Ferry has not sailed

