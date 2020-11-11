*** Settings ***
Documentation  Monitoring getDataFromWebPage  report in Kestra Apex Intersys Workspace
Resource  Resources/ReportsTestsResources.robot
Library  SeleniumLibrary
Suite Setup     Log in into power bi
Suite Teardown      close browser

*** Test Cases ***
Test Get data from web page QATEST
    [Tags]  get-data-from-webpage   kestra-apex-intersys
    Search workspace    Kestra Apex Intersys
    Filter by Report name   Get fata from web page QATEST
    Click and open report   Get fata from web page QATEST    xpath://*[@class="displayAreaViewport"]

Test EOS Scorecard
    [Tags]  EOS   kestra-apex-intersys
    Search workspace    EOS Scorecard
    Filter by Report name   EOS Dashboard
    Click and open report   EOS Dashboard   xpath://*[@class="visual visual-pivotTable allow-deferred-rendering"]
    