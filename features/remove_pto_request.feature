@javascript
Feature: Remove PTO Request

  So that I can have an accurate record of my PTO,
  As an employee,
  I want to remove PTO requests

  Scenario: Remove PTO Request
    Given I have an account
    And I have logged in before
    And I am logged in
    And I have added a PTO request
    When I remove that PTO request
    Then I should not see that PTO request in my list