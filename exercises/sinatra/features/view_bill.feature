Feature: A customer can view their Sky Bill

  Scenario: Visit the home page and the expected data is displayed
    Given I have logged in
    Then The page title should should be 'Sky Bill'
    And The page header is 'Sky Bill'
    And The bill total is '£136.03'

  Scenario Outline: The bill panels start collapsed
    Given I have logged in
    Then The <panel> panel exists
    And The <panel> panel is collapsed
    Examples:
      | panel    |
      | packages |
      | calls    |
      | store    |

  Scenario Outline: The bill panels expand when clicked
    Given I have logged in
    When I click the <panel> panel header
    Then The <panel_to_expand> panel expands
    Examples:
      | panel         | panel_to_expand |
      | packagesPanel | packages      |
      | callsPanel    | calls         |
      | storePanel    | store         |
