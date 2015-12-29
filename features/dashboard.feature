Feature: View My Dashboard

  Scenario: I am a first time user
    Given I have an account
    And I am not logged in
    And I have never logged in before
    When I login
    Then I should be asked to create my profile

  Scenario: I am a returning user
    Given I have an account
    And I am not logged in
    But I have logged in before
    When I login
    Then I should be shown my dashboard

  Scenario: I visit my dashboard
    Given I have an account
    And I have logged in before
    And I am logged in
    When I visit my dashboard
    Then I should see my hire date
    And I should see my available pto hours

  Scenario: I visit my dashboard to view PTO requests
    Given I have an account
    And I have logged in before
    And I have added several PTO requests
    And I am logged in
    When I visit my dashboard
    Then I should see my pto requests ordered by start date

  Scenario: I visit my dashboard when not logged in
    Given I have an account
    And I have logged in before
    And I am not logged in
    When I visit my dashboard
    Then I should be asked for my authentication credentials
