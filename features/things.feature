@javascript
Feature: Things

  Scenario: CUD Things
    When I am on the things page
    Then I should see "Things" within the page header

    When I follow "Add Thing"
    Then I should see "Create new Thing"

    When I press "Save"
    Then the "Name" field should the error "can't be blank"
      And the "Identifier" field should the error "address or identifier must be present"
      And the "Address" field should the error "address or identifier must be present"

    When I fill in "Name" with "Test Thing"
      And I fill in "Identifier" with "test_thing"
      And I fill in "Address" with "127.0.0.1"
      And I press "Save"
    Then I should be on the things page
      And I should see "Test Thing"

    When I follow "edit"
    Then I should see "Edit Test Thing"
      And the "Name" field should contain "Test Thing"
      And the "Identifier" field should contain "test_thing"
      And the "Address" field should contain "127.0.0.1"

    When I fill in "Name" with "Something useful"
      And I press "Update"
    Then I should be on the things page
      And I should see "Something useful"
    But I should not see "Test Thing"

    When I follow "delete"
      And I confirm the browser dialog
    Then I should be on the things page
      And I should not see "Test Thing"