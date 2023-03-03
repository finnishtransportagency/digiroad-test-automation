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
    ## GET-pyyntö
    ${response2}=    GET  ${Kaista_kunta_api_url}  headers=${headers}
    Log    ${response2.content}
    Request Should Be Successful    ${response2}
    #Evaluoidaan JSON
    ${lanes_in_municipality_json}=    Evaluate    json.loads('''${response2.content}''')    json
    #${typestring}=    Evaluate     type(${lanes_in_municipality_json})
    #Log To Console     ${typestring}

#    UI Testin koodi
    Login To DigiRoad
    Testin Aloitus
    Siirry Testipaikkaan                ${TL_Kaistan_mallinnustyökalu_RB}  ${testipaikka}
    Odota sivun latautuminen
    Sleep    3
    Click Element At Coordinates        ${Kartta}  0  20
    Wait Until Element Is Visible       ${FA_otsikko}
    ${api_tiennumero}=      Get Text    xpath=/html/body/div[1]/div[2]/main/article/div[2]/div/div[3]/div/div[2]/p    
    ${api_TIEOSANUMERO}     Get Text    xpath=/html/body/div[1]/div[2]/main/article/div[2]/div/div[3]/div/div[3]/p
    ${api_AJORATA}          Get Text    xpath=/html/body/div[1]/div[2]/main/article/div[2]/div/div[3]/div/div[4]/p
    ${api_ALKUETÄISYYS}     Get Text    xpath=/html/body/div[1]/div[2]/main/article/div[2]/div/div[3]/div/div[5]/p
    ${api_LOPPUETÄISYYS}    Get Text    xpath=/html/body/div[1]/div[2]/main/article/div[2]/div/div[3]/div/div[6]/p
    ${api_PITUUS}           Get Text    xpath=/html/body/div[1]/div[2]/main/article/div[2]/div/div[3]/div/div[7]/p
    Log       ${api_tiennumero}   
    Log       ${api_TIEOSANUMERO} 
    Log       ${api_AJORATA}      
    Log       ${api_ALKUETÄISYYS} 
    Log       ${api_LOPPUETÄISYYS}
    Log       ${api_PITUUS}       

    &{api_lista_}=    Create Dictionary      roadNumber=${api_tiennumero}    roadPartNumber=${api_TIEOSANUMERO}     track=${api_AJORATA}     startAddrMValue=${api_ALKUETÄISYYS}     endAddrMValue=2423     laneCode=11     laneType=1
    Log  ${api_lista_}

     FOR    ${key}    IN    ${lanes_in_municipality_json}
        ${API_lanes_in_municipality_check_json_loop}=    Run Keyword and Return Status    Dictionary Should Contain Key    ${api_lista_}    ${item}
        Continue For Loop If    '${API_lanes_in_municipality_check_json_loop}'=='False'
    END

*** Variables ***
${API_URI_lanes_in_municipality}      /externalApi/lanes/lanes_in_municipality
&{headers}=                           X-Api-Key=${API_autentikointi}    accept=application/json
${Kaista_kunta_api_url}               https://api.testivaylapilvi.fi/digiroad/externalApi/lanes/lanes_in_municipality?municipality\=235
${api_tienumero}                      xpath=//*[@id="feature-attributes-form"]/div[2]/div/div[3]/div/div[2]/p
${api_tuloste}                        ./apituloste.json

${kaista_api_bbox}  bbox=373079,6678545,373457,6678642