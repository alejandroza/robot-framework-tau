*** Settings ***
Variables   ../../Environment/Global/ConstrantsCommon.yaml
Library			SeleniumLibrary
Library			Collections
Library			DateTime


*** Keywords ***
Wait For And Click Element
	[Arguments]		${locator}
	Wait 30s For Element IS Visible	${locator}
	Click Element					${locator}

Wait 30s For Element IS Visible
	[Arguments]		${locator}
	wait until element is visible	${locator}  30 seconds

Wait 60s For Element IS Visible
	[Arguments]		${locator}
	wait until element is visible	${locator}  60 seconds

Wait For And Input Text
	[Arguments]		${locator}		${text}
	wait until element is visible	${locator}
	press keys						${locator}		${text}

Wait For And Select Checkbox
	[Arguments]		${locator}
	wait until element is visible	${locator}
	Select Checkbox					${locator}

Wait For And Page Should Contain Element
	[Arguments]		${locator}
	wait until element is visible	${locator}
	Page Should Contain Element		${locator}

Set Environment Variables
	&{dict}=    BuiltIn.Get Variables
	Set Suite Variable    &{dict}

