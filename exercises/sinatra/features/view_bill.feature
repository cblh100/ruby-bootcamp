Feature: A customer can view their Sky Bill

  Scenario: Visit the home page when not authorised
    Given I go to the home page
    Then I should be required to authenticate
    And The authentication realm should be 'Sky Bill'

  Scenario: Visit the home page with incorrect credentials
    Given I have invalid credentials
      And I go to the home page
     Then I should be required to authenticate

  Scenario: Visit the home page with valid credentials
    Given I have valid credentials
    And I go to the home page
    Then The page title should should be 'Sky Bill'
    And I should see 'Hello'