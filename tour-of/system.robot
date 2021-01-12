*** Settings ***
Library     TestProjectLibrary
#Library     SeleniumLibrary

*** Keywords ***
Configure Selenium
    Set Selenium Speed    .25 Seconds

Navigate To Homepage
    Init Testproject Driver     browser=${Browser}     timeout=${Delay}     project_name=TestProject Project from Robot       job_name=TestProject Job from Robot      url=${SiteUrl}
    #Open Browser            ${SiteUrl}      ${BROWSER}
    Maximize Browser Window

Exit Selenium
    #Capture Page Screenshot
    Close All Browsers
    #Close Browser
    
Generate Random Number
    ${random_number}    Evaluate            random.randint(1000000, 9999999)   random
    [return]            ${random_number}
