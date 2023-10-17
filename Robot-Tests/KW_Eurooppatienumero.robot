#       Joni Laari        Sitowise        2023

*** Settings ***
Documentation       Keywords for thaw damage (Eurooppatienumero)
Library             SeleniumLibrary
Resource            common_keywords.robot


*** Keywords ***
Eurooppatienumeron tarkastelu    [arguments]    ${testipaikka}
    Testin Aloitus
    Log                                         Testataan eurooppatienumeron tarkastelu
    Vaihda Tietolaji                            ${TL_Eurooppatienumero_RB}
    Paikanna osoite                             ${testipaikka}
    Zoomaa kartta                               5    50
    Odota sivun latautuminen

    Click Element At Coordinates                ${Kartta}    0    20
    Wait Until Element Is Visible               ${FA_header_Eurooppatienumero_otsikko}


Eurooppatienumeron lisääminen    [arguments]    ${testipaikka}
    Testin Aloitus
    Log                                         Tarkistetaan eurooppatienumeron lisäys
    Vaihda Tietolaji                            ${TL_Eurooppatienumero_RB}
    Paikanna osoite                             ${testipaikka}
    Zoomaa kartta                               5    50
    Siirry Muokkaustilaan
    Odota sivun latautuminen

    Click Element At Coordinates                ${Kartta}    0    20
    Wait Until Element Is Visible               ${FA_header_Eurooppatienumero_otsikko}
    Element Should Be Enabled                   ${Eurooppatienumero_näkymä_radionappi_group}
    Select Radio Button                         european-road    enabled
    Radio Button Should Be Set To               european-road    enabled

    Input Text                                  ${Eurooppatienumero_input_kenttä_header}    100    #integer
    Element Should Be Enabled                   ${FA_header_Tallenna}
    Clear Element Text                          ${Eurooppatienumero_input_kenttä_header}


Eurooppatienumeron virheellinen lisääminen        [arguments]    ${testipaikka}
    Testin Aloitus
    Log                                         Tarkistetaan virheellisen eurooppatienumeron lisäys
    Vaihda Tietolaji                            ${TL_Eurooppatienumero_RB}
    Paikanna osoite                             ${testipaikka}
    Zoomaa kartta                               5    50
    Siirry Muokkaustilaan
    Odota sivun latautuminen

    Click Element At Coordinates                ${Kartta}    0    20
    Wait Until Element Is Visible               ${FA_header_Eurooppatienumero_otsikko}
    Element Should Be Disabled                   ${Eurooppatienumero_input_kenttä_header}
    Select Radio Button                         european-road    enabled
    Radio Button Should Be Set To               european-road    enabled

    #lisätään virheellisiä tietomuotoja
    Input Text                                  ${Eurooppatienumero_input_kenttä_header}    -99    #negative
    Element Should Be Disabled                  ${FA_header_Tallenna}
    Clear Element Text                          ${Eurooppatienumero_input_kenttä_header}

    Input Text                                  ${Eurooppatienumero_input_kenttä_header}    asd    #NaN
    Element Should Be Disabled                  ${FA_header_Tallenna}
    Clear Element Text                          ${Eurooppatienumero_input_kenttä_header}

    Input Text                                  ${Eurooppatienumero_input_kenttä_header}    99.99    #float
    Element Should Be Disabled                  ${FA_header_Tallenna}
    Clear Element Text                          ${Eurooppatienumero_input_kenttä_header}


Eurooppatienumeron lisääminen laatikko    [arguments]    ${testipaikka}
    Testin Aloitus
    Log                                         Tarkistetaan usean eurooppatienumeron lisäys laatikolla
    Vaihda Tietolaji                            ${TL_Eurooppatienumero_RB}
    Paikanna osoite                             ${testipaikka}
    Zoomaa kartta                               1    200
    Odota sivun latautuminen
    Siirry Muokkaustilaan
    Odota sivun latautuminen
    Wait Until Element Is Enabled               ${Muokkaustila_Laatikko}
    Click Element                               ${Muokkaustila_Laatikko}
    Suorita laatikkovalinta
    Wait Until Element Is Visible               ${Eurooppatienro_popup_valikko}
    Element Should Be Visible                   ${Eurooppatienro_popup_valikko}
    Select Radio Button                         european-road    enabled
    Radio Button Should Be Set To               european-road    enabled

    Input Text                                  css=body > div.container > div.modal-overlay.mass-update-modal > div > div.form-elements-container > div > div > div.input-unit-combination.input-group > textarea    500    #positiivinen kokonaisluku <1000

    Element Should Be Enabled                   ${FA_header_Tallenna}
    Element Should Be Enabled                   ${FA_header_Peruuta}
    Click Element                               ${FA_header_Peruuta}


Eurooppatienumeron lisääminen polygon    [arguments]    ${testipaikka}
    #testitapaus nro 5b
    Testin Aloitus
    Log                                         Tarkistetaan usean eurooppatienumeron lisäys polygonilla
    Vaihda Tietolaji                            ${TL_Eurooppatienumero_RB}
    Paikanna osoite                             ${testipaikka}
    Zoomaa kartta                               5    200
    Odota sivun latautuminen

    Siirry Muokkaustilaan
    Odota sivun latautuminen

    Wait Until Element Is Enabled               ${Muokkaustila_PolygonTool}
    Click Element                               ${Muokkaustila_PolygonTool}
    Suorita monivalinta
    Wait Until Element Is Visible               ${Eurooppatienro_popup_valikko}
    Element Should Be Visible                   ${Eurooppatienro_popup_valikko}
    Select Radio Button                         european-road    enabled
    Radio Button Should Be Set To               european-road    enabled

    Input Text                                  css=body > div.container > div.modal-overlay.mass-update-modal > div > div.form-elements-container > div > div > div.input-unit-combination.input-group > textarea    500    #positiivinen kokonaisluku <1000

    Element Should Be Enabled                   ${FA_header_Tallenna}
    Element Should Be Enabled                   ${FA_header_Peruuta}
    Click Element                               ${FA_header_Peruuta}


Eurooppatienumeron lisääminen ctrl    [arguments]        ${testipaikka_1}    ${testipaikka_2}
    Testin Aloitus
    Log                                                       Tarkistetaan usean eurooppatienumeron lisäys ctrl-napilla
    Vaihda Tietolaji                                          ${TL_Eurooppatienumero_RB}
    Paikanna osoite                                           ${testipaikka_1}
    Zoomaa kartta                                             3    200
    Siirry Muokkaustilaan
    Odota sivun latautuminen
    Sleep    3

    #painetaan control pohjaan ja klikataan
    Hold Control And Click Element At Coordinates             ${Kartta}  0  0
    #selenium_extensions.Hold Control And Drag By Offset       ${Kartta}  0  100
    #Click Element At Coordinates                              ${Kartta}  0  0
    #selenium_extensions.Hold Control And Drag By Offset       ${Kartta}  0  -200
    #Paikanna osoite                                           ${testipaikka_2}
    #Click Element At Coordinates                              ${Kartta}  0  0
    Release Control

    #lisätään tietoja
    Wait Until Element Is Visible               ${Eurooppatienro_popup_valikko}
    Element Should Be Visible                   ${Eurooppatienro_popup_valikko}
    Select Radio Button                         european-road    enabled
    Radio Button Should Be Set To               european-road    enabled

    Input Text                                  css=body > div.container > div.modal-overlay.mass-update-modal > div > div.form-elements-container > div > div > div.input-unit-combination.input-group > textarea    500    #positiivinen kokonaisluku <1000

    Element Should Be Enabled                   ${FA_header_Tallenna}
    Element Should Be Enabled                   ${FA_header_Peruuta}
    Click Element                               ${FA_header_Peruuta}


Eurooppatienumeron katkaisu    [arguments]    ${testipaikka}    ${eurooppatienumero_luku}
    Testin Aloitus
    Log                                         Tarkistetaan eurooppatienumeron katkaisu kahdeksi
    Vaihda Tietolaji                            ${TL_Eurooppatienumero_RB}
    Paikanna osoite                             ${testipaikka}
    Zoomaa kartta                               5   50 m
    Odota sivun latautuminen
    Siirry Muokkaustilaan
    Wait Until Element Is Not Visible           ${Map_popup}
    Wait Until Element Is Visible               ${Muokkaustila_Leikkaus}
    Click Element                               ${Muokkaustila_Leikkaus}
    Click Element At Coordinates                ${Kartta}  0  20

    #tarkistetaan tiedot
    Wait Until Element Is Visible               ${FA_Lisätty_Järjestelmään}
    Element Should Be Visible                   ${FA_Muokattu_viimeksi}
    Element Should Be Visible                   ${FA_linkkien_lukumaara}
    Radio Button Should Be Set To               european-road-a    enabled
    Radio Button Should Be Set To               european-road-b    enabled
    Element Attribute Value Should Be           ${Eurooppatienumero_katkaistu_a}    value    ${eurooppatienumero_luku}
    Element Attribute Value Should Be           ${Eurooppatienumero_katkaistu_b}    value    ${eurooppatienumero_luku}
    Element Attribute Value Should Be           ${Eurooppatienumero_katkaistu_b}    value    ${eurooppatienumero_luku}
    Element Attribute Value Should Be           ${Eurooppatienumero_katkaistu_b}    value    ${eurooppatienumero_luku}


*** Variables ***
${FA_header_Eurooppatienumero_otsikko}                   css=#feature-attributes-header
${Eurooppatienumero_popup_otsikko}                       css=body > div.container > div.modal-overlay.mass-update-modal > div > div.form-elements-container > div > label
${Eurooppatienumero_input_kenttä_header}                 css=#feature-attributes-form > div > div > div.form-elements-container > div > div > div.input-unit-combination.input-group > textarea
${Eurooppatienumero_näkymä_radionappi_group}             name=european-road
${Eurooppatienumero_popup_toistuuvuosittain_checkbox}    css=body > div.container > div.modal-overlay.mass-update-modal > div > div.form-elements-container > div > div.input-unit-combination > div:nth-child(3) > div > input
${Popup_eurooppatienumero_aloituspvm}                    css=#datePeriod-start1
${Popup_eurooppatienumero_päättymispvm}                  css=#datePeriod-

${Eurooppatienro_popup_valikko}                          css=body > div.container > div.modal-overlay.mass-update-modal > div

${Eurooppatienumero_katkaistu_a}                         css=#feature-attributes-form > div > div > div.form-elements-container > div:nth-child(1) > div > div.input-unit-combination.input-group > textarea
${Eurooppatienumero_katkaistu_b}                         css=#feature-attributes-form > div > div > div.form-elements-container > div:nth-child(2) > div > div.input-unit-combination.input-group > textarea

${Eurooppatienumerokausi_aloituspvm_a}                   id=datePeriod-start1
${Eurooppatienumerokausi_lopetuspvm_a}                   id=datePeriod-end1