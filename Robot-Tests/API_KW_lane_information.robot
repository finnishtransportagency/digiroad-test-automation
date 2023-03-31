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
Kaista_tieto_get    [Arguments]    ${testipaikka}
    [Documentation]    Find given values from response. 
    ...    This is a negative test, where all changes from a given municipality are searched for values given as parameters. Unlike ordinary tests, "failure" is a default outcome of sort.
    Login To DigiRoad
    Log  Vaihdetaan experimetal osoitteseen ja siirrytään testipaikkaan.
    vaihda tietolaji                            ${TL_Kaistan_mallinnustyökalu_RB}
    Paikanna osoite                             ${testipaikka}
    Zoomaa kartta                               5  50 m
    
    Click Element At Coordinates                ${Kartta}  0  20
    Wait Until Element Is Visible               ${FA_otsikko}
    Siirry Muokkaustilaan
    Wait Until Element Is Not Visible           ${Map_popup}
    
    #Poista Ylimääräiset Kaistat
    
    ${kaista_PVM} =    Get Current Date
    #${kaista_PVM} =    Subtract Time From Date    ${kaista_PVM}    24 hours
    ${kaista_PVM} =    Convert Date             ${kaista_PVM}    result_format=%d.%m.%Y
    Click Element                               ${FA_Lisää_kaista_oikealle}
    Input Text                                  ${KT_Alkupäivämäärä}    ${kaista_PVM}
    Press Keys                                  ${KT_Alkupäivämäärä}    RETURN
    Click Element                               ${FA_Lisää_kaista_vasemmalle}
    Input Text                                  ${KT_Alkupäivämäärä}    ${kaista_PVM}
    Press Keys                                  ${KT_Alkupäivämäärä}    RETURN

    Log  Talletetaan ja päätetään kaistat
    Click Element                               ${FA_footer_Tallenna}
    Wait Until Element Is Not Visible           ${Map_popup}
    Click Element                               ${Muokkausvaroitus_Kyllä_btn}
    Wait Until Element Is Not Visible           ${Spinner_Overlay}
    Odota sivun latautuminen
    Sleep    60s

    #GET-pyyntö
    Log    GET-pyyntö    console=yes
    Init Session
    ${end_date} =    Get Current Date
    ${end_date} =    Convert Date    ${end_date}    result_format=%Y-%m-%dT%H:%M:%SZ
    ${start_date} =    Subtract Time From Date    ${end_date}    60 minutes
    ${start_date} =    Convert Date    ${start_date}    result_format=%Y-%m-%dT%H:%M:%SZ
    ${Kaista_tieto_api_url_blank}=    Set Variable    https://api.testivaylapilvi.fi/digiroad/externalApi/changes/lane_information?since=${start_date}&until=${end_date}
    ${response}=    GET  ${Kaista_tieto_api_url_blank}  headers=${headers}
    Log    ${response.content}    console=yes
    Request Should Be Successful    ${response}

    Login To DigiRoad
    Log  Vaihdetaan experimetal osoitteseen ja siirrytään testipaikkaan.
    vaihda tietolaji                            ${TL_Kaistan_mallinnustyökalu_RB}
    Paikanna osoite                             ${testipaikka}
    Zoomaa kartta                               5  50 m
    Siirry Muokkaustilaan
    Odota sivun latautuminen
    Click Element at Coordinates                ${Kartta}  0  20
    Wait Until Element Is Visible               ${FA_otsikko}
    Valitse Kaista                              1
    
    Element Should Contain                      ${KT_Kaista}  2
    
    Click Element                               ${KT_Päätä_Lisakaista}
    Click Element                               ${Muokkausvaroitus_Kyllä_btn}

    Valitse Kaista                              2
    Element Should Contain                      ${KT_Kaista}  3
    Click Element                               ${KT_Päätä_Lisakaista}
    Click Element                               ${Muokkausvaroitus_Kyllä_btn}

    Click Element                               ${FA_footer_Tallenna}
    Wait Until Element Is Not Visible           ${Map_popup}
    Click Element                               ${Muokkausvaroitus_Kyllä_btn}
    Wait Until Element Is Not Visible           ${Spinner_Overlay}
    Odota sivun latautuminen
    Close All Browsers

*** Variables ***
${API_URI_lane_information}               /externalApi/changes/lane_information
&{headers}=                               X-Api-Key=${API_autentikointi}    accept=application/json