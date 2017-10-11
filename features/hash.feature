Feature: Hash navigation
  In order to do things quickly
  As a user
  I want the page to respond to hash changes properly

  Scenario: Clicking on hash links
    When I check the random uuid value on page
    And I click on the 'Nitro Debugging' hyperlink
    Then I should not see a new uuid value on page
    And The 'nitrolinks_debugging' page should not be loaded in any way
    And There should not be any javascript errors

  Scenario: Clicking on empty hash
    When I check the random uuid value on page
    And I click on the 'Nitro Hash' hyperlink
    Then I should not see a new uuid value on page
    And The 'nitrolinks_hash' page should not be loaded in any way
    And There should not be any javascript errors

  Scenario: Clicking on hash links again and again
    When I check the random uuid value on page
    And I click on the 'Nitro Hash' hyperlink
    And I click on the 'Nitro Hash' hyperlink
    Then I should not see a new uuid value on page
    And The 'nitrolinks_hash' page should not be loaded in any way
    And There should not be any javascript errors
