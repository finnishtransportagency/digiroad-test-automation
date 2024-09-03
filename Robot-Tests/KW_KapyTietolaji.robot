*** Settings ***
Documentation       Keywords for Walking/Biking

Resource    common_keywords.robot

*** Keywords ***
Kapy_1  [Arguments]  ${tietolaji}  ${testipaikka}
    Log  Testataan jokaisen mahdollisen Käpy tietolajin talletus
    Siirry Testipaikkaan  ${tietolaji}  ${testipaikka}
    Odota sivun latautuminen
    Log  Nollataan tarvittaessa tietolaji
    Click Element At Coordinates  ${Kartta}  0  20
    Wait Until Element Is Visible  ${FA_otsikko}
    ${status}=  Run Keyword And Return Status  Element Should Contain  ${FA_Käpy_Tietolaji}  ei ole
    Run Keyword If  ${status}==False  Nollaa Käpy Rajoitus

    Siirry Muokkaustilaan
    ${values}=  Get List Items  ${FA_KapyDDM}  values=True
    Siirry Katselutilaan
    ${length}=  Get Length      ${values}
    Should Be Equal As Integers  ${length}  18

    Tarkista Kapy Talletus  @{values}[2:]


Kapy_2  [Arguments]  ${tietolaji}  ${testipaikka}
    Log  Testataan katkaisutyökalu, sekä suorakulmio valintatyökalun talletus.
    Siirry Testipaikkaan            ${tietolaji}  ${testipaikka}

    # Log  Nollataan tarvittaessa tietolaji
    # Click Element At Coordinates    ${Kartta}  0  20
    # Wait Until Element Is Visible   ${FA_otsikko}
    # ${status}=  Run Keyword And Return Status  Element Should Contain  ${FA_Käpy_Tietolaji}  ei ole
    # Run Keyword If                  ${status}==False  Nollaa Käpy Rajoitus

    Log  Talletetaan tielle tietolaji suorakulmio työkalulla.
    Siirry Muokkaustilaan
    Wait Until Element Is Not Visible  ${Map_popup}
    Odota sivun latautuminen
    Click Element                   css=.${tietolaji} .rectangle
    Click Element At Coordinates    ${Kartta}  -50  -30
    Click Element At Coordinates    ${Kartta}  50  100
    Click Element                   css=[value=enabled]
    Click Element                   css=[value="8"]
    Click Element                   ${FA_header_Tallenna}

    Wait Until Element Is Not Visible   ${Spinner_Overlay}
    Odota sivun latautuminen
    Siirry Katselutilaan
    Odota sivun latautuminen
    Click Element At Coordinates    ${Kartta}  0  20
    Wait Until Element Is Visible   ${FA_otsikko}
    Element Should Contain          ${FA_Käpyt_tietolaji_tyyppi}  Kävelykatu

    Log  Leikataan Käpy rajoitus ja tarkistetaan talletus
    Siirry Muokkaustilaan
    Wait Until Element Is Not Visible  ${Map_popup}
    Click Element                   css=.${tietolaji} .cut
    Click Element At Coordinates    ${Kartta}  0  20
    Wait Until Element Is Visible   ${FA_Käpy_A_DDM}

    Click Element                   ${FA_Käpy_A_DDM}
    Click Element                   ${FA_Käpy_A_Valinta}
    Click Element                   ${FA_Käpy_B_DDM}
    Click Element                   ${FA_Käpy_B_Valinta}

    Log  Klikataan karttaa muokkauksen keskellä. Tarkistetaan varoitus.
    Click Element At Coordinates    ${Kartta}  0  -100
    Wait Until Element Is Visible   ${MuokkausVaroitus}
    Click Element                   ${Muokkausvaroitus_Sulje_btn}

    Click Element                   ${FA_header_Tallenna}
    Wait Until Element Is Not Visible   ${Spinner_Overlay}
    Odota sivun latautuminen
    Siirry Katselutilaan
    Odota sivun latautuminen

    Click Element At Coordinates    ${Kartta}  -20  20
    Wait Until Element Is Visible   ${FA_otsikko}
    Element Should Contain          ${FA_Käpyt_tietolaji_tyyppi}  Kävelykatu

    Click Element At Coordinates    ${Kartta}  20  25
    Wait Until Element Is Visible   ${FA_otsikko}
    Element Should Contain          ${FA_Käpyt_tietolaji_tyyppi}  Pyörätie

    Log  Putsataan testipaikka
    Siirry Muokkaustilaan
    Wait Until Element Is Not Visible  ${Map_popup}
    Click Element                   css=.${tietolaji} .rectangle
    Click Element At Coordinates    ${Kartta}  -50  -30
    Click Element At Coordinates    ${Kartta}  50  100
    Click Element                   css=[value=disabled]
    Click Element                   ${FA_header_Tallenna}






#########################
### Sisäiset Keywordti###
#########################

Nollaa Käpy Rajoitus
    Siirry Muokkaustilaan
    Click Element  ${FA_EiKäpyRajoitusta_RB}
    Click Element  ${FA_footer_Tallenna}
    Wait Until Element Is Not Visible  ${Spinner_Overlay}
    Odota sivun latautuminen
    Siirry Katselutilaan
    Click Element At Coordinates  ${Kartta}  0  20
    Wait Until Element Is Visible  ${FA_otsikko}
    Element Should Contain  ${FA_Käpy_Tietolaji}  ei ole

Tarkista Kapy Talletus  [Arguments]  @{lista}
    FOR  ${i}  IN  @{lista}
        Siirry Muokkaustilaan
        Click Element                       css=[value=enabled]
        Click Element                       ${FA_KapyDDM}
        ${text}=  Get Text                  css=[value="${i}"]
        Click Element                       css=[value="${i}"]
        Click Element                       ${FA_footer_Tallenna}
        Wait Until Element Is Not Visible   ${Spinner_Overlay}
        Odota sivun latautuminen
        Siirry Katselutilaan
        Click Element At Coordinates        ${Kartta}  0  20
        Wait Until Element Is Visible       ${FA_otsikko}
        Element Should Contain              ${FA_Käpyt_tietolaji_tyyppi}  ${text}
    END

Talleta Ja Tarkista Käpy Rajoitus
    Log    Talletetaan ja tarkistetaan käpyrajoitus

*** Variables ***
${FA_KapyDDM}               css=.form-control.cycling-and-walking
${FA_Käpy_Tietolaji}        css=.form-control-static.cycling-and-walking
${FA_Käpyt_tietolaji_tyyppi}    css=.input-unit-combination .form-group .form-control-static
${FA_EiKäpyRajoitusta_RB}   css=.choice-group > div:nth-child(1) > label > input

${FA_Käpy_A_DDM}            css=.form-editable-cycling-and-walking-a .form-control.cycling-and-walking
${FA_Käpy_A_Valinta}        css=.form-editable-cycling-and-walking-a [value="7"]

${FA_Käpy_B_DDM}            css=.form-editable-cycling-and-walking-b .form-control.cycling-and-walking
${FA_Käpy_B_Valinta}        css=.form-editable-cycling-and-walking-a [value="11"]