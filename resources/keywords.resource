*** Settings ***
Library    SeleniumLibrary
Resource    variables.resource

*** Keywords ***
Open Website
    Open Browser    url=http://www.way2automation.com/angularjs-protractor/webtables/    browser=Edge
    Maximize Browser Window
    Wait Until Element Is Visible    //*[contains(@class, 'smart-table')]//*[@ng-model='searchValue']

Click Add User Button
    Click Element    //*[contains(@class, 'smart-table')]//*[contains(@class, 'btn') and contains(normalize-space(), 'Add User')]
    Wait Until Element Is Visible    //*[contains(@class, 'ng-scope')]//*[contains(@class, 'header') and contains(normalize-space(), 'Add User')]

Input Add User Field
    [Arguments]    ${fieldName}    ${fieldValue}
    ${field} =    Set Variable    //*[contains(@name, 'smartTableValidForm')]//*[contains(@class, 'data-cell')]//*[contains(@name, '${fieldName}')]
    Input Text    ${field}    ${fieldValue}

Select Role Dropdown
    [Arguments]    ${fieldValue}
    ${dropdown} =    Set Variable    //*[contains(@name, 'smartTableValidForm')]//*[contains(@class, 'data-cell')]//*[contains(@name, 'RoleId')]
    Click Element    ${dropdown}
    Click Element    //*[contains(@name, 'smartTableValidForm')]//*[contains(@class, 'data-cell')]//*[contains(@name, 'RoleId')]//*[contains(normalize-space(), '${fieldValue}')]

Add User With Value
    [Arguments]    ${firstName}    ${lastName}    ${userName}    ${email}    ${mobilePhone}    ${role}    ${password}=${EMPTY}
    Input Add User Field    FirstName    ${firstName}
    Input Add User Field    LastName    ${lastName}
    Input Add User Field    UserName    ${userName}
    Input Add User Field    Email    ${email}
    Input Add User Field    Mobilephone    ${mobilePhone}
    Input Add User Field    Password    ${mobilePhone}
    Select Role Dropdown    ${role}

Click Save Button
    Click Element    //*[contains(@class, 'btn') and contains(normalize-space(), 'Save')]
    Wait Until Element Is Not Visible    //*[contains(@class, 'ng-scope')]//*[contains(@class, 'header') and contains(normalize-space(), 'Add User')]

Add User
    [Arguments]    ${user_data}
    Click Add User Button
    Add User With Value    firstName=${user_data}[FirstName]    lastName=${user_data}[LastName]    userName=${user_data}[UserName]    email=${user_data}[Email]    mobilePhone=${user_data}[Mobilephone]    role=${user_data}[Role]
    Click Save Button

Search By User Name
    [Arguments]    ${text}
    ${searchBar} =    Set Variable    //*[contains(@class, 'smart-table')]//*[@ng-model='searchValue']
    Input Text    ${searchBar}    ${text}

Verify User Is Created
    [Arguments]    ${user_name}
    Search By User Name    ${user_name}
    Wait Until Element Is Visible    //*[contains(@class, 'data-row')]//*[contains(@class, 'data-cell') and normalize-space()='${user_name}']

Delete User 
    [Arguments]    ${user_name}
    #Search By User Name    ${user_name}
    Wait Until Element Is Visible    //*[contains(@class, 'data-row')]//*[contains(@class, 'data-cell') and normalize-space()='${user_name}']
    Click Element    //*[contains(@class, 'data-row')]//*[contains(@class, 'data-cell') and normalize-space()='${user_name}']/following-sibling::*//*[contains(@class, 'remove')]
    ${confirmDialog} =    Set Variable    //*[contains(@class, 'modal-header')]//*[normalize-space()='Confirmation Dialog']
    Wait Until Element Is Visible    ${confirmDialog}
    Click Button    //*[contains(@class, 'modal-')]//button[normalize-space()='OK']
    Wait Until Element Is Not Visible    //*[contains(@class, 'data-row')]//*[contains(@class, 'data-cell') and normalize-space()='${user_name}']

Verify User Is Deleted
    [Arguments]    ${user_name}
    Search By User Name    ${user_name}
    Wait Until Element Is Not Visible    //*[contains(@class, 'data-row')]//*[contains(@class, 'data-cell') and normalize-space()='${user_name}']