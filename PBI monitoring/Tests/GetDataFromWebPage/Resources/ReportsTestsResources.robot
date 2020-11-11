*** Settings ***
Resource   ../../../Common Utilities/Resources/WebResouces.robot
Variables   ../../../ConstrantsCommon.yaml


*** Keywords ***
Log in into power bi
    open browser      ${PBI_LOGIN}     chrome
    maximize browser window
    Wait For And Input Text  name:loginfmt   ${PBI_USER}
    click element   id:idSIButton9
    Wait For And Input Text  name:passwd   ${PBI_PASSWORD}
    click element   id:idSIButton9
    Wait For And Click Element  id:idSIButton9
    Wait 30s For Element IS Visible   xpath://*[@class="workspacesPaneExpander switcher"]

Search workspace
    [Arguments]     ${workspaceName}
    #seach for an specific workspace
    Reload Page
    click element   xpath://*[@class="workspacesPaneExpander switcher"]
    Wait 30s For Element IS Visible    xpath://*[@type="text"]
    press keys  xpath://*[@type="text"]  ${workspaceName}
    #Click on workspace
    Wait For And Click Element   xpath://*[@class="groupContextMenuButton"]/button[@title="${workspaceName}"]
    #wait until workspace's banner loads
    Wait 30s For Element IS Visible  xpath://*[@class="fluentListHeaderTitle"]


Filter by Report name
    [Arguments]     ${reportName}
    #Search for an specific report and filter by Reports
    Wait For And Input Text  xpath://*[@class="mat-form-field-infix"]  ${reportName}
    #use Reports as filter
    Wait For And Click Element   xpath://button/span[@class="mat-button-wrapper"]/span[@localize="Filters"]
    Wait For And Click Element   xpath://*[@class="mat-checkbox mat-accent ng-star-inserted"][@title="Report"]
    Wait For And Click Element   xpath://*[@title="Close"]


Click and open report
    [Arguments]   ${reportName}  ${elementInReportLocator}
    #Click on the report
    Wait For And Click Element   xpath://*[@title="${reportName}"]
    #Validate one element in the page is visible
    Wait 30s For Element IS Visible   ${elementInReportLocator}
    log to console  Issues_PowerBI_WebSite_Data report



