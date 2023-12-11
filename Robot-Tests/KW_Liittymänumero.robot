#    Joni Laari        Sitowise        2023

*** Settings ***
Documentation       Keywords for exit number (Liittymänumero)
Library             SeleniumLibrary
Resource            common_keywords.robot


*** Keywords ***
Liittymänumeron tarkastelu    [arguments]    ${testipaikka}
    Testin Aloitus
    Log                                         Testataan liittymänumeron tarkastelu
    Vaihda Tietolaji                            ${TL_Liittymänumero_RB}
    Paikanna osoite                             ${testipaikka}
    Zoomaa kartta                               2    50
    Odota sivun latautuminen

    Click Element At Coordinates                ${Kartta}    0    20
    Wait Until Element Is Visible               ${FA_header_Liittymänumero_otsikko}
    Element Should Be Enabled                   ${FA_Lisätty_Järjestelmään}
    Element Should Be Visible                   ${FA_Muokattu_viimeksi}
    Element Should Be Visible                   ${FA_Linkkien_lkm}
    Element Should Contain                      ${Liittymänumero_header_arvo}    45

    #tuplaklikkauksella linkin osa näkyviin
    Testin Aloitus
    Vaihda Tietolaji                            ${TL_Liittymänumero_RB}
    Paikanna osoite                             ${testipaikka}
    Zoomaa kartta                               2    50
    Odota sivun latautuminen

    Tupla Klikkaa Kartan Keskelle
    Wait Until Element Is Visible               ${FA_header_Liittymänumero_otsikko}
    Element Should Be Enabled                   ${FA_Lisätty_Järjestelmään}
    Element Should Be Visible                   ${FA_Muokattu_viimeksi}
    Element Should Be Visible                   ${FA_Linkkien_lkm}
    Element Should Contain                      ${Liittymänumero_header_arvo}    45


Liittymänumeron lisääminen    [arguments]    ${testipaikka}
    Testin Aloitus
    Log                                         Tarkistetaan liittymänumeron lisäys
    Vaihda Tietolaji                            ${TL_Liittymänumero_RB}
    Paikanna osoite                             ${testipaikka}
    Zoomaa kartta                               5    50
    Siirry Muokkaustilaan
    Odota sivun latautuminen

    Click Element At Coordinates                ${Kartta}    0    20
    Wait Until Element Is Visible               ${FA_header_Liittymänumero_otsikko}
    Element Should Be Enabled                   ${Liittymänumero_näkymä_radionappi_group}
    Select Radio Button                         exit-number    enabled
    Radio Button Should Be Set To               exit-number    enabled

    Input Text                                  ${Liittymänumero_input_kenttä_header}    100    #integer
    Element Should Be Enabled                   ${FA_header_Tallenna}
    Clear Element Text                          ${Liittymänumero_input_kenttä_header}


Liittymänumeron virheellinen lisääminen        [arguments]    ${testipaikka}
    Testin Aloitus
    Log                                         Tarkistetaan virheellisen liittymänumeron lisäys
    Vaihda Tietolaji                            ${TL_Liittymänumero_RB}
    Paikanna osoite                             ${testipaikka}
    Zoomaa kartta                               5    50
    Siirry Muokkaustilaan
    Odota sivun latautuminen

    Click Element At Coordinates                ${Kartta}    0    20
    Wait Until Element Is Visible               ${FA_header_Liittymänumero_otsikko}
    Element Should Be Disabled                  ${Liittymänumero_input_kenttä_header}
    Select Radio Button                         exit-number    enabled
    Radio Button Should Be Set To               exit-number    enabled

    #lisätään virheellisiä tietomuotoja
    Input Text                                  ${Liittymänumero_input_kenttä_header}    -99    #negative
    Element Should Be Disabled                  ${FA_header_Tallenna}
    Clear Element Text                          ${Liittymänumero_input_kenttä_header}

    Input Text                                  ${Liittymänumero_input_kenttä_header}    asd    #NaN
    Element Should Be Disabled                  ${FA_header_Tallenna}
    Clear Element Text                          ${Liittymänumero_input_kenttä_header}

    Input Text                                  ${Liittymänumero_input_kenttä_header}    99.99    #float
    Element Should Be Disabled                  ${FA_header_Tallenna}
    Clear Element Text                          ${Liittymänumero_input_kenttä_header}


Liittymänumeron lisääminen laatikko    [arguments]    ${testipaikka}
    Testin Aloitus
    Log                                         Tarkistetaan usean liittymänumeron lisäys laatikolla
    Vaihda Tietolaji                            ${TL_Liittymänumero_RB}
    Paikanna osoite                             ${testipaikka}
    Zoomaa kartta                               1    200
    Odota sivun latautuminen
    Siirry Muokkaustilaan
    Odota sivun latautuminen
    Wait Until Element Is Enabled               ${Muokkaustila_Laatikko}
    Click Element                               ${Muokkaustila_Laatikko}
    Suorita laatikkovalinta
    Wait Until Element Is Visible               ${Liittymänumero_popup_valikko}
    Element Should Be Visible                   ${Liittymänumero_popup_valikko}
    Select Radio Button                         exit-number    enabled
    Radio Button Should Be Set To               exit-number    enabled

    Input Text                                  ${Liittymänumero_popup_tekstikenttä}    500    #positiivinen kokonaisluku <1000

    Element Should Be Enabled                   ${FA_header_Tallenna}
    Element Should Be Enabled                   ${FA_header_Peruuta}
    Click Element                               ${FA_header_Peruuta}


Liittymänumeron lisääminen polygon    [arguments]    ${testipaikka}
    #testitapaus nro 5b
    Testin Aloitus
    Log                                         Tarkistetaan usean liittymänumeron lisäys polygonilla
    Vaihda Tietolaji                            ${TL_Liittymänumero_RB}
    Paikanna osoite                             ${testipaikka}
    Zoomaa kartta                               5    200
    Odota sivun latautuminen

    Siirry Muokkaustilaan
    Odota sivun latautuminen

    Wait Until Element Is Enabled               ${Muokkaustila_PolygonTool}
    Click Element                               ${Muokkaustila_PolygonTool}
    Suorita monivalinta
    Wait Until Element Is Visible               ${Liittymänumero_popup_valikko}
    Element Should Be Visible                   ${Liittymänumero_popup_valikko}
    Select Radio Button                         exit-number    enabled
    Radio Button Should Be Set To               exit-number    enabled

    Input Text                                  ${Liittymänumero_popup_tekstikenttä}    500    #positiivinen kokonaisluku <1000

    Element Should Be Enabled                   ${FA_header_Tallenna}
    Element Should Be Enabled                   ${FA_header_Peruuta}
    Click Element                               ${FA_header_Peruuta}


Liittymänumeron lisääminen ctrl    [arguments]        ${testipaikka_1}
    Testin Aloitus
    Log                                                       Tarkistetaan usean liittymänumeron lisäys ctrl-napilla
    Vaihda Tietolaji                                          ${TL_Liittymänumero_RB}
    Paikanna osoite                                           ${testipaikka_1}
    Zoomaa kartta                                             3    200
    Siirry Muokkaustilaan
    Odota sivun latautuminen
    Sleep    3

    #painetaan control pohjaan ja klikataan
    Hold Control And Click Element At Coordinates             ${Kartta}  0  0
    selenium_extensions.Hold Control And Drag By Offset       ${Kartta}  0  100
    Click Element At Coordinates                              ${Kartta}  0  0
    Release Control

    #lisätään tietoja
    Wait Until Element Is Visible                           ${Liittymänumero_popup_valikko}
    Element Should Be Visible                               ${Liittymänumero_popup_valikko}
    Select Radio Button                                     exit-number    enabled
    Radio Button Should Be Set To                           exit-number    enabled

    Input Text                                              ${Liittymänumero_popup_tekstikenttä}    500    #positiivinen kokonaisluku <1000

    Element Should Be Enabled                               ${FA_header_Tallenna}
    Element Should Be Enabled                               ${FA_header_Peruuta}
    Click Element                                           ${FA_header_Peruuta}


Liittymänumeron katkaisu    [arguments]    ${testipaikka}    ${liittymänumero_luku}
    Testin Aloitus
    Log                                               Tarkistetaan liittymänumeron katkaisu kahdeksi
    Vaihda Tietolaji                                  ${TL_Liittymänumero_RB}
    Paikanna osoite                                   ${testipaikka}
    Zoomaa kartta                                     5   50 m
    Odota sivun latautuminen
    Siirry Muokkaustilaan
    Wait Until Element Is Not Visible                 ${Map_popup}
    Wait Until Element Is Visible                     ${Muokkaustila_Leikkaus}
    Click Element                                     ${Muokkaustila_Leikkaus}
    Click Element At Coordinates                      ${Kartta}  0  20

    #tarkistetaan tiedot
    Wait Until Element Is Visible                     ${FA_Lisätty_Järjestelmään}
    Element Should Be Visible                         ${FA_Muokattu_viimeksi}
    Element Should Be Visible                         ${FA_linkkien_lukumaara}
    Radio Button Should Be Set To                     exit-number-a    enabled
    Radio Button Should Be Set To                     exit-number-b    enabled
    Element Attribute Value Should Be                 ${Liittymänumero_katkaistu_a}    value    ${liittymänumero_luku}
    Element Attribute Value Should Be                 ${Liittymänumero_katkaistu_b}    value    ${liittymänumero_luku}
    Element Attribute Value Should Be                 ${Liittymänumero_katkaistu_b}    value    ${liittymänumero_luku}
    Element Attribute Value Should Be                 ${Liittymänumero_katkaistu_b}    value    ${liittymänumero_luku}


*** Variables ***
${FA_header_Liittymänumero_otsikko}                   css=#feature-attributes-header
${Liittymänumero_popup_otsikko}                       css=body > div.container > div.modal-overlay.mass-update-modal > div > div.form-elements-container > div > label
${Liittymänumero_input_kenttä_header}                 css=#feature-attributes-form > div > div > div.form-elements-container > div > div > div.input-unit-combination.input-group > textarea
${Liittymänumero_näkymä_radionappi_group}             name=exit-number
${Liittymänumero_popup_valikko}                       css=body > div.container > div.modal-overlay.mass-update-modal > div
${Liittymänumero_popup_tekstikenttä}                  css=body > div.container > div.modal-overlay.mass-update-modal > div > div.form-elements-container > div > div > div.input-unit-combination.input-group > textarea
${Liittymänumero_katkaistu_a}                         css=#feature-attributes-form > div > div > div.form-elements-container > div:nth-child(1) > div > div.input-unit-combination.input-group > textarea
${Liittymänumero_katkaistu_b}                         css=#feature-attributes-form > div > div > div.form-elements-container > div:nth-child(2) > div > div.input-unit-combination.input-group > textarea
${Liittymänumero_header_arvo}                         css=#feature-attributes-form > div > div > div.form-elements-container > div > p