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

    Click Element At Coordinates                ${Kartta}    0    20
    Wait Until Element Is Visible               ${FA_otsikko}
    Element Should Be Visible                   ${FA_Lisätty_Järjestelmään}
    Element Should Be Visible                   ${FA_Muokattu_viimeksi}
    Element Should Be Visible                   ${FA_linkkien_lukumaara}
    Element Should Be Visible                   ${FA_Hoitoluokka}
    Element Should Be Visible                   ${FA_Talvihoitoluokka}
    Element Should Be Visible                   ${FA_Viherhoitoluokka}


Hoitoluokan muokkaus koko ketjulle    [arguments]    ${testipaikka}
    Log    Hoitotiedon muokkaus koko ketjulle
    Vaihda Tietolaji    ${TL_Hoitoluokat_RB}
    Paikanna osoite    ${testipaikka}
    Zoomaa kartta    3    200
    Siirry Muokkaustilaan
    Radio Button Should Be Set To    labelRadio    winterCare
    Odota sivun latautuminen

    Click Element At Coordinates     ${Kartta}    0    20
    Wait Until Element Is Visible    ${FA_Hoitoluokka_choicegroup}
    Select Radio Button              careClass    enabled
    Radio Button Should Be Set To    careClass    enabled
    #todo dropdown menu 16.5
    
    Element Should Be Enabled    ${FA_footer_Tallenna}
    Click Element                    ${FA_footer_Peruuta}

*** Variables ***
${FA_Hoitoluokka}    css=#feature-attributes-form > div > div > div.dynamic-form.editable.form-editable-careClass > p
${FA_Talvihoitoluokka}    css=#feature-attributes-form > div > div > div.dynamic-form.editable.form-editable-careClass > div.input-unit-combination > div:nth-child(1) > p
${FA_Viherhoitoluokka}    css=#feature-attributes-form > div > div > div.dynamic-form.editable.form-editable-careClass > div.input-unit-combination > div:nth-child(1) > p
${FA_Hoitoluokka_choicegroup}    css=#feature-attributes-form > div > div > div.dynamic-form.editable.form-editable-careClass > div.edit-control-group.choice-group