Feature: A customer needs to login to access their Sky Bill

  Scenario: Visit the home page when not authorised
    When I go to the home page
    Then I should be sent to the login page

  Scenario: Visit the home page and provide incorrect credentials
    Given I am on the home page
    When I provide a username of foo and a password of bar
    And I click the Login button
    Then I should see the failed login page

  Scenario: Visit the home page with valid credentials
    Given I am on the home page
    When I provide a username of username and a password of password
    And I click the Login button
    Then Then I should be able to view my bill
