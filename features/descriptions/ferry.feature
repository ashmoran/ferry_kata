Feature: Ferry
  In order to cross the river
  As a traveller
  I want a ferry

  Background:
	  Given a Ferry has space capacity 14 and weight capacity 20
    And a Ferry sails every 20 minutes
    And there is 1 Ferry

  # Assuming for now we don't need Ferries to go to the other side
  Scenario: No vehicles
  	When 20 minutes pass
    Then a Ferry has not sailed