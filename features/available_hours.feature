Feature: Calculate the number of available PTO hours

  Scenario Outline:
    Given my I was hired on <Hired On>
    And today is <Current Date>
    When I inquire about my available pto hours
    Then my available pto hours should be <Available PTO Hours>

  Examples:
    | Hired On   | Current Date | Available PTO Hours |
    | 2013-11-11 | 2013-11-30   | 0.00                |
    | 2013-11-11 | 2013-12-30   | 6.67                |
    | 2013-11-11 | 2014-11-30   | 80.00               |
    | 2013-11-11 | 2014-12-30   | 90.00               |
    | 2013-11-11 | 2015-01-03   | 100.00              |
