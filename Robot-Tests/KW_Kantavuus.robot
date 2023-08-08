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


*** Variables ***
${Kantavuus_näkymä_radionappi_group}            labelingRadioButton-carrying-capacity
${Kantavuus_radionappi_kevätkantavuus}          spring-carrying-capacity
${Kantavuus_radionappi_routivuuskerroin}        frost-heaving-factor

${Kantavuus_header_otsikko}                    css=#feature-attributes-header > span.edit-mode-title
${Kantavuus_header_lisätty_järjestelmään}      css=#feature-attributes-form > div > div > div:nth-child(1) > p
${Kantavuus_header_muokattu_viimeksi}          css=#feature-attributes-form > div > div > div:nth-child(2) > p
${Kantavuus_header_linkkien_lukumäärä}         css=#feature-attributes-form > div > div > div:nth-child(3) > p

${Kantavuus_radionappi_header_kantavuus}       carrying-capacity
${Kantavuus_tekstikenttä_kevätkantavuus}       css=#carrying-capacity
${Kantavuus_pudotusvalikko_routivuuskerroin}    css=#feature-attributes-form > div > div > div.dynamic-form.editable.form-editable-carrying-capacity > div.input-unit-combination > div:nth-child(2) > select
${Kantavuus_pudotusvalikko_routivuuskerroin_erittäinroutiva}    css=#feature-attributes-form > div > div > div.dynamic-form.editable.form-editable-carrying-capacity > div.input-unit-combination > div:nth-child(2) > select > option:nth-child(2)