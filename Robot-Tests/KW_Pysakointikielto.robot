*** Settings ***
Documentation       Keywords for Pysäköintikielto

Resource    common_keywords.robot

*** Keywords ***
Pysakointi_1  [Arguments]  ${Tietolaji}  ${Testipaikka}
    Log  Siirrytään testipaikkaan ja nollataan kohteen rajoitus
    Siirry Testipaikkaan                ${Tietolaji}  ${Testipaikka}
    Click Element At Coordinates        ${Kartta}  20  19
    Wait Until Element Is Visible       ${FA_otsikko}
    ${status}=  Run Keyword And Return Status  Element Should Contain  ${FA_Pysakointikielto}  ei ole
    Run Keyword If  ${status}==False  Nollaa Pysakointikielto

    Click Element At Coordinates        ${Kartta}  -20  20
    Wait Until Element Is Visible       ${FA_otsikko}
    ${status}=  Run Keyword And Return Status  Element Should Contain  ${FA_Pysakointikielto}  ei ole
    Run Keyword If  ${status}==False  Nollaa Pysakointikielto

    Log  Luodaan uusi pysäköintikielto
    Siirry Muokkaustilaan
    Click Element                       ${FA_Lisaa_Pysakointikielto}
    Click Element                       ${FA_Pysakointirajoitus}
    Click Element                       ${FA_Pysakointirajoitus_DDM}
    Click Element                       ${FA_Pysakointi_aika}
    Click Element                       ${FA_Pysakointi_aika_DDM}
    Click Element                       ${FA_footer_Tallenna}
    Wait Until Element Is Not Visible   ${Spinner_Overlay}
    Odota sivun latautuminen
    Siirry Katselutilaan

    Log  Tarkistetaan uuden rajoituksen tiedot
    Click Element At Coordinates        ${Kartta}  0  20
    Wait Until Element Is Visible       ${FA_otsikko}
    Element should Contain              ${FA_Pysakointikielto}  on
    Element should Contain              ${FA_Pysakointirajoitus_Tyyppi}  Pysäköinti kielletty
    Element should Contain              ${FA_Pysakointi_Voimassaoloaika}  La 0:00 - 24:00

    #Kopio Nopeusrajoitus testistä 3.
    Siirry Muokkaustilaan
    Log  Leikataan rajoitus kahteen osaan
    Log  Katkaisun jälkeen peruuta-nappi toimii
    Element should be visible                   css=.${Tietolaji} .cut
    Click Element                               css=.${Tietolaji} .cut
    Click Element At Coordinates                ${Kartta}  0  20
    Wait Until Element Is Visible               ${FA_Pysakointikielto_A}
    Click Element                               ${FA_footer_Peruuta}
    Log  Katkaisun jälkeen peruuta-napin painalluksen jälkeen katkaisutyökalu jää käyttöön
    Element Should Be Visible                   css=.${Tietolaji} .cut.active
    Log  Katkaisun jälkeen peruuta-napin painalluksen jälkeen yksittäisen Pysäköintirajoituksen valinta poistuu
    Element Should Not Be Visible               ${FA_Pysakointikielto_A}

    #Pop-up joudutaan sulkemaan turhaan. Bugi DROTH-2852
    Click Element At Coordinates                ${Kartta}  0  20
    # Wait Until Element Is Visible               ${MuokkausVaroitus}
    # Click Element                               ${Muokkausvaroitus_Sulje_btn}

    Log  Asetetaan leikkauskohdan rajoitukset
    Wait Until Element Is Visible               ${FA_Pysakointikielto_A}
    Click Element                               ${FA_Pysakointikielto_A}
    Click Element                               ${FA_Pysakointikielto_A_DDM}
    Click Element                               ${FA_Pysakointikielto_B}
    Click Element                               ${FA_Pysakointikielto_B_DDM}

    Log  "Olet muokannut.." -dialogi jos katkaisun jälkeen klikkaa karttaa ennen tallennusta
    Click Element At Coordinates                ${Kartta}  -100  -100
    Wait Until Element Is Visible               ${MuokkausVaroitus}
    Element Should Contain                      ${MuokkausVaroitus}  ${MuokkausVaroitus_teksti}
    Click Element                               ${Muokkausvaroitus_Sulje_btn}

    Click Element                               ${FA_footer_Tallenna}
    Wait Until Element Is Not Visible           ${Spinner_Overlay}
    Odota sivun latautuminen
    Log  Yhden linkin mittaisen Pysäköintirajoituksen katkaisun ja tallennuksen jälkeen valintatyökalu jää aktiiviseksi, 206.101
    Element should be visible                   css=.panel-group:not([style="display: none;"]) .action.select.action
    Siirry Katselutilaan


    Log  Yhden linkin mittaisen Pysäköintirajoituksen katkaisun jälkeen uudet Pysäköintirajoituksen arvot ovat muokattavissa 206.102
    Click Element At Coordinates                ${Kartta}  20  19
    Wait Until Element Is Visible               ${FA_otsikko}
    Element Should Contain                      ${FA_Pysakointirajoitus_Tyyppi}  Pysäköinti kielletty
    Nollaa Pysakointikielto


    Click Element At Coordinates                ${Kartta}  -20  21
    Wait Until Element Is Visible               ${FA_otsikko}
    Element Should Contain                      ${FA_Pysakointirajoitus_Tyyppi}  Pysähtyminen kielletty
    Nollaa Pysakointikielto

    Log  Valittaessa Pysäköintirajoituksen ominaisuustietonäkymässä näkyy Pysäköintirajoituksen ID, lisäys ja muokkaus tiedot. 206.30
    Click Element At Coordinates                ${Kartta}  0  20
    Wait Until Element Is Visible               ${FA_otsikko}
    Element Should Contain                     ${FA_Pysakointikielto}  ei ole

Pysakointi_2  [Arguments]  ${Tietolaji}  ${Testipaikka}
    #Kopio nopeusrajotus 3
    Siirry Testipaikkaan  ${Tietolaji}  ${Testipaikka}
    Odota sivun latautuminen

    Siirry Muokkaustilaan
    Click Element                               css=.${Tietolaji} .polygon

    Log  Monivalinnan voi peruuttaa 206.116
    Suorita monivalinta
    Click Element                               ${FA_Lisaa_Pysakointikielto}
    Click Element                               ${FA_Pysakointirajoitus}
    Click Element                               ${FA_Pysakointirajoitus_DDM}
    Click Element                               ${FA_header_Peruuta}
    Click Element                               ${Muokkaustila_SelectTool}

    Siirry Katselutilaan
    sleep  1 s
    Click Element at Coordinates                ${Kartta}  0  20
    Wait Until Element contains                 ${FA_Pysakointikielto}  ei ole

    Log  Ei voi aloittaa monivalintaa, jos on muokannut jotain toista pysäköintikieltoa ensin 206.118
    Siirry Muokkaustilaan
    Click Element                               ${FA_Lisaa_Pysakointikielto}
    Click Element                               css=.${Tietolaji} .polygon
    Wait Until Element Is Visible               ${MuokkausVaroitus}
    Wait Until Element Is Not Visible           ${Map_popup}
    Click Element                               ${Muokkausvaroitus_Sulje_btn}
    Click Element                               ${FA_footer_Peruuta}

    Log  Talletetaan rajoitus monivalintatyökalulla.
    Click Element                               css=.${Tietolaji} .polygon
    Suorita monivalinta
    Click Element                               ${FA_Lisaa_Pysakointikielto}
    Click Element                               ${FA_Pysakointirajoitus}
    Click Element                               ${FA_Pysakointirajoitus_DDM}
    Click Element                               ${FA_Pysakointi_aika}
    Click Element                               ${FA_Pysakointi_aika_DDM}
    Click Element                               ${FA_header_Tallenna}
    Wait Until Element Is Not Visible           ${Spinner_Overlay}
    Odota sivun latautuminen

    Log  Tarkistetaan edellinen talletus, sekä asetetaan pysäköintikiellon sunnuntaille.
    Siirry Katselutilaan
    Click Element At Coordinates                ${Kartta}  0  20
    Wait Until Element Is Visible               ${FA_otsikko}
    Element Should Contain                      ${FA_Pysakointirajoitus_Tyyppi}  Pysäköinti kielletty
    Siirry Muokkaustilaan
    Click Element                               css=.${Tietolaji} .polygon
    Suorita monivalinta
    Click Element                               ${FA_header_Tallenna}
    Wait Until Element Is Not Visible           ${Spinner_Overlay}
    Odota sivun latautuminen

Pysakointi_3  [Arguments]  ${Tietolaji}  ${Testipaikka}
    Log  Tarkistetaan olemassa oleva pysäköintirajoitus
    Siirry Testipaikkaan                ${Tietolaji}  ${Testipaikka}
    Odota sivun latautuminen
    Click Element At Coordinates        ${Kartta}  0  20
    Wait Until Element Is Visible       ${FA_otsikko}
    Element Should Contain              ${FA_otsikko}  104294573
    Element Should Contain              ${FA_Pysakointikielto}  on
    Element Should Contain              ${FA_Pysakointirajoitus_Tyyppi}  Pysäköinti kielletty


##########################
### Sisäiset Keywordit ###
##########################

Nollaa Pysakointikielto
    Siirry Muokkaustilaan
    Click Element                       ${FA_Ei_Pysakointikieltoa}
    Click Element                       ${FA_footer_Tallenna}
    Wait Until Element Is Not Visible   ${Spinner_Overlay}
    Odota sivun latautuminen
    Siirry Katselutilaan
    Click Element At Coordinates        ${Kartta}  0  20
    Wait Until Element Is Visible       ${FA_otsikko}
    Element Should Contain              ${FA_Pysakointikielto}  ei ole



*** Variables ***
${FA_Pysakointikielto}              css=.form-control-static.parking-prohibition
${FA_Ei_Pysakointikieltoa}          css=[value=disabled]
${FA_Lisaa_Pysakointikielto}        css=[value=enabled]
${FA_Pysakointirajoitus}            css=.form-control.parking-prohibition
${FA_Pysakointirajoitus_DDM}        css=.form-control.parking-prohibition option:nth-child(3)
${FA_Pysakointi_aika}               css=.new-validity-period .select
${FA_Pysakointi_aika_DDM}           css=.new-validity-period .select option:nth-child(4)
${FA_Pysakointirajoitus_Tyyppi}     css=.input-unit-combination .form-group:nth-child(1) .form-control-static
${FA_Pysakointi_Voimassaoloaika}    css=.input-unit-combination .form-group:nth-child(2) .form-control-static li

${FA_Pysakointikielto_A}            css=.form-editable-parking-prohibition-a .form-control.parking-prohibition
${FA_Pysakointikielto_A_DDM}        css=.form-editable-parking-prohibition-a .form-control.parking-prohibition option:nth-child(2)
${FA_Pysakointikielto_B}            css=.form-editable-parking-prohibition-b .form-control.parking-prohibition
${FA_Pysakointikielto_B_DDM}        css=.form-editable-parking-prohibition-b .form-control.parking-prohibition option:nth-child(3)