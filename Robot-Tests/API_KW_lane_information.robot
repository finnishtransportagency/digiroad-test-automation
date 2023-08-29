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
Kaista_tieto_get    [Arguments]    ${testipaikka}    ${information_api_tienumero}
    [Documentation]    Find given values from response. 
    ...
    Login To DigiRoad
    Log  Vaihdetaan experimetal osoitteseen ja siirrytään testipaikkaan.
    vaihda tietolaji                            ${TL_Kaistan_mallinnustyökalu_RB}
    Paikanna osoite                             ${testipaikka}
    Zoomaa kartta                               5  50 m
    
    Click Element At Coordinates                ${Kartta}  0  20
    Wait Until Element Is Visible               ${FA_otsikko}
    Siirry Muokkaustilaan
    Wait Until Element Is Not Visible           ${Map_popup}
    
    ${kaista_loppuPVM} =    Get Current Date    result_format=%d.%m.%Y
    ${kaista_loppuPVM} =    Convert Date             ${kaista_loppuPVM}    date_format=%d.%m.%Y    result_format=%d.%m.%Y
    ${kaista_alkuPVM}=    Subtract Time From Date    ${kaista_loppuPVM}    1 day    date_format=%d.%m.%Y    result_format=%d.%m.%Y
    Click Element                               ${FA_Lisää_kaista_oikealle}
    Input Text                                  ${KT_Alkupäivämäärä}    ${kaista_alkuPVM}
    Press Keys                                  ${KT_Alkupäivämäärä}    RETURN
    Click Element                               ${FA_Lisää_kaista_vasemmalle}
    Input Text                                  ${KT_Alkupäivämäärä}    ${kaista_alkuPVM}
    Press Keys                                  ${KT_Alkupäivämäärä}    RETURN

    Log  Talletetaan ja päätetään kaistat
    Click Element                               ${FA_footer_Tallenna}
    Wait Until Element Is Not Visible           ${Map_popup}
    Click Element                               ${Muokkausvaroitus_Kyllä_btn}
    Wait Until Element Is Not Visible           ${Spinner_Overlay}
    Odota sivun latautuminen
    Sleep    60s    #annetaan muutoksille aikaa tallentua
    Close Browser

    #GET-pyyntö: tutkitaan ovatko tehdyt muutokset rajapinnassa nähtävissä
    TRY
    Log    GET-pyyntö    console=yes
    Init Session
    ${end_date} =    Get Current Date    time_zone=local
    ${end_date} =    Convert Date    ${end_date}    result_format=%Y-%m-%dT%H:%M:%SZ
    ${start_date} =    Subtract Time From Date    ${end_date}    24 hours    #oltava mikä vain arvo ennen end_date:a klo 00:00 UTC+0
    ${start_date} =    Convert Date    ${start_date}    result_format=%Y-%m-%dT%H:%M:%SZ
    ${start_date_comparable}=    Convert Date    ${start_date}    result_format=%d.%m.%Y
    ${Kaista_tieto_api_url_blank}=    Set Variable    https://api.testivaylapilvi.fi/digiroad/externalApi/changes/lane_information?since=${start_date}&until=${end_date}&withAdjust=0

    ${response}=    GET    ${Kaista_tieto_api_url_blank}    headers=${headers}
    Log    ${response.content}    console=yes
    Request Should Be Successful    ${response}
    ${lane_information_json}=    Evaluate    json.loads('''${response.content}''')    json

    #Käydään JSON läpi feature-itemeittäin
    FOR    ${item}    IN    @{lane_information_json['features']}
        ${item_roadnumber}=         Set variable    ${item["roadNumber"]}
        ${item_modified_by}=        Set Variable    ${item["changedBy"]}
        ${item_startdate}=          Set variable    ${item["startDate"]}

        ${item_roadnumber}=          Convert To Integer    ${item_roadnumber}

        ${tarkista_muokkaaja}=    Run Keyword And Return Status    Should Be Equal    ${item_modified_by}    ${LiviUSER}
        IF    '${tarkista_muokkaaja}' == 'False'    CONTINUE
        IF    '${tarkista_muokkaaja}' == 'True'    Log    Link modified by ${item_modified_by} starting from ${start_date} found    console=yes

        #${tarkista_pvm}=    Should Be Equal    ${item_startdate}    ${start_date_comparable}
        #IF    '${tarkista_pvm}' == 'True'    
        #    Log    Date ${item_startdate} matches    console=yes
        #ELSE
            Continue For Loop
    END
    #END

    FINALLY
    #Lisättyjen kaistojen poisto
    Log    Kaistojen poisto    console=yes
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
    
    #Element Should Contain                      ${KT_Kaista}  2
    Click Element                               ${KT_Päätä_Lisakaista}
    Click Element                               ${Muokkausvaroitus_Kyllä_btn}

    Valitse Kaista                              2
    #Element Should Contain                      ${KT_Kaista}  3
    Click Element                               ${KT_Päätä_Lisakaista}
    Click Element                               ${Muokkausvaroitus_Kyllä_btn}

    Click Element                               ${FA_footer_Tallenna}
    Wait Until Element Is Not Visible           ${Map_popup}
    Click Element                               ${Muokkausvaroitus_Kyllä_btn}
    #Wait Until Element Is Not Visible           ${Spinner_Overlay}
    Sleep    10    #käytetään sleepiä ehdon sijaan ^
    TRY
        Odota sivun latautuminen
    EXCEPT    Virhe kaistojen poistossa
        Odota sivun latautuminen
    END
    Close All Browsers
    END

*** Variables ***
${API_URI_lane_information}               /externalApi/changes/lane_information
&{headers}=                               X-Api-Key=${API_autentikointi}    accept=application/json