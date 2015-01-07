Feature: Edit profile

  Scenario: I edit an existing profile
    Given I have a profile
    And I am logged in
    When I edit a profile
    Then I should be shown my dashboard
    And I should be shown a success message

  Scenario: I visit the edit profile page when not logged in
    Given I have a profile
    And I am not logged in
    When I try to edit a profile
    Then I should be asked for my authentication credentials

  Scenario: I edit an existing profile with bad data
    Given I have a profile
    And I am logged in
    When I edit a profile with invalid data
    Then I should be shown a save error message