Feature: Calculate the number of accrued PTO hours

  Scenario Outline:
    Given my I was hired on <Hired On>
    And today is <Current Date>
    And I used <PTO Hours Used> hours of PTO
    When I inquire about my accrued pto hours
    Then my accrued pto hours should be <Accrued PTO Hours>

  Examples:
    | Hired On   | Current Date | PTO Hours Used | Accrued PTO Hours |
    | 2013-11-11 | 2013-11-30   | 0              | 0.00              |
    | 2013-11-11 | 2013-12-30   | 0              | 6.67              |
    | 2013-11-11 | 2014-11-30   | 0              | 80.00             |
    | 2013-11-11 | 2014-12-30   | 0              | 90.00             |
    | 2013-11-11 | 2015-01-03   | 0              | 100.00            |
    | 2013-11-11 | 2015-01-03   | 72             | 28.00             |
