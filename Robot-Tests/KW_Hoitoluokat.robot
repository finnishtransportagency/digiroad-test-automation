#       Joni Laari        Sitowise        2024

*** Settings ***
Documentation       Keywords for maintenance class (Hoitoluokka)
Library             SeleniumLibrary
Resource            common_keywords.robot


*** Keywords ***
Hoitoluokan tarkastelu    [arguments]    ${testipaikka}
    Log    Tarkastellaan hoitoluokan ilmestyminen zoomatessa
    Vaihda Tietolaji    ${TL_Hoitoluokat_RB}
    Paikanna osoite    ${testipaikka}
    Zoomaa kartta    3    200
    Odota sivun latautuminen

    Click Element At Coordinates      ${Kartta}    0    20
    Wait Until Element Is Visible     ${FA_otsikko}
    Element Should Be Visible         ${FA_Lisätty_Järjestelmään}
    Element Should Be Visible         ${FA_Muokattu_viimeksi}
    Element Should Be Visible         ${FA_linkkien_lukumaara}
    Element Should Be Visible         ${FA_Hoitoluokka}
    Element Should Be Visible         ${FA_Talvihoitoluokka}
    Element Should Be Visible         ${FA_Viherhoitoluokka}

    Click Element At Coordinates      ${Kartta}    200    0
    Odota sivun latautuminen
    Tupla Klikkaa Kartan Keskelle
    Wait Until Element Is Visible     ${FA_otsikko}
    Element Should Be Visible         ${FA_Lisätty_Järjestelmään}
    Element Should Be Visible         ${FA_Muokattu_viimeksi}
    Element Should Be Visible         ${FA_linkkien_lukumaara}
    Element Should Be Visible         ${FA_Hoitoluokka}
    Element Should Be Visible         ${FA_Talvihoitoluokka}
    Element Should Be Visible         ${FA_Viherhoitoluokka}
    Click Element At Coordinates      ${Kartta}    200    0
    Odota sivun latautuminen


Hoitoluokan muokkaus koko ketjulle    [arguments]    ${testipaikka}    ${hoitoluokan_arvo}    ${hoitoluokan_vuodenaika}    ${indeksi}
    Log    Hoitotiedon muokkaus koko ketjulle
    Vaihda Tietolaji                 ${TL_Hoitoluokat_RB}
    Paikanna osoite                  ${testipaikka}
    Zoomaa kartta    3    200
    Select Radio Button    labelRadio    ${hoitoluokan_vuodenaika}
    ${hoitoluokan radionappi boolean}=    Radio Button Should Be Set To    labelRadio    ${hoitoluokan_vuodenaika}
    #IF  ${hoitoluokan radionappi boolean} == $FALSE
    #    Select Radio Button    labelRadio    ${hoitoluokan_vuodenaika}
    #END
    Odota sivun latautuminen

    Click Element At Coordinates     ${Kartta}    0    20
    Wait Until Element Is Visible     ${FA_Lisätty_Järjestelmään}
    Element Should Be Visible         ${FA_Muokattu_viimeksi}
    Element Should Be Visible         ${FA_linkkien_lukumaara}

    IF    $hoitoluokan_vuodenaika == 'winterCare'
        Siirry Muokkaustilaan
        Wait Until Element Is Visible     ${FA_Hoitoluokka_choicegroup}
        Select Radio Button               careClass    enabled
        Radio Button Should Be Set To     careClass    enabled
        Click Element    ${FA_Hoitoluokka_Dropdownmenu}
        FOR    ${i}    IN    ${indeksi}
            Press Keys    None    ARROW_DOWN
        END
        Press Keys    None    ENTER
        Element Should Be Enabled         ${FA_footer_Tallenna}
        Click Element                     ${FA_footer_Peruuta}
        Odota sivun latautuminen
        Siirry Katselutilaan
    END


Hoitoluokan muokkaus ketjun osalle    [arguments]    ${testipaikka}    ${hoitoluokan_arvo}    ${hoitoluokan_vuodenaika}    ${indeksi}
    Log    Hoitotiedon muokkaus ketjun osalle
    Vaihda Tietolaji                  ${TL_Hoitoluokat_RB}
    Paikanna osoite                   ${testipaikka}
    Zoomaa kartta    3    200

    Select Radio Button               labelRadio    ${hoitoluokan_vuodenaika}
    Radio Button Should Be Set To     labelRadio    ${hoitoluokan_vuodenaika}
    Odota sivun latautuminen

    Tupla Klikkaa Kartan Keskelle
    Wait Until Element Is Visible     ${FA_Lisätty_Järjestelmään}
    Element Should Be Visible         ${FA_Muokattu_viimeksi}
    Element Should Be Visible         ${FA_linkkien_lukumaara}

    IF    $hoitoluokan_vuodenaika == 'winterCare'
        Siirry Muokkaustilaan
        Wait Until Element Is Visible     ${FA_Hoitoluokka_choicegroup}
        Select Radio Button               careClass    enabled
        Radio Button Should Be Set To     careClass    enabled
        Click Element    ${FA_Hoitoluokka_Dropdownmenu}
        FOR    ${i}    IN    ${indeksi}
            Press Keys    None    ARROW_DOWN
        END
        Press Keys    None    ENTER
        Element Should Be Enabled         ${FA_footer_Tallenna}
        Click Element                     ${FA_footer_Peruuta}
        Odota sivun latautuminen
        Siirry Katselutilaan
    END


Hoitoluokan laatikkovalinta    [arguments]    ${testipaikka}    ${dropdown_nappi}
    Log    Hoitoluokan lisääminen laatikolla
    Vaihda Tietolaji    ${TL_Hoitoluokat_RB}
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
    Radio Button Should Be Set To               careClass    disabled
    Select Radio Button                         careClass    enabled
    Radio Button Should Be Set To               careClass    enabled
    Click Element    css=body > div.container > div.modal-overlay.mass-update-modal > div > div.form-elements-container > div > div.input-unit-combination > div > select
    Press Keys    None    P
    Press Keys    None    Enter
    Element Should Be Enabled                   ${FA_header_Tallenna}
    Click Element                               ${FA_header_Peruuta}
    Odota sivun latautuminen
    Siirry Katselutilaan


Hoitoluokan polygonvalinta    [arguments]    ${testipaikka}    ${dropdown_nappi}
    Log    Hoitoluokan lisääminen polygonilla
    Vaihda Tietolaji    ${TL_Hoitoluokat_RB}
    Paikanna osoite                             ${testipaikka}
    Zoomaa kartta                               5   50 m
    Odota sivun latautuminen
    Siirry Muokkaustilaan
    Wait Until Element Is Not Visible           ${Map_popup}
    Log    Tarkistetaan polygontyökalu
    Wait Until Element Is Visible               ${Muokkaustila_PolygonTool}
    Click Element                               ${Muokkaustila_PolygonTool}
    Suorita monivalinta
    Wait Until Element Is Visible               css=body > div.container > div.modal-overlay.mass-update-modal > div
    Radio Button Should Be Set To               careClass    disabled
    Select Radio Button                         careClass    enabled
    Radio Button Should Be Set To               careClass    enabled
    Click Element    css=body > div.container > div.modal-overlay.mass-update-modal > div > div.form-elements-container > div > div.input-unit-combination > div > select
    Press Keys    None    ${dropdown_nappi}
    Press Keys    None    Enter
    Element Should Be Enabled                   ${FA_header_Tallenna}
    Click Element                               ${FA_header_Peruuta}
    Odota sivun latautuminen
    Siirry Katselutilaan


Hoitoluokan katkaisu    [arguments]    ${testipaikka}    ${dropdown_nappi}
    Log    Hoitoluokan katkaisu
    Vaihda Tietolaji            ${TL_Hoitoluokat_RB}
    Paikanna osoite            ${testipaikka}
    Zoomaa kartta                               5   50 m
    Odota sivun latautuminen
    Siirry Muokkaustilaan

    Log  Leikataan kahteen osaan
    Wait Until Element Is Not Visible           ${Map_popup}
    Click Element                               ${Muokkaustila_Leikkaus}
    Click Element At Coordinates                ${Kartta}   0  10
    Wait Until Element Is Visible               ${FA_Lisätty_järjestelmään}
    FOR    ${i}    IN    @{FA_Hoitoluokan_katkaisu_kohteet}
        Log    ${i}
        Element Should Be Visible    ${i}
    END
    Radio Button Should Be Set To    careClass-a    enabled
    Radio Button Should Be Set To    careClass-b    enabled
    Click Element    css=#feature-attributes-form > div > div > div.dynamic-form.editable.form-editable-careClass-a > div.input-unit-combination > div > select
    Press Keys    None    ${dropdown_nappi}
    Press Keys    None    Enter
    Element Should Be Enabled                   ${FA_header_Tallenna}
    Click Element                               css=#feature-attributes-footer > div > button.cancel.btn.btn-secondary    #cancel eikä close jostain syystä
    Odota sivun latautuminen
    Siirry Katselutilaan


*** Variables ***
${FA_Hoitoluokka}    css=#feature-attributes-form > div > div > div.dynamic-form.editable.form-editable-careClass > p
${FA_Talvihoitoluokka}    css=#feature-attributes-form > div > div > div.dynamic-form.editable.form-editable-careClass > div.input-unit-combination > div:nth-child(1) > p
${FA_Viherhoitoluokka}    css=#feature-attributes-form > div > div > div.dynamic-form.editable.form-editable-careClass > div.input-unit-combination > div:nth-child(1) > p
${FA_Hoitoluokka_choicegroup}    css=#feature-attributes-form > div > div > div.dynamic-form.editable.form-editable-careClass > div.edit-control-group.choice-group
${FA_Hoitoluokka_Dropdownmenu}    css=#feature-attributes-form > div > div > div.dynamic-form.editable.form-editable-careClass > div.input-unit-combination > div > select
@{FA_Hoitoluokan_katkaisu_kohteet}=    ${FA_Lisätty_järjestelmään}    ${FA_Muokattu_viimeksi}    ${FA_Linkkien_lukumaara}    css=#feature-attributes-form > div > div > div.dynamic-form.editable.form-editable-careClass-a > label    css=#feature-attributes-form > div > div > div.dynamic-form.editable.form-editable-careClass-b > label    css=#feature-attributes-form > div > div > div.dynamic-form.editable.form-editable-careClass-a > span    css=#feature-attributes-form > div > div > div.dynamic-form.editable.form-editable-careClass-b > span