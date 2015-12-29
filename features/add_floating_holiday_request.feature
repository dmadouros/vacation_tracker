Feature: Add Floating Holiday Request

  So that I can have a record of past, current, and future days,
  As an employee,
  I want to add floating holiday requests

  Scenario: Add Floating Holiday Request
    Given I have an account
    And I have logged in before
    And I am logged in
    When I create a floating holiday request for 8 hours
    Then I should see the floating holiday request in my list