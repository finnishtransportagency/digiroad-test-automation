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
Kaista_kunta_get    [Arguments]    ${testipaikka}
    ${response2}=    GET  ${Kaista_kunta_api_url_235}  headers=${headers}
    Log    ${response2.content}
    Request Should Be Successful    ${response2}

    FOR   ${item}   IN  @{response2.json()}
        Log  ${item}
        ${item_roadnumber}=          Set variable    ${item['roadNumber']}
        ${item_roadpartnumber}=      Set variable    ${item['roadPartNumber']}
        ${item_track}=               Set variable    ${item['track']}
        ${item_startaddrvalue}=      Set variable    ${item['startAddrMValue']}
        ${item_endaddrmvalue}=       Set variable    ${item['endAddrMValue']}
        ${item_lanecode}=            Set variable    ${item['laneCode']}
        ${item_lanetype}=            Set variable    ${item['laneType']}
    END


Kaista_kunta_get_ui_vertailu    [Arguments]    ${testipaikka}
#   GET-pyyntö
    ${response2}=    GET  ${Kaista_kunta_api_url_235}  headers=${headers}
    Log    ${response2.content}
    Request Should Be Successful    ${response2}
#   Evaluoidaan JSON
    ${lanes_in_municipality_json}=    Evaluate    json.loads('''${response2.content}''')    json
    ${typestring}=    Evaluate     type(${lanes_in_municipality_json})
    Log To Console     ${typestring}

#    UI Testin koodi
    Login To DigiRoad
    Testin Aloitus
    Siirry Testipaikkaan                ${TL_Kaistan_mallinnustyökalu_RB}  ${testipaikka}
    Odota sivun latautuminen
    Sleep    3
    Click Element At Coordinates        ${Kartta}  0  20
    Wait Until Element Is Visible       ${FA_otsikko}
    ${api_TIENNUMERO}=      Get Text    xpath=/html/body/div[1]/div[2]/main/article/div[2]/div/div[3]/div/div[2]/p
    ${api_TIEOSANUMERO}     Get Text    xpath=/html/body/div[1]/div[2]/main/article/div[2]/div/div[3]/div/div[3]/p
    ${api_AJORATA}          Get Text    xpath=/html/body/div[1]/div[2]/main/article/div[2]/div/div[3]/div/div[4]/p
    ${api_ALKUETÄISYYS}     Get Text    xpath=/html/body/div[1]/div[2]/main/article/div[2]/div/div[3]/div/div[5]/p
    ${api_LOPPUETÄISYYS}    Get Text    xpath=/html/body/div[1]/div[2]/main/article/div[2]/div/div[3]/div/div[6]/p
    ${api_PITUUS}           Get Text    xpath=/html/body/div[1]/div[2]/main/article/div[2]/div/div[3]/div/div[7]/p
    ${api_TIENNUMERO}=    Convert To Integer    ${api_TIENNUMERO}
    ${api_TIEOSANUMERO}=    Convert To Integer    ${api_TIEOSANUMERO}
    ${api_AJORATA}=    Convert To Integer    ${api_AJORATA}
    ${api_ALKUETÄISYYS}=    Convert To Integer    ${api_ALKUETÄISYYS}
    ${api_LOPPUETÄISYYS}=    Convert To Integer    ${api_LOPPUETÄISYYS}
    ${api_PITUUS}=    Convert To Integer    ${api_PITUUS}

    #muodostetaan ui-tiedoista sanakirja
    &{api_sanakirja_}=    Create Dictionary      roadNumber=${api_TIENNUMERO}    roadPartNumber=${api_TIEOSANUMERO}     track=${api_AJORATA}     startAddrMValue=${api_ALKUETÄISYYS}     #endAddrMValue=${api_LOPPUETÄISYYS}     #laneCode=21     laneType=1
    Log  ${api_sanakirja_}

    #muodostetaan ui-tiedoista lista
    @{api_lista_}=    Create List    ${api_TIENNUMERO}    ${api_TIEOSANUMERO}     ${api_AJORATA}     ${api_ALKUETÄISYYS}     #${api_LOPPUETÄISYYS}     #21     1
    Log    ${api_lista_}

#vertaa vastausta ja ui-tietoja keskenään
    FOR   ${item}   IN  @{response2.json()}
        Log  ${item}
        ${item_roadnumber}=          Set variable    ${item['roadNumber']}
        ${item_roadpartnumber}=      Set variable    ${item['roadPartNumber']}
        ${item_track}=               Set variable    ${item['track']}
        ${item_startaddrvalue}=      Set variable    ${item['startAddrMValue']}
        #${item_endaddrmvalue}=       Set variable    ${item['endAddrMValue']}
        #${item_lanecode}=            Set variable    ${item['laneCode']}
        #${item_lanetype}=            Set variable    ${item['laneType']}

        @{arvolista}=    Create List    ${item_roadnumber}    ${item_roadpartnumber}    ${item_track}    ${item_startaddrvalue}    #${item_endaddrmvalue}    #${item_lanecode}    ${item_lanetype}

        &{arvosanakirja}=    Create Dictionary    roadNumber=${item_roadnumber}    roadPartNumber=${item_roadpartnumber}    track=${item_track}    startAddrMValue=${item_startaddrvalue}    #endAddrMValue=${item_endaddrmvalue}    #laneCode=${item_lanecode}    laneType=${item_lanetype}

        ${listavertaus}=    Run Keyword And Return Status    Lists Should Be Equal   ${arvolista}    ${api_lista_}
        IF    '${listavertaus}' == 'True'    Log to Console    Tiedot täsmäävät
        IF    '${listavertaus}' == 'False'    CONTINUE

        FOR    ${j}    IN    @{arvolista}
            Log    ${j}
            ${listavertaus}=    Run Keyword And Return Status    Should Be Equal   ${arvolista}    ${api_sanakirja_}
            IF    '${listavertaus}' == 'False'    CONTINUE
        END
    END


 #  #vertaa api-vastausta ui:n kautta haettuihin tietoihin
 #  FOR    ${key}    IN    &{response2.json()}
 #      ${API_lanes_in_municipality_check_json_key_loop}=     Run Keyword and Return Status    Dictionary Should Contain Item    &{api_sanakirja_}    ${key}
 #      #${API_lanes_in_municipality_check_json_value_loop}=    Run Keyword And Return Status    Dictionary Should Contain Value  ${lanes_in_municipality_json}    ${api_sanakirja_}[${key}]
 #      IF    '${API_lanes_in_municipality_check_json_key_loop}' == 'False'    CONTINUE
 #  END

*** Variables ***
${API_URI_lanes_in_municipality}      /externalApi/lanes/lanes_in_municipality
&{headers}=                           X-Api-Key=${API_autentikointi}    accept=application/json
${Kaista_kunta_api_url_235}               https://api.testivaylapilvi.fi/digiroad/externalApi/lanes/lanes_in_municipality?municipality\=235