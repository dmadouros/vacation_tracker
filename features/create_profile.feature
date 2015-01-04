Feature: Create profile

  Scenario: I create a profile
    Given I have an account
    And I have never logged in before
    And I am logged in
    When I create a profile
    Then I should be shown my dashboard
    And I should be shown a success message

  Scenario: I try to create a profile (but I already have one)
    Given I have an account
    And I have logged in before
    And I am logged in
    When I try to create a profile
    Then I should be shown my dashboard
    And I should be shown a warning message