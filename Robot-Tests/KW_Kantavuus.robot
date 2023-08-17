#       Joni Laari        Sitowise        2023

*** Settings ***
Documentation       Keywords for carrying capacity (Kantavuus)
Library             SeleniumLibrary
Resource            common_keywords.robot


*** Keywords ***
Kevätkantavuus_lisäys    [arguments]            ${testipaikka}    ${routivuuskerroin}
    #testitapaus nro 3
    Testin Aloitus
    Log                                         Tarkistetaan kevätkantavuuden lisäys
    Vaihda Tietolaji                            ${TL_Kantavuus_RB}
    Paikanna osoite                             ${testipaikka}
    Zoomaa kartta                               5    200
    Odota sivun latautuminen

    #klikkauksen kokeilu, tietolajin vaatimus 2
    Siirry Muokkaustilaan
    Odota sivun latautuminen
    Radio Button Should Be Set To               ${Kantavuus_näkymä_radionappi_group}    ${Kantavuus_radionappi_kevätkantavuus}
    Sleep    2
    Click Element At Coordinates                ${Kartta}  0  20
    Wait Until Element Is Visible               ${Kantavuus_header_otsikko}
    Element Should Be Visible                   ${Kantavuus_header_otsikko}
    Element Should Be Visible                   ${Kantavuus_header_lisätty_järjestelmään}
    Element Should Be Visible                   ${Kantavuus_header_muokattu_viimeksi}
    Element Should Be Visible                   ${Kantavuus_header_linkkien_lukumäärä}
    Element Should Be Disabled                  ${FA_header_Tallenna}

    Radio Button Should Be Set To               ${Kantavuus_radionappi_header_kantavuus}    disabled
    Select Radio Button                         ${Kantavuus_radionappi_header_kantavuus}    enabled
    Radio Button Should Be Set To               ${Kantavuus_radionappi_header_kantavuus}    enabled

    Element Should Be Enabled                   ${Kantavuus_tekstikenttä_kevätkantavuus}
    Input Text                                  ${Kantavuus_tekstikenttä_kevätkantavuus}        100
    Click Element                                ${Kantavuus_pudotusvalikko_routivuuskerroin}
    Click Element                                css=.form-control.carrying-capacity option[data-value="${routivuuskerroin}"]

    Element Should Be Enabled                    ${FA_footer_Tallenna}
    Element Should Be Enabled                    ${FA_footer_Peruuta}
    Click Element                                ${FA_footer_Peruuta}


Kantavuus_lisäys_virheellinen    [arguments]    ${testipaikka}    ${virheellinen}
    #testitapaus 3 f I
    Testin Aloitus
    Log                                         Tarkistetaan kevätkantavuuden lisäys
    Vaihda Tietolaji                            ${TL_Kantavuus_RB}
    Paikanna osoite                             ${testipaikka}
    Zoomaa kartta                               5    200
    Odota sivun latautuminen

    #klikkauksen kokeilu, tietolajin vaatimus 2
    Siirry Muokkaustilaan
    Odota sivun latautuminen
    Radio Button Should Be Set To               ${Kantavuus_näkymä_radionappi_group}    ${Kantavuus_radionappi_kevätkantavuus}
    Sleep    2
    Click Element At Coordinates                ${Kartta}  0  20
    Wait Until Element Is Visible               ${Kantavuus_header_otsikko}
    Element Should Be Visible                   ${Kantavuus_header_otsikko}
    Element Should Be Visible                   ${Kantavuus_header_lisätty_järjestelmään}
    Element Should Be Visible                   ${Kantavuus_header_muokattu_viimeksi}
    Element Should Be Visible                   ${Kantavuus_header_linkkien_lukumäärä}

    Radio Button Should Be Set To               ${Kantavuus_radionappi_header_kantavuus}    disabled
    Select Radio Button                         ${Kantavuus_radionappi_header_kantavuus}    enabled
    Radio Button Should Be Set To               ${Kantavuus_radionappi_header_kantavuus}    enabled

    Element Should Be Enabled                   ${Kantavuus_tekstikenttä_kevätkantavuus}
    Input Text                                  ${Kantavuus_tekstikenttä_kevätkantavuus}        ${virheellinen}

    Element Should Be Disabled                   ${FA_footer_Tallenna}
    Element Should Be Enabled                    ${FA_footer_Peruuta}
    Click Element                                ${FA_footer_Peruuta}


Kantavuuden_lisääminen_laatikko    [arguments]    ${testipaikka}    ${routivuuskerroin}
    #testitapaus nro 4a
    Testin Aloitus
    Log                                         Tarkistetaan kevätkantavuuden lisäys
    Vaihda Tietolaji                            ${TL_Kantavuus_RB}
    Paikanna osoite                             ${testipaikka}
    Zoomaa kartta                               5    200
    Odota sivun latautuminen

    #klikkauksen kokeilu, tietolajin vaatimus 2
    Siirry Muokkaustilaan
    Odota sivun latautuminen
    Radio Button Should Be Set To               ${Kantavuus_näkymä_radionappi_group}    ${Kantavuus_radionappi_kevätkantavuus}

    Wait Until Element Is Enabled               ${Muokkaustila_Laatikko}
    Click Element                               ${Muokkaustila_Laatikko}
    Suorita laatikkovalinta
    Wait Until Element Is Visible               ${Kantavuus_popup_valikko}
    Element Should Be Visible                   ${Kantavuus_popup_valikko}
    Element Should Be Enabled                   ${FA_header_Tallenna}

    Radio Button Should Be Set To               ${Kantavuus_radionappi_header_kantavuus}    disabled
    Select Radio Button                         ${Kantavuus_radionappi_header_kantavuus}    enabled
    Radio Button Should Be Set To               ${Kantavuus_radionappi_header_kantavuus}    enabled
    Element Should Be Disabled                 ${FA_header_Tallenna}

    Element Should Be Enabled                   ${Kantavuus_tekstikenttä_kevätkantavuus}
    Input Text                                  ${Kantavuus_tekstikenttä_kevätkantavuus}        100
    Click Element                                css=.form-control.carrying-capacity
    Click Element                                css=.form-control.carrying-capacity option[data-value="${routivuuskerroin}"]
    Element Should Be Enabled                   ${FA_header_Tallenna}
    Element Should Be Enabled                    ${FA_header_Peruuta}
    Click Element                                ${FA_header_Peruuta}


Kantavuuden_lisääminen_polygon    [arguments]    ${testipaikka}    ${routivuuskerroin}
    #testitapaus nro 4b
    Testin Aloitus
    Log                                         Tarkistetaan uean linkin polygonvalinta ja kantavuuden lisäys
    Vaihda Tietolaji                            ${TL_Kantavuus_RB}
    Paikanna osoite                             ${testipaikka}
    Zoomaa kartta                               5    200
    Odota sivun latautuminen

    #klikkauksen kokeilu, tietolajin vaatimus 2
    Siirry Muokkaustilaan
    Odota sivun latautuminen
    Radio Button Should Be Set To               ${Kantavuus_näkymä_radionappi_group}    ${Kantavuus_radionappi_kevätkantavuus}

    Wait Until Element Is Enabled               ${Muokkaustila_PolygonTool}
    Click Element                               ${Muokkaustila_PolygonTool}
    Suorita monivalinta
    Wait Until Element Is Visible               ${Kantavuus_popup_valikko}
    Element Should Be Visible                   ${Kantavuus_popup_valikko}
    Element Should Be Enabled                   ${FA_header_Tallenna}

    Radio Button Should Be Set To               ${Kantavuus_radionappi_header_kantavuus}    disabled
    Select Radio Button                         ${Kantavuus_radionappi_header_kantavuus}    enabled
    Radio Button Should Be Set To               ${Kantavuus_radionappi_header_kantavuus}    enabled
    Element Should Be Disabled                  ${FA_header_Tallenna}

    Element Should Be Enabled                   ${Kantavuus_tekstikenttä_kevätkantavuus}
    Input Text                                  ${Kantavuus_tekstikenttä_kevätkantavuus}        100
    Click Element                               css=.form-control.carrying-capacity
    Click Element                               css=.form-control.carrying-capacity option[data-value="${routivuuskerroin}"]
    Element Should Be Enabled                   ${FA_header_Tallenna}
    Element Should Be Enabled                   ${FA_header_Peruuta}
    Click Element                               ${FA_header_Peruuta}


Kantavuuden katkaisu    [arguments]    ${testipaikka}    ${routivuuskerroin}
    #Testitapaus 5
    Log    Katkaisutyökalun testaaminen
    Vaihda Tietolaji                            ${TL_Kantavuus_RB}
    Paikanna osoite                             ${testipaikka}
    Zoomaa kartta                               5    100m

    #Lisättävä looppi kantavuuskohteen lisäämiselle ja poistolle
    Odota sivun latautuminen
    Siirry Muokkaustilaan
    Log    Leikataan tielinkki kahteen osaan
    Kantavuuden lisäys katkaisua varten        ${routivuuskerroin}
    Wait Until Element Is Visible              ${Muokkaustila_Leikkaus}
    Click Element                              ${Muokkaustila_Leikkaus}

    Odota sivun latautuminen
    Click Element At Coordinates               ${Kartta}  0  10
    Wait Until Element Is Visible              ${Kantavuus_leikkausnäkymä_A}
    Element Should Be Visible                  ${Kantavuus_leikkausnäkymä_B}

    Input Text    ${Kantavuus_leikkausnäkymä_A_kantavuusluku}    999
    Element Should Be Visible        ${FA_header_Tallenna}
    Click Element                    ${FA_footer_Peruuta}
    Odota sivun latautuminen
    Kantavuuden poisto


Kantavuuden lisäys katkaisua varten    [arguments]    ${routivuuskerroin}
    Odota sivun latautuminen
    Click Element At Coordinates                ${Kartta}  0  20
    Wait Until Element Is Visible               ${Kantavuus_header_otsikko}
    Element Should Be Visible                   ${Kantavuus_header_otsikko}
    Element Should Be Visible                   ${Kantavuus_header_lisätty_järjestelmään}
    Element Should Be Visible                   ${Kantavuus_header_muokattu_viimeksi}
    Element Should Be Visible                   ${Kantavuus_header_linkkien_lukumäärä}
    Element Should Be Disabled                  ${FA_header_Tallenna}

    Radio Button Should Be Set To               ${Kantavuus_radionappi_header_kantavuus}    disabled
    Select Radio Button                         ${Kantavuus_radionappi_header_kantavuus}    enabled
    Radio Button Should Be Set To               ${Kantavuus_radionappi_header_kantavuus}    enabled

    Element Should Be Enabled                   ${Kantavuus_tekstikenttä_kevätkantavuus}
    Input Text                                  ${Kantavuus_tekstikenttä_kevätkantavuus}        100
    Click Element                               ${Kantavuus_pudotusvalikko_routivuuskerroin}
    Click Element                               css=.form-control.carrying-capacity option[data-value="${routivuuskerroin}"]

    Element Should Be Enabled                   ${FA_footer_Tallenna}
    Click Element                               ${FA_footer_Tallenna}


Kantavuuden poisto
    Log    Poistetaan kantavuustieto
    Click Element                               ${zoombar_minus}
    Click Element                    ${Muokkaustila_SelectTool}
    Click Element At Coordinates     ${Kartta}    0    20
    Odota sivun latautuminen
    Select Radio Button                         ${Kantavuus_radionappi_header_kantavuus}    disabled
    Radio Button Should Be Set To               ${Kantavuus_radionappi_header_kantavuus}    disabled
    Click Element    ${FA_footer_Tallenna}
    Odota sivun latautuminen


*** Variables ***
${Kantavuus_näkymä_radionappi_group}            labelingRadioButton-carrying-capacity
${Kantavuus_radionappi_kevätkantavuus}          spring-carrying-capacity
${Kantavuus_radionappi_routivuuskerroin}        frost-heaving-factor

${Kantavuus_header_otsikko}                    css=#feature-attributes-header > span.edit-mode-title
${Kantavuus_header_lisätty_järjestelmään}      css=#feature-attributes-form > div > div > div:nth-child(1) > p
${Kantavuus_header_muokattu_viimeksi}          css=#feature-attributes-form > div > div > div:nth-child(2) > p
${Kantavuus_header_linkkien_lukumäärä}         css=#feature-attributes-form > div > div > div:nth-child(3) > p

${Kantavuus_radionappi_header_kantavuus}       carrying-capacity
${Kantavuus_radionappi_header_kantavuus_A}       carrying-capacity-a
${Kantavuus_radionappi_header_kantavuus_B}       carrying-capacity-B
${Kantavuus_tekstikenttä_kevätkantavuus}       css=#carrying-capacity
${Kantavuus_pudotusvalikko_routivuuskerroin}    css=#feature-attributes-form > div > div > div.dynamic-form.editable.form-editable-carrying-capacity > div.input-unit-combination > div:nth-child(2) > select
${Kantavuus_pudotusvalikko_routivuuskerroin_erittäinroutiva}    css=#feature-attributes-form > div > div > div.dynamic-form.editable.form-editable-carrying-capacity > div.input-unit-combination > div:nth-child(2) > select > option:nth-child(2)
${Kantavuus_popup_valikko}                    css=body > div.container > div.modal-overlay.mass-update-modal > div

${Kantavuus_leikkausnäkymä_A}                 css=.form-editable-carrying-capacity-a
${Kantavuus_leikkausnäkymä_B}                 css=.form-editable-carrying-capacity-b
${Kantavuus_leikkausnäkymä_A_kantavuusluku}    xpath=/html/body/div[1]/div[2]/main/article/div/div/div[4]/div[2]/div[1]/input