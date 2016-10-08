@javascript
Feature: Edit PTO Request

  So that I can have an accurate record of my PTO,
  As an employee,
  I want to edit PTO requests

  Scenario: Edit PTO Request
    Given I have an account
    And I have logged in before
    And I am logged in
    And I have added a PTO request
    When I edit that PTO request
    Then I should see the updates to that PTO request in my list