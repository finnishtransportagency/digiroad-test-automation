#       Joni Laari        Sitowise        2024

*** Settings ***
Documentation       Keywords for railroad maintenance roads (Rautateiden huoltotiet)
Library             SeleniumLibrary
Resource            common_keywords.robot


*** Keywords ***
Rautateiden Huoltotien Tarkastelu Käyttöoikeus
    [arguments]    ${testipaikka}    ${rautatien_huoltotiet_radionappi}
    Testin Aloitus
    Log    Tarkastellaan rautateiden huoltotien ilmestyminen zoomatessa
    Vaihda Tietolaji    ${TL_Rautateiden_huoltotie_RB}
    Radio Button Should Be Set To    labelingRadioButton    rightOfUse
    Paikanna osoite    ${testipaikka}
    Zoomaa kartta    2    200
    Odota Sivun Latautuminen
    Click Center Of The Map And Wait For Locator     ${FA_otsikko}
    Element Should Be Visible    ${FA_Lisätty_Järjestelmään}
    Element Should Be Visible    ${FA_Muokattu_viimeksi}
    Element Should Be Visible    ${Rautatien_huoltotie_tarkastelu_boolean}
    Element Should Contain    ${Rautatien_huoltotie_tarkastelu_boolean}    on
    Element Should Be Visible    ${huoltotie_käyttöoikeus}
    Element Should Be Visible    ${huoltotie_huoltovastuu}
    Element Should Be Visible    ${huoltotie_tiehoitokunta}
    Element Should Be Visible    ${huoltotie_tarkistettu}
    Click Element At Coordinates    ${Kartta}    200    0
    Odota Sivun Latautuminen
    Tuplaklikkaa Kartan Keskella Ja Odota Lokaattori    ${FA_otsikko}
    Element Should Be Visible    ${FA_Lisätty_Järjestelmään}
    Element Should Be Visible    ${FA_Muokattu_viimeksi}
    Element Should Be Visible    ${Rautatien_huoltotie_tarkastelu_boolean}
    Element Should Contain    ${Rautatien_huoltotie_tarkastelu_boolean}    on
    Click Element At Coordinates    ${Kartta}    200    0
    Odota sivun latautuminen


Rautateiden Huoltotien Tarkastelu Huoltovastuu
    [arguments]    ${testipaikka}    ${rautatien_huoltotiet_radionappi}
    Testin Aloitus
    Log    Tarkastellaan rautateiden huoltotien ilmestyminen zoomatessa
    Vaihda Tietolaji    ${TL_Rautateiden_huoltotie_RB}
    Radio Button Should Be Set To    labelingRadioButton    responsibility
    Paikanna Osoite    ${testipaikka}
    Zoomaa kartta    2    200
    Odota Sivun Latautuminen
    Click Center Of The Map And Wait For Locator     ${FA_otsikko}
    Element Should Be Visible    ${FA_Lisätty_Järjestelmään}
    Element Should Be Visible    ${FA_Muokattu_viimeksi}
    Element Should Be Visible    ${Rautatien_huoltotie_tarkastelu_boolean}
    Element Should Contain    ${Rautatien_huoltotie_tarkastelu_boolean}    on
    Element Should Be Visible    ${huoltotie_käyttöoikeus}
    Element Should Be Visible    ${huoltotie_huoltovastuu}
    Element Should Be Visible    ${huoltotie_tiehoitokunta}
    Element Should Be Visible    ${huoltotie_tarkistettu}
    Click Element At Coordinates      ${Kartta}    200    0
    Odota sivun latautuminen
    Tuplaklikkaa Kartan Keskella Ja Odota Lokaattori    ${FA_otsikko}
    Element Should Be Visible    ${FA_Lisätty_Järjestelmään}
    Element Should Be Visible    ${FA_Muokattu_viimeksi}
    Element Should Be Visible    ${Rautatien_huoltotie_tarkastelu_boolean}
    Element Should Contain    ${Rautatien_huoltotie_tarkastelu_boolean}    on
    Click Element At Coordinates    ${Kartta}    200    0
    Odota Sivun Latautuminen


Rautateiden Huoltotien Muokkaus Koko Ketjulle
    [Arguments]    ${testipaikka}    ${j}
    Log    Muokataan rautatien huoltotietä koko ketjulle
    Testin Aloitus
    Vaihda Tietolaji    ${TL_Rautateiden_huoltotie_RB}
    Paikanna Osoite    ${testipaikka}
    Zoomaa Kartta    2    200
    Odota Sivun Latautuminen
    Click Center Of The Map And Wait For Locator     ${FA_otsikko}
    Element Should Be Visible    ${FA_Lisätty_Järjestelmään}
    Element Should Be Visible    ${FA_Muokattu_viimeksi}
    Element Should Be Visible    ${Rautatien_huoltotie_tarkastelu_boolean}
    Element Should Contain    ${Rautatien_huoltotie_tarkastelu_boolean}    on
    Siirry Muokkaustilaan
    Select Radio Button    maintenanceRoad    enabled
    Radio Button Should Be Set To    maintenanceRoad    enabled
    Click Element    ${huoltotie_käyttöoikeus_pudotusvalikko}
    FOR    ${j}    IN    @{Huoltotie_käyttöoikeus_kohteet}
        Log    ${j}
        Press Keys    None    ARROW_DOWN
        Element Should Contain    ${huoltotie_käyttöoikeus_pudotusvalikko}    ${j}
        Press Keys    None    ENTER
    END
    Element Should Be Enabled    ${FA_footer_Peruuta}
    Tallenna Muutokset
    # Click Element                ${FA_footer_Tallenna}
    Set Test Variable    ${MUOKKAUSTILA_AKTIVOITU}    False
    Odota Sivun Latautuminen


Rautateiden Huoltotien Muokkaus Ketjun Osalle    [arguments]    ${testipaikka}    ${k}
    Log    Muokataan rautatien huoltotietä ketjun osalle
    Testin Aloitus
    Vaihda Tietolaji    ${TL_Rautateiden_huoltotie_RB}
    Paikanna osoite    ${testipaikka}
    Zoomaa kartta    2    200
    Odota sivun latautuminen
    Tuplaklikkaa Kartan Keskella Ja Odota Lokaattori    ${FA_otsikko}
    #Tupla Klikkaa Kartan Keskelle
    #Wait Until Element Is Visible     ${FA_otsikko}
    Element Should Be Visible    ${FA_Lisätty_Järjestelmään}
    Element Should Be Visible    ${FA_Muokattu_viimeksi}
    Element Should Be Visible    ${Rautatien_huoltotie_tarkastelu_boolean}
    Element Should Contain       ${Rautatien_huoltotie_tarkastelu_boolean}    on
    Siirry Muokkaustilaan
    Select Radio Button    maintenanceRoad     enabled
    Radio Button Should Be Set To    maintenanceRoad    enabled
    Click Element    ${huoltotie_käyttöoikeus_pudotusvalikko}
    FOR    ${k}    IN    @{Huoltotie_käyttöoikeus_kohteet}
        Log    ${k}
        Press Keys    None    ARROW_DOWN
        Element Should Contain    ${huoltotie_käyttöoikeus_pudotusvalikko}    ${k}
        Press Keys    None    ENTER
    END
    Element Should Be Enabled    ${FA_footer_Peruuta}
    Tallenna Muutokset
    Set Test Variable    ${MUOKKAUSTILA_AKTIVOITU}    False
    Odota sivun latautuminen


Rautateiden Huoltotien Lisääminen Usealle Laatikolla
    [arguments]    ${testipaikka}    ${l}    ${m}
    Log    Testataan usean linkin lisääminen laatikkovalinnalla
    Testin Aloitus
    Vaihda Tietolaji    ${TL_Rautateiden_huoltotie_RB}
    Paikanna Osoite    ${testipaikka}
    Zoomaa Kartta    5   50 m
    Odota Sivun Latautuminen
    Siirry Muokkaustilaan
    Wait Until Element Is Not Visible    ${Map_popup}
    Log    Tarkistetaan laatikkotyökalu
    Wait Until Element Is Visible    ${Muokkaustila_Laatikko}
    Click Element    ${Muokkaustila_Laatikko}
    Suorita laatikkovalinta
    Wait Until Element Is Visible    css=.modal-dialog
    Radio Button Should Be Set To    maintenanceRoad    disabled
    Select Radio Button    maintenanceRoad    enabled
    Radio Button Should Be Set To    maintenanceRoad    enabled
    Select From List By Value    name=huoltotie_kayttooikeus    ${l}
    Select From List By Value    name=huoltotie_huoltovastuu    ${m}
    Input Text    name=huoltotie_tiehoitokunta    dummypopup
    Click Button    name=huoltotie_tarkistettu-
    Element Should Be Enabled    ${FA_header_Tallenna}
    Click Element    ${FA_header_Peruuta}
    Odota sivun latautuminen


Rautateiden Huoltotien Lisääminen Usealle Polygonilla
    [arguments]    ${testipaikka}    ${n}    ${m}
    Log    Testataan usean linkin lisääminen monivalinnalla
    Testin Aloitus
    Vaihda Tietolaji    ${TL_Rautateiden_huoltotie_RB}
    Paikanna Osoite    ${testipaikka}
    Zoomaa Kartta    5   50 m
    Odota Sivun Latautuminen
    Siirry Muokkaustilaan
    Wait Until Element Is Not Visible    ${Map_popup}
    Log    Tarkistetaan laatikkotyökalu
    Wait Until Element Is Visible    ${Muokkaustila_PolygonTool}
    Click Element    ${Muokkaustila_PolygonTool}
    Suorita Monivalinta
    Wait Until Element Is Visible    css=.modal-dialog
    Radio Button Should Be Set To    maintenanceRoad    disabled
    Select Radio Button    maintenanceRoad    enabled
    Radio Button Should Be Set To    maintenanceRoad    enabled
    Select From List By Value    name=huoltotie_kayttooikeus    ${n}
    Select From List By Value    name=huoltotie_huoltovastuu    ${m}
    Input Text    name=huoltotie_tiehoitokunta    dummypopup
    Click Button    name=huoltotie_tarkistettu-
    Element Should Be Enabled    ${FA_header_Tallenna}
    Click Element    ${FA_header_Peruuta}
    Odota sivun latautuminen


Rautateiden Huoltotien Lisääminen Usealle Ctrl
    [Arguments]    ${testipaikka}    ${p}    ${q}
    Log    Testataan usean linkin lisääminen ctrl-valinnalla
    # testattava sijainnilla, jossa on suoraan pohjois-etelä-suunnassa kulkeva linkki
    Testin Aloitus
    Log    Usean rautatien huoltotietiedon lisäämistapojen testaaminen
    Vaihda Tietolaji    ${TL_Rautateiden_huoltotie_RB}
    Paikanna Osoite    ${testipaikka}
    Zoomaa Kartta    5  20 m
    Odota Sivun Latautuminen
    Siirry Muokkaustilaan
    Wait Until Element Is Not Visible    ${Map_popup}
    # painetaan control pohjaan ja klikataan
    Hold Control And Click Element At Coordinates    ${Kartta}    0    0
    selenium_extensions.Hold Control And Drag By Offset    ${Kartta}    0    100
    Click Element At Coordinates    ${Kartta}    0    0
    selenium_extensions.Hold Control And Drag By Offset    ${Kartta}    0    -200
    Click Element At Coordinates    ${Kartta}    0    0
    Release Control
    Wait Until Element Is Visible    css=.modal-dialog
    Radio Button Should Be Set To    maintenanceRoad    disabled
    Select Radio Button    maintenanceRoad    enabled
    Radio Button Should Be Set To    maintenanceRoad    enabled
    Select From List By Value    name=huoltotie_kayttooikeus    ${p}
    Select From List By Value    name=huoltotie_huoltovastuu    ${q}
    Input Text    name=huoltotie_tiehoitokunta    dummypopup
    Click Button    name=huoltotie_tarkistettu-
    Element Should Be Enabled                   ${FA_header_Tallenna}
    Click Element                               ${FA_header_Peruuta}
    Odota sivun latautuminen


Rautateiden Huoltotien Katkaisu
    [Arguments]    ${testipaikka}    ${r}    ${s}
    Testin Aloitus
    Log    Testataan rautateiden huoltotien katkaisu
    Vaihda Tietolaji    ${TL_Rautateiden_huoltotie_RB}
    Paikanna Osoite    ${testipaikka}
    Zoomaa Kartta    5    100m
    Odota Sivun Latautuminen
    Siirry Muokkaustilaan
    Log    Leikataan tielinkki kahteen osaan
    Wait Until Element Is Visible    ${Muokkaustila_Leikkaus}
    Click Element    ${Muokkaustila_Leikkaus}
    Odota Sivun Latautuminen
    Click Element At Coordinates               ${Kartta}  0  10
    Odota Sivun Latautuminen
    #katkaistu linkki a
    Click Element
    ...    css=#feature-attributes-form > div > div > div.dynamic-form.editable.form-editable-maintenanceRoad-a > div.input-unit-combination > div:nth-child(1) > select
    Select From List By Value    name=huoltotie_kayttooikeus    ${r}
    Select From List By Value    name=huoltotie_huoltovastuu    ${s}
    Press Keys    none    ENTER
    Click Button    name=huoltotie_tarkistettu-a
    Input Text    name=huoltotie_tiehoitokunta    dummy-a
    #katkaistu linkki b
    Click Element
    ...    css=#feature-attributes-form > div > div > div.dynamic-form.editable.form-editable-maintenanceRoad-a > div.input-unit-combination > div:nth-child(2) > select
    Select From List By Value    name=huoltotie_kayttooikeus    ${r}
    Select From List By Value    name=huoltotie_huoltovastuu    ${s}
    Press Keys    none    ENTER
    Click Button    name=huoltotie_tarkistettu-b
    Input Text    name=huoltotie_tiehoitokunta    dummy-b
    Element Should Be Enabled    ${FA_footer_Tallenna}
    Click Element    ${FA_footer_Peruuta}
    Odota Sivun Latautuminen


*** Variables ***
# Need to find better locators to these.
${Rautatien_huoltotie_tarkastelu_boolean}
...    css=#feature-attributes-form > div > div > div.dynamic-form.editable.form-editable-maintenanceRoad > p
${huoltotie_käyttöoikeus}
...    css=#feature-attributes-form > div > div > div.dynamic-form.editable.form-editable-maintenanceRoad > div.input-unit-combination > div:nth-child(1) > p
${huoltotie_huoltovastuu}
...    css=#feature-attributes-form > div > div > div.dynamic-form.editable.form-editable-maintenanceRoad > div.input-unit-combination > div:nth-child(2) > p
${huoltotie_tiehoitokunta}
...    css=#feature-attributes-form > div > div > div.dynamic-form.editable.form-editable-maintenanceRoad > div.input-unit-combination > div:nth-child(3) > p
${huoltotie_tarkistettu}
...    css=#feature-attributes-form > div > div > div.dynamic-form.editable.form-editable-maintenanceRoad > div.input-unit-combination > div:nth-child(4) > p
${huoltotie_käyttöoikeus_pudotusvalikko}
...    css=#feature-attributes-form > div > div > div.dynamic-form.editable.form-editable-maintenanceRoad > div.input-unit-combination > div:nth-child(1) > select