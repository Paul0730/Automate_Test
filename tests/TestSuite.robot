*** Settings ***
Resource    ../resources/keywords.resource
Suite Setup    Open Website
Suite Teardown    Close Browser

*** Test Cases ***
Verify Add User
    Add User    ${test_user}
    User Should Be Visible On Data Table    testUser
    [Teardown]    Run Keywords    Delete User    testUser
    ...                    AND    Clear Search Bar

Verify Delete User
    Delete User     novak
    User Should Not Be Visible On Data Table    novak
    [Teardown]    Clear Search Bar