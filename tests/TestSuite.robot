*** Settings ***
Resource    ./resources/keywords.resource
Suite Setup    Open Website
Suite Teardown    Close Browser

*** Test Cases ***
Verify Add User
    Add User    ${test_user}
    Verify User Is Created    testUser
    [Teardown]    Delete User    testUser