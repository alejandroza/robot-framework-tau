# pip install robotframework-requests
*** Settings ***
Library     RequestsLibrary
Library     Collections
Library     OperatingSystem
Library     String

*** Variables ***
${Base_URL}     https://postman-echo.com
@{Search_Text}  cars  bikes  skateboard

${Engynte_URL}  https://apidemo.egnyte.com/puboauth/token?
${grant_type}   password
${client_id}    5mns35zabc5wbchggw9dru77
${username}     test
${password}     password

*** Test Cases ***
Get Postman-echo Test
    FOR    ${search}    IN    @{Search_Text}
        ${params}=  Create Dictionary  foo1  ${search}
        Create Session      Get_session     ${Base_URL}
        ${response}=        GET REQUEST     Get_session     /get/?  params=${params}

        #Validations
        status should be    200     ${response}
        should contain      str(${response.content})     ${search}
        #Debug
        #log to console  ${search}
        log to console  ${response.content}
    END

Validate json response
    ${jsonfile}    Get File    ${EXECDIR}${/}response.json

    #${dic} =  GET FROM DICTIONARY     ${jsonfile}  userPerms
    #log to console      ${dic}

    #${str}  Convert To String   ${dic}
    ${response_list}  Split To Lines  ${jsonfile}  #:
    ${item_count}  Get Length  ${response_list}
    log to console      ${item_count}

Post with json body
    create session      Post_session    ${Base_URL}
    ${headers}=   Create Dictionary   Content-Type=application/json
    ${body}=    Get File    ${EXECDIR}/body.json
    ${response}=        POST REQUEST     Post_session   /post     headers=${headers}  data=${body}

    #Validations
    status should be    200     ${response}
    should contain      str(${response.content})     "foo1":"bar1"
    should contain      str(${response.content})     "foo2":"bar2"
    #Debug
    #log to console   ${response.content}
    #log to console  ${body}


#Post for getting BearerAuth Test
#    create session      Post_session    ${Engynte_URL}
#    ${headers}=   Create Dictionary   Content-Type=application/x-www-form-urlencoded
#    ${params}=    Create Dictionary   grant_type  ${grant_type}    client_id   ${client_id}   username    ${username}     password    ${password}
#    ${response}=        POST REQUEST     Post_session   /token?     headers=${headers}  params=${params}
#
#    #Validations
#    status should be    200     ${response}
#    should contain      str(${response.content})     access_token
#    log to console   ${response}
#    log to console   ${response.content}
#    ${json} =  Set Variable  ${response.json()}
#    ${token} =  GET FROM DICTIONARY     ${json}  access_token
#    log to console  ${token}