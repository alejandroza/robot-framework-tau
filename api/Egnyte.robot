# pip install robotframework-requests
*** Settings ***
Library             RequestsLibrary
Library             Collections
Library             OperatingSystem
Library             String
Library             ExcelLibrary

*** Variables ***
${Dev_URL}          https://kestracloud.egnyte.com
${Dev_token}        5xffzsp73etdvkybhbt7paxy

${Prd_URL}          https://kestrafinancial.egnyte.com
${Prd_token}        jgbdgskbqp5cazygqbmrh7h2

${path_excel}       ${EXECDIR}${/}Entreda_Egnyte_Users.xlsx
${user_perms}       Editor
${folder_path}      Shared/RepFolders

*** Test Cases ***
Test Egnyte Users permission
    [Tags]  DeviceSecurityCompliance     Egnyte     eDelivery   eDeliveryPermissions

    # Code to test Waves from excel
    ${my_data_as_list}=    Create List
    Open Excel Document    ${path_excel}    docid
    ${code_list}           Read Excel Column   2
    Close All Excel Documents

    FOR    ${code}   IN   @{code_list}
        # Calls to Keywords that make the validation for user existence and permission
        run keyword and continue on failure     Check user existence              email     ${code}
        #run keyword and continue on failure     Check user permission to folder   ${code}     ${folder_path}     ${code}   ${user_perms}
    END

*** Keywords ***
Check user permission to folder
    [Arguments]     ${code}       ${folder_path}    ${Username}     ${perms}
    # Creation of the session, header with Authorization needed for the request
    ${mysession}=       Create Session and Header with Authorization
    # Make the GET request
    ${response}=        GET On Session     ${mysession}[0]     pubapi/v2/perms/${folder_path}/${code}      headers=${mysession}[1]
    # Validations to make sure corresponding user has permission to the folder
    status should be    200             ${response}
    should contain      str(${response.content})     "${Username}":"${perms}"   User permission failed for ${Username}   ignore_case=True

    delete all sessions


Check user existence
    [Arguments]     ${filter}     ${value}
    # Creation of the session, header with Authorization needed for the request
    ${mysession}=       Create Session and Header with Authorization
    # Make the GET request
    ${response}=        GET On Session     ${mysession}[0]     url=pubapi/v2/users?filter=${filter} Eq "${value}"      headers=${mysession}[1]
    # Validations to make sure the user exists and its status 
    #run keyword and continue on failure     status should be    200     ${response}
    should contain      str(${response.content})     "totalResults":1       totalResults failed for ${value}    ignore_case=True
    run keyword and continue on failure     should contain      str(${response.content})     "active":true          active failed for ${value}    ignore_case=True
    run keyword and continue on failure     should contain      str(${response.content})     "locked":false         locked failed for ${value}    ignore_case=True
    run keyword and continue on failure     should contain      str(${response.content})     "authType":"sso"       authType failed for ${value}    ignore_case=True

    delete all sessions


Create Session and Header with Authorization
    # Creation of the session, header with Authorization needed for the request
    create session      my_session          ${Dev_URL}                      verify=True
    ${headers}=         Create Dictionary   Authorization=Bearer ${Dev_token}
    ${session_header}=  Create List         my_session  ${headers}
    # Let's delay the execution since Egnyte allows 2 API calls per second per token
    # Status code 403 is returned when the rate-limiting is reached
    Sleep   0.5s
    # Return the list that has the session and the header
    [Return]  ${session_header}