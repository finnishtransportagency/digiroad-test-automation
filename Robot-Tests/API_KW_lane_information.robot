#    Joni Laari        Sitowise        2023

*** Settings ***
Documentation  Testit ajetaan suoraan api:n kautta. 
Resource   common_keywords.robot
Resource   API_keywords.robot
Library    Process
Library    XML
Library    OperatingSystem
Library    RequestsLibrary
Library    Collections

*** Keywords ***
Kaista_tieto_get    [Arguments]
    [Documentation]    Find given values from response. 
    ...    This is a negative test, where all changes from a given municipality are searched for values given as parameters. Unlike ordinary tests, "failure" is a default outcome of sort.
    #GET-pyyntö
    ${end_date} =    Get Current Date
    ${end_date} =    Convert Date    ${end_date}    result_format=%Y-%m-%dT%H:%M:%SZ
    ${start_date} =    Subtract Time From Date    ${end_date}    1 hour
    ${start_date} =    Convert Date    ${start_date}    result_format=%Y-%m-%dT%H:%M:%SZ
    ${Kaista_tieto_api_url_blank}=    Set Variable    https://api.testivaylapilvi.fi/digiroad/externalApi/changes/lane_information?since=${start_date}&until=${end_date}
    ${response}=    GET  ${Kaista_tieto_api_url_blank}  headers=${headers}
    Log    ${response.content}
    Request Should Be Successful    ${response}


*** Variables ***
${API_URI_lane_information}               /externalApi/changes/lane_information
&{headers}=                               X-Api-Key=${API_autentikointi}    accept=application/json