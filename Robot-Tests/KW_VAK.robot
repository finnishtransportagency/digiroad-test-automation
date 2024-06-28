*** Settings ***
Documentation       Pageobject for Vaarallisten aineden kuljetus rajoitukset.
Resource    common_keywords.robot

*** Keywords ***

VAK_1  [Arguments]  ${tietolaji}  ${testipaikka}
    Log  Testataan katkaisutyökalu, sekä suorakulmio valintatyökalun talletus.
    Siirry Testipaikkaan            ${tietolaji}  ${testipaikka}

    Log  Talletetaan tielle tietolaji suorakulmio työkalulla.
    Siirry Muokkaustilaan
    Wait Until Element Is Not Visible  ${Map_popup}
    Click Element                   css=.${tietolaji} .rectangle
    Click Element At Coordinates    ${Kartta}  -50  -30
    Click Element At Coordinates    ${Kartta}  50  100
    Click Element                   css=.form-control.select
    Click Element                   css=[value="24"]
    Click Element                   ${FA_header_Tallenna}

    Wait Until Element Is Not Visible   ${Spinner_Overlay}
    Odota sivun latautuminen
    Siirry Katselutilaan
    Click Element At Coordinates    ${Kartta}  0  20
    Wait Until Element Is Visible   ${FA_otsikko}
    Element Should Contain          ${FA_VAK_Rajoitus_Tyyppi}  Rajoitus: Ryhmän A vaarallisten aineiden kuljetus

    Log  Leikataan VAK rajoitus ja tarkistetaan talletus
    Siirry Muokkaustilaan
    Wait Until Element Is Not Visible  ${Map_popup}
    Click Element                   css=.${tietolaji} .cut
    Click Element At Coordinates    ${Kartta}  0  20
    Wait Until Element Is Visible   ${FA_VAK_A_DDM}

    Click Element                   ${FA_VAK_A_DDM}
    Click Element                   ${FA_VAK_A_Valinta}
    Click Element                   ${FA_VAK_B_DDM}

    Log  Klikataan karttaa muokkauksen keskellä. Tarkistetaan varoitus.
    Click Element At Coordinates    ${Kartta}  0  -100
    Wait Until Element Is Visible   ${MuokkausVaroitus}
    Click Element                   ${Muokkausvaroitus_Sulje_btn}

    Click Element                   ${FA_header_Tallenna}
    Wait Until Element Is Not Visible   ${Spinner_Overlay}
    Odota sivun latautuminen
    Siirry Katselutilaan
    Odota sivun latautuminen

    Click Element At Coordinates    ${Kartta}  -20  18
    Wait Until Element Is Visible   ${FA_otsikko}
    Element Should Contain          ${FA_VAK_Rajoitus_Tyyppi}  Rajoitus: Ryhmän B vaarallisten aineiden kuljetus

    Click Element At Coordinates    ${Kartta}  20  18
    Wait Until Element Is Visible   ${FA_otsikko}
    Page Should Not Contain         Rajoitus: Ryhmän A vaarallisten aineiden kuljetus

    Log  Putsataan testipaikka
    Siirry Muokkaustilaan
    Wait Until Element Is Not Visible  ${Map_popup}
    Click Element                   css=.${tietolaji} .rectangle
    Click Element At Coordinates    ${Kartta}  -50  -30
    Click Element At Coordinates    ${Kartta}  50  100
    Click Element                   ${FA_header_Tallenna}

##########################
### Sisäiset Keywordit ###
##########################

*** Variables ***
${FA_VAK_Rajoitus_Tyyppi}           css=.form-control-static.existing-prohibition
${FA_VAK_A_DDM}                     css=.hazardousMaterialTransportProhibition-a .prohibition-type .select
${FA_VAK_A_Valinta}                 css=.hazardousMaterialTransportProhibition-a [value="25"]
${FA_VAK_B_DDM}                     css=.hazardousMaterialTransportProhibition-b .delete.btn-delete
