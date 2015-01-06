Feature: Add PTO Request

  So that I can have a record of past, current, and future days,
  As an employee,
  I want to add PTO requests

  Scenario: Add PTO Request
    Given I have an account
    And I have logged in before
    And I am logged in
    When I create a PTO request for 8 hours
    Then I should see the PTO request in my list