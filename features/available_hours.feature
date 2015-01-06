Feature: Calculate the number of available PTO hours

  Scenario Outline:
    Given my I was hired on <Hired On>
    And today is <Current Date>
    And I used <PTO Hours Used> hours of PTO
    And I've requested <PTO Hours Requested> hours of PTO
    When I inquire about my available pto hours
    Then my available pto hours should be <Available PTO Hours>

  Examples:
    | Hired On   | Current Date | PTO Hours Used | PTO Hours Requested | Available PTO Hours |
    | 2013-11-11 | 2013-11-30   | 0              | 0                   | 13.33               |
    | 2013-11-11 | 2013-11-30   | 0              | 8                   | 5.33                |
    | 2013-11-11 | 2013-12-30   | 0              | 0                   | 13.33               |
    | 2013-11-11 | 2014-11-30   | 0              | 0                   | 100.00              |
    | 2013-11-11 | 2014-12-30   | 0              | 0                   | 100.00              |
    | 2013-11-11 | 2015-01-03   | 0              | 0                   | 220.00              |
    | 2013-11-11 | 2015-01-03   | 72             | 0                   | 148.00              |
    | 2013-11-11 | 2015-01-03   | 72             | 16                  | 132.00              |
