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
Kaista_väli_get    [Arguments]        ${kaista_api_kaistamäärä}    ${kaista_api_tienumero}    ${kaista_api_tienosanumero}    ${kaista_api_välinumero}
    [Documentation]    Find given values from response. 
    ...    This is a negative test, where all lanes from a given municipality are searched for values given as parameters. Unlike ordinary tests, "failure" is a default outcome of sort.
    #GET-pyyntö
    #Set Max Redirects
    ${Kaista_väli_api_url_blank}=    Set Variable    https://api.testivaylapilvi.fi/digiroad/externalApi/lanes/lanes_in_municipality?municipality\=${kaista_api_välinumero}

    TRY
            ${response}=    GET    ${Kaista_väli_api_url_blank}    headers=${headers}
    EXCEPT
            ${response}=    GET    ${Kaista_väli_api_url_blank}    headers=${headers}
    END

    #${response}=    GET    ${Kaista_väli_api_url_blank}    headers=${headers}
    Log    ${response.content}
    Request Should Be Successful    ${response}

    #Asetetaan vastauksen tiedot muuttujiin ja tarkistetaan ne
    #Testissä käytetään "maastossa havaittuja" kaistatietoja jota verrataan API:sta saatuun tietoon
    FOR    ${item}    IN    @{response.json()}
        Log    ${item}
        ${item_roadnumber}=          Set variable    ${item['roadNumber']}
        ${item_roadpartnumber}=      Set variable    ${item['roadPartNumber']}
        ${item_track}=               Set variable    ${item['track']}
        ${item_startaddrvalue}=      Set variable    ${item['startAddrMValue']}
        ${item_endaddrmvalue}=       Set variable    ${item['endAddrMValue']}
        ${item_lanecode}=            Set variable    ${item['laneCode']}
        ${item_lanetype}=            Set variable    ${item['laneType']}
        ${item_roadnumber}=          Convert To Integer    ${item_roadnumber}
        ${item_roadpartnumber}=      Convert To Integer    ${item_roadpartnumber}
        ${item_track}=               Convert To Integer    ${item_track}
        ${item_startaddrvalue}=      Convert To Integer    ${item_startaddrvalue}
        ${item_endaddrmvalue}=       Convert To Integer    ${item_endaddrmvalue}
        ${item_lanecode}=            Convert To Integer    ${item_lanecode}
        ${item_lanetype}=            Convert To Integer    ${item_lanetype}
        ${tarkista_tienumero}=    Run Keyword And Return Status    Should Be Equal As Integers   ${item_roadnumber}    ${kaista_api_tienumero}
        ${tarkista_tienosanumero}=    Run Keyword And Return Status    Should Be Equal As Integers    ${item_roadpartnumber}    ${kaista_api_tienosanumero}
        ${kaistan_manuaalivertailu}=    Run Keyword And Return Status    Should Be Equal As Integers    ${item_lanetype}    ${kaista_api_kaistamäärä}
        IF    '${tarkista_tienumero}' == 'False'    CONTINUE
        IF    '${tarkista_tienumero}' == 'True'    Log    Road number ${kaista_api_tienumero} starting from ${item_startaddrvalue}, lane ${kaista_api_kaistamäärä} found    console=yes
        IF    '${tarkista_tienosanumero}' == 'False'    CONTINUE
        IF    '${tarkista_tienosanumero}' == 'True'    Log    Road number ${kaista_api_tienumero}, part ${kaista_api_tienosanumero} starting from ${item_startaddrvalue}, lane ${kaista_api_kaistamäärä} found    console=yes
        IF    '${kaistan_manuaalivertailu}' == 'False'    CONTINUE
        IF    '${kaistan_manuaalivertailu}' == 'True'    Log    Tiedot täsmäävät, kaistoja on ${item_lanetype}    console=yes
        IF    '${kaistan_manuaalivertailu}' == 'True'    BREAK
    END
    #Delete All Sessions


*** Variables ***
${179_Lohikoskentie_kaistamäärä}    3