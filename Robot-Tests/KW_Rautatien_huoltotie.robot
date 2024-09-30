#       Joni Laari        Sitowise        2024

*** Settings ***
Documentation       Keywords for railroad maintenance roads (Rautateiden huoltotiet)
Library             SeleniumLibrary
Resource            common_keywords.robot


*** Keywords ***
Rautateiden huoltotien tarkastelu käyttöoikeus     [arguments]    ${testipaikka}    ${rautatien_huoltotiet_radionappi}
    Testin Aloitus
    Log    Tarkastellaan rautateiden huoltotien ilmestyminen zoomatessa
    Vaihda Tietolaji    ${TL_Rautateiden_huoltotie_RB}
    Radio Button Should Be Set To    labelingRadioButton    rightOfUse
    Paikanna osoite    ${testipaikka}
    Zoomaa kartta    2    200
    Odota sivun latautuminen

    Click Element At Coordinates      ${Kartta}    0    20
    Wait Until Element Is Visible     ${FA_otsikko}
    Element Should Be Visible         ${FA_Lisätty_Järjestelmään}
    Element Should Be Visible         ${FA_Muokattu_viimeksi}
    Element Should Be Visible         ${Rautatien_huoltotie_tarkastelu_boolean}
    Element Should Contain            ${Rautatien_huoltotie_tarkastelu_boolean}    on

    Element Should Be Visible         ${huoltotie_käyttöoikeus}
    Element Should Be Visible         ${huoltotie_huoltovastuu}
    Element Should Be Visible         ${huoltotie_tiehoitokunta}
    Element Should Be Visible         ${huoltotie_tarkistettu}

    Click Element At Coordinates      ${Kartta}    200    0
    Odota sivun latautuminen
    Tupla Klikkaa Kartan Keskelle
    Wait Until Element Is Visible     ${FA_otsikko}
    Element Should Be Visible         ${FA_Lisätty_Järjestelmään}
    Element Should Be Visible         ${FA_Muokattu_viimeksi}
    Element Should Be Visible         ${Rautatien_huoltotie_tarkastelu_boolean}
    Element Should Contain            ${Rautatien_huoltotie_tarkastelu_boolean}    on
    Click Element At Coordinates      ${Kartta}    200    0
    Odota sivun latautuminen


Rautateiden huoltotien tarkastelu huoltovastuu     [arguments]    ${testipaikka}    ${rautatien_huoltotiet_radionappi}
    Testin Aloitus
    Log    Tarkastellaan rautateiden huoltotien ilmestyminen zoomatessa
    Vaihda Tietolaji    ${TL_Rautateiden_huoltotie_RB}
    Radio Button Should Be Set To    labelingRadioButton    rightOfUse
    Paikanna osoite    ${testipaikka}
    Zoomaa kartta    2    200
    Odota sivun latautuminen

    Click Element At Coordinates      ${Kartta}    0    20
    Wait Until Element Is Visible     ${FA_otsikko}
    Element Should Be Visible         ${FA_Lisätty_Järjestelmään}
    Element Should Be Visible         ${FA_Muokattu_viimeksi}
    Element Should Be Visible         ${Rautatien_huoltotie_tarkastelu_boolean}
    Element Should Contain            ${Rautatien_huoltotie_tarkastelu_boolean}    on

    Element Should Be Visible         ${huoltotie_käyttöoikeus}
    Element Should Be Visible         ${huoltotie_huoltovastuu}
    Element Should Be Visible         ${huoltotie_tiehoitokunta}
    Element Should Be Visible         ${huoltotie_tarkistettu}

    Click Element At Coordinates      ${Kartta}    200    0
    Odota sivun latautuminen
    Tupla Klikkaa Kartan Keskelle
    Wait Until Element Is Visible     ${FA_otsikko}
    Element Should Be Visible         ${FA_Lisätty_Järjestelmään}
    Element Should Be Visible         ${FA_Muokattu_viimeksi}
    Element Should Be Visible         ${Rautatien_huoltotie_tarkastelu_boolean}
    Element Should Contain            ${Rautatien_huoltotie_tarkastelu_boolean}    on
    Click Element At Coordinates      ${Kartta}    200    0
    Odota sivun latautuminen


Rautateiden huoltotien muokkaus koko ketjulle    [arguments]    ${testipaikka}    ${j}
    Log    Muokataan rautatien huoltotietä koko ketjulle
    Testin Aloitus
    Vaihda Tietolaji    ${TL_Rautateiden_huoltotie_RB}
    Paikanna osoite    ${testipaikka}
    Zoomaa kartta    2    200
    Odota sivun latautuminen

    Click Element At Coordinates      ${Kartta}    0    20
    Wait Until Element Is Visible     ${FA_otsikko}
    Element Should Be Visible         ${FA_Lisätty_Järjestelmään}
    Element Should Be Visible         ${FA_Muokattu_viimeksi}
    Element Should Be Visible         ${Rautatien_huoltotie_tarkastelu_boolean}
    Element Should Contain            ${Rautatien_huoltotie_tarkastelu_boolean}    on
    Siirry Muokkaustilaan

    Select Radio Button               maintenanceRoad   enabled
    Radio Button Should Be Set To     maintenanceRoad   enabled
    Click Element    css=#feature-attributes-form > div > div > div.dynamic-form.editable.form-editable-maintenanceRoad > div.input-unit-combination > div:nth-child(1) > select

    FOR    ${j}    IN    @{Huoltotie_käyttöoikeus_kohteet}
        Log    ${j}
        Press Keys    None    ARROW_DOWN
        Element Should Contain    css=#feature-attributes-form > div > div > div.dynamic-form.editable.form-editable-maintenanceRoad > div.input-unit-combination > div:nth-child(1) > select    ${j}
        Press Keys    None    ENTER
    END

    Element Should Be Enabled    ${FA_footer_Peruuta}
    Click Element                ${FA_footer_Tallenna}


Rautateiden huoltotien muokkaus ketjun osalle    [arguments]    ${testipaikka}    ${j}
    Log    Muokataan rautatien huoltotietä ketjun osalle
    Testin Aloitus
    Vaihda Tietolaji    ${TL_Rautateiden_huoltotie_RB}
    Paikanna osoite    ${testipaikka}
    Zoomaa kartta    2    200
    Odota sivun latautuminen

    Click Element At Coordinates      ${Kartta}    0    20
    Wait Until Element Is Visible     ${FA_otsikko}
    Element Should Be Visible         ${FA_Lisätty_Järjestelmään}
    Element Should Be Visible         ${FA_Muokattu_viimeksi}
    Element Should Be Visible         ${Rautatien_huoltotie_tarkastelu_boolean}
    Element Should Contain            ${Rautatien_huoltotie_tarkastelu_boolean}    on
    Siirry Muokkaustilaan

    Select Radio Button               maintenanceRoad   enabled
    Radio Button Should Be Set To     maintenanceRoad   enabled
    Click Element    css=#feature-attributes-form > div > div > div.dynamic-form.editable.form-editable-maintenanceRoad > div.input-unit-combination > div:nth-child(1) > select
    Click Element    css=#feature-attributes-form > div > div > div.dynamic-form.editable.form-editable-maintenanceRoad > div.input-unit-combination > div:nth-child(1) > select

    FOR    ${j}    IN    @{Huoltotie_käyttöoikeus_kohteet}
        Log    ${j}
        Press Keys    None    ARROW_DOWN
        Element Should Contain    css=#feature-attributes-form > div > div > div.dynamic-form.editable.form-editable-maintenanceRoad > div.input-unit-combination > div:nth-child(1) > select    ${j}
        Press Keys    None    ENTER
    END

    Element Should Be Enabled    ${FA_footer_Peruuta}
    Click Element                ${FA_footer_Tallenna}


Rautateiden huoltotien lisääminen usealle laatikolla    [arguments]    ${testipaikka}
    Log    Testataan usean linkin lisääminen laatikkovalinnalla
    Testin Aloitus
    Vaihda Tietolaji    ${TL_Rautateiden_huoltotie_RB}
    Paikanna osoite                             ${testipaikka}
    Zoomaa kartta                               5   50 m
    Odota sivun latautuminen
    Siirry Muokkaustilaan
    Wait Until Element Is Not Visible           ${Map_popup}
    Log    Tarkistetaan laatikkotyökalu
    Wait Until Element Is Visible               ${Muokkaustila_Laatikko}
    Click Element                               ${Muokkaustila_Laatikko}
    Suorita laatikkovalinta
    Wait Until Element Is Visible               css=.modal-dialog
    Radio Button Should Be Set To               maintenanceRoad    disabled
    Select Radio Button                         maintenanceRoad    enabled
    Radio Button Should Be Set To               maintenanceRoad    enabled

    Element Should Be Enabled                   ${FA_header_Tallenna}
    Click Element                               ${FA_header_Peruuta}
    Odota sivun latautuminen
    Siirry Katselutilaan


Rautateiden huoltotien lisääminen usealle polygonilla    [arguments]    ${testipaikka}
    Log    Testataan usean linkin lisääminen laatikkovalinnalla
    Testin Aloitus
    Vaihda Tietolaji    ${TL_Rautateiden_huoltotie_RB}
    Paikanna osoite                             ${testipaikka}
    Zoomaa kartta                               5   50 m
    Odota sivun latautuminen
    Siirry Muokkaustilaan
    Wait Until Element Is Not Visible           ${Map_popup}
    Log    Tarkistetaan laatikkotyökalu
    Wait Until Element Is Visible               ${Muokkaustila_PolygonTool}
    Click Element                               ${Muokkaustila_PolygonTool}
    Suorita monivalinta
    Wait Until Element Is Visible               css=.modal-dialog
    Radio Button Should Be Set To               maintenanceRoad    disabled
    Select Radio Button                         maintenanceRoad    enabled
    Radio Button Should Be Set To               maintenanceRoad    enabled

    Element Should Be Enabled                   ${FA_header_Tallenna}
    Click Element                               ${FA_header_Peruuta}
    Odota sivun latautuminen
    Siirry Katselutilaan


*** Variables ***
${Rautatien_huoltotie_tarkastelu_boolean}    css=#feature-attributes-form > div > div > div.dynamic-form.editable.form-editable-maintenanceRoad > p
${huoltotie_käyttöoikeus}    css=#feature-attributes-form > div > div > div.dynamic-form.editable.form-editable-maintenanceRoad > div.input-unit-combination > div:nth-child(1) > p
${huoltotie_huoltovastuu}    css=#feature-attributes-form > div > div > div.dynamic-form.editable.form-editable-maintenanceRoad > div.input-unit-combination > div:nth-child(2) > p
${huoltotie_tiehoitokunta}    css=#feature-attributes-form > div > div > div.dynamic-form.editable.form-editable-maintenanceRoad > div.input-unit-combination > div:nth-child(3) > p
${huoltotie_tarkistettu}    css=#feature-attributes-form > div > div > div.dynamic-form.editable.form-editable-maintenanceRoad > div.input-unit-combination > div:nth-child(4) > p
${k}    0