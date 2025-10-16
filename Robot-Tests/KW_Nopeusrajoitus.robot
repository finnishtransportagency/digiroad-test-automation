*** Settings ***
Documentation       Pageobject for speedlimit (Nopeusrajoitus)
Resource    common_keywords.robot


*** Keywords ***

Nopeusrajoitus_1  [arguments]  ${testipaikka}
    vaihda tietolaji                            ${TL_Nopeusrajoitus_RB}
    Paikanna osoite                             ${testipaikka}
    Zoomaa kartta                               5  50 m

    #Nollataan rajoitus tarvittaessa
    Click Element At Coordinates                ${Kartta}  10  0
    ${status}=  Run Keyword And Return Status   Element Should Contain  ${FA_Nopeusrajoitus}  60 km/h
    Run Keyword If  ${status}==False            Nollaa Nopeusrajoitus

    Odota sivun latautuminen
    Siirry Muokkaustilaan
    Log  Leikataan rajoitus kahteen osaan 206.86
    Log  Katkaisun jälkeen peruuta-nappi toimii 206.91
    Element should be visible                   css=.speed-limits .cut
    Click Element                               css=.speed-limits .cut
    Click Element At Coordinates                ${Kartta}  0  20
    Wait Until Element Is Visible               ${FA_otsikko}
    Click Element                               ${FA_footer_Peruuta}
    Log  Katkaisun jälkeen peruuta-napin painalluksen jälkeen katkaisutyökalu jää käyttöön 206.92
    Element Should Be Visible                   css=.speed-limits .cut.active
    Log  Katkaisun jälkeen peruuta-napin painalluksen jälkeen yksittäisen nopeusrajoituksen valinta poistuu 206.93
    Element Should Not Be Visible               ${FA_otsikko}

    #Pop-up joudutaan sulkemaan turhaan. Bugi DROTH-2852
    Click Element At Coordinates                ${Kartta}  0  20
    Wait Until Element Is Visible               ${MuokkausVaroitus}
    Click Element                               ${Muokkausvaroitus_Sulje_btn}

    Log  Asetetaan leikkauskohdan rajoitukset
    Wait Until Element Is Visible               ${FA_Rajoitus_A}
    Click Element                               ${FA_Rajoitus_A}
    Click Element                               ${FA_Rajoitus_A_DDM}
    Click Element                               ${FA_Rajoitus_B}
    Click Element                               ${FA_Rajoitus_B_DDM}

    Log  "Olet muokannut.." -dialogi jos katkaisun jälkeen klikkaa karttaa ennen tallennusta 206.104
    Click Element At Coordinates                ${Kartta}  -100  -100
    Wait Until Element Is Visible               ${MuokkausVaroitus}
    Element Should Contain                      ${MuokkausVaroitus}  ${MuokkausVaroitus_teksti}
    Click Element                               ${Muokkausvaroitus_Sulje_btn}

    Click Element                               ${FA_footer_Tallenna}
    Wait Until Element Is Not Visible           ${Spinner_Overlay}
    Odota sivun latautuminen
    Log  Yhden linkin mittaisen nopeusrajoituksen katkaisun ja tallennuksen jälkeen valintatyökalu jää aktiiviseksi, 206.101
    Element should be visible                   css=.panel-group:not([style="display: none;"]) .action.select.action
    Siirry Katselutilaan

    Log  Yhden linkin mittaisen nopeusrajoituksen katkaisun jälkeen uudet nopeusrajoituspätkien arvot ovat muokattavissa 206.102
    Click Element At Coordinates                ${Kartta}  10  0
    Wait Until Element Is Visible               ${FA_otsikko}
    Element Should Contain                      ${FA_Nopeusrajoitus}  120 km/h
    Siirry Muokkaustilaan
    Click Element                               ${Popup_NopeusRajoitus}
    Click Element                               ${Popup_NopeusRajoitus_DDM}
    Click Element                               ${FA_header_Tallenna}
    Wait Until Element Is Not Visible           ${Spinner_Overlay}
    Odota sivun latautuminen
    Siirry Katselutilaan


    Click Element At Coordinates                ${Kartta}  0  40
    Wait Until Element Is Visible               ${FA_otsikko}
    Element Should Contain                      ${FA_Nopeusrajoitus}  50 km/h
    Siirry Muokkaustilaan
    Click Element                               ${Popup_NopeusRajoitus}
    Click Element                               ${Popup_NopeusRajoitus_DDM}
    Click Element                               ${FA_header_Tallenna}
    Wait Until Element Is Not Visible           ${Spinner_Overlay}
    Odota sivun latautuminen

    Log  Valittaessa nopeusrajoituksen ominaisuustietonäkymässä näkyy nopeusrajoituksen ID, lisäys ja muokkaus tiedot. 206.30
    Siirry Katselutilaan
    Click Element At Coordinates                ${Kartta}  0  20
    Wait Until Element Is Visible               ${FA_otsikko}
    ${date}=  Get Current Date                  result_format=%d.%m.%Y
    Element Should Contain                      ${FA_Muokattu_viimeksi}  ${date}
    #Element Should Contain                      ${FA_otsikko}  87408330


Nopeusrajoitus_2  [arguments]  ${testipaikka}
    Log Many  Siirryttäessä pysäkkien lisäystilasta nopeusrajoituksiin, ei lisäystyökalu-valinta säily.
    ...  Nopeusrajoitukset näkyvät vain, kun zoomitaso on alle 200m.
    ...  Tuplaklikkaamalla saadaan valittua yksittäinen linkki.
    Siirry Muokkaustilaan
    click element                               ${Muokkaustila_AddTool}
    vaihda tietolaji                            ${TL_Nopeusrajoitus_RB}
    #Tarkistaa valinta työkalun olevan aktiivinen
    Element should be visible                   css=.panel-group:not([style="display: none;"]) .action.select.action
    Siirry Katselutilaan

    Paikanna osoite                             ${testipaikka}
    Odota sivun latautuminen
    Click Element At Coordinates                ${Kartta}  0  20
    Wait Until Element Is Visible               ${FA_otsikko}
    Element Should Contain                      ${FA_linkkien_lukumaara}  15
    Double Click Element At Coordinates         ${Kartta}  0  20
    Element Should Contain                      ${FA_linkkien_lukumaara}  1

    Log  Säilytä nopeusrajoitusvalinta, kun siirrytään muokkaustilaan 206.109
    ${id}=  Get Text                            ${FA_otsikko}
    Siirry Muokkaustilaan
    Element Should Contain                      ${FA_otsikko}  ${id}

    Log  Tarkistaa, että nopeusrajoitukset ovat laskevassa järjestyksessä.
    Click Element                               ${Popup_NopeusRajoitus}
    FOR  ${i}  IN RANGE  2  12
        ${n}=  Evaluate  -${i}+1
        Element Should Contain  css=div.form-group.editable > select option:nth-child(${i})  ${Nopeusrajoitukset}[${n}]
    END

    Siirry Katselutilaan

    Click Element At Coordinates                ${Kartta}  50  50
    Sleep  5 s
    Element Should Not Be Visible               ${FA_otsikko}

    Log  Nopeusrajoitusten kohdalla näkyy teksti:"Zoomaa lähemmäksi, jos haluat nähdä kohteita".
    Click Element                               ${zoombar_minus}
    Element should be visible                   ${Map_popup}
    Element should contain                      ${Map_popup}  ${Zoom_popup_context}
    Odota sivun latautuminen
    Click Element At Coordinates                ${Kartta}  0  20
    Repeat Keyword  10 s  Element Should Not Be Visible    ${FA_otsikko}

Nopeusrajoitus 3  [arguments]  ${testipaikka}
    vaihda tietolaji                            ${TL_Nopeusrajoitus_RB}
    Paikanna osoite                             ${testipaikka}
    Odota sivun latautuminen

    #Hankala tarkistaa onko kaikki kohdat ==60, nollataan joka kerta.
    Nollaa Nopeusrajoitus

    Siirry Muokkaustilaan
    Click Element                               css=.${TL_Nopeusrajoitus_RB} .polygon

    Log  Monivalinnan voi peruuttaa 206.116
    Suorita monivalinta
    Click Element                               ${Popup_NopeusRajoitus}
    Click Element                               ${Popup_NopeusRajoitus_120}
    Click Element                               ${FA_header_Peruuta}
    Click Element                               ${Muokkaustila_SelectTool}
    Siirry Katselutilaan
    sleep  1 s
    Click Element at Coordinates                ${Kartta}  0  20
    Wait Until Element contains                 ${FA_Nopeusrajoitus}  60 km/h
    #Element Should Contain                      ${FA_Nopeusrajoitus}  60 km/h

    Log  Ei voi aloittaa monivalintaa, jos on muokannut jotain toista nopeusrajoitusta ensin 206.118
    Siirry Muokkaustilaan
    Click Element                               ${Popup_NopeusRajoitus}
    Click Element                               ${Popup_NopeusRajoitus_120}
    Click Element                               css=.${TL_Nopeusrajoitus_RB} .polygon
    Wait Until Element Is Visible               ${MuokkausVaroitus}
    Wait Until Element Is Not Visible           ${Map_popup}
    Click Element                               ${Muokkausvaroitus_Sulje_btn}
    Click Element                               ${FA_footer_Peruuta}

    Log  Talletetaan rajoitus monivalintatyökalulla.
    Click Element                               css=.${TL_Nopeusrajoitus_RB} .polygon
    Suorita monivalinta
    Click Element                               ${Popup_NopeusRajoitus}
    Click Element                               ${Popup_NopeusRajoitus_120}
    Click Element                               ${FA_header_Tallenna}
    Wait Until Element Is Not Visible           ${Spinner_Overlay}
    Odota sivun latautuminen

    Log  Tarkistetaan edellinen talletus, sekä asetetaan rajoitus\=60 km/h
    Siirry Katselutilaan
    Double Click Element At Coordinates         ${Kartta}  0  20
    Wait Until Element Is Visible               ${FA_otsikko}
    Element Should Contain                      ${FA_Nopeusrajoitus}  120 km/h
    Siirry Muokkaustilaan
    Click Element                               css=.${TL_Nopeusrajoitus_RB} .polygon
    Suorita monivalinta
    Click Element                               ${Popup_NopeusRajoitus}
    Click Element                               ${Popup_NopeusRajoitus_DDM}
    Click Element                               ${FA_header_Tallenna}
    Wait Until Element Is Not Visible           ${Spinner_Overlay}
    Odota sivun latautuminen

Nopeusrajoitus 4  [arguments]  ${testipaikka}
    Vaihda tietolaji                            ${TL_Nopeusrajoitus_RB}
    Paikanna osoite                             ${testipaikka}
    Zoomaa kartta                               10  5 m
    Odota sivun latautuminen

    Click Element At Coordinates                ${Kartta}  0  20
    Wait Until Element Is Visible               ${FA_otsikko}
    Element SHould Not Be Visible               ${FA_Jaa_Nopeusrajoitus}

    Log  Peruuta-painike peruuttaa molempisuuntaisen nopeusrajoituksen jaon, rivi:290
    Siirry Muokkaustilaan
    Click Element                               ${FA_Jaa_Nopeusrajoitus}
    Click Element                               ${FA_Rajoitus_A}
    Click Element                               ${FA_Rajoitus_A_DDM}
    Click Element                               ${FA_Rajoitus_B}
    Click Element                               ${FA_Rajoitus_B_DDM}
    Click Element                               ${FA_footer_Peruuta}
    Click Element At Coordinates                ${Kartta}  0  20
    Wait Until Element Is Visible               ${FA_otsikko}

    Log  Kaksisuuntaiseksi jaettua nopeusrajoitusta ei voi tallentaa, jos molemmilla nopeusrajoituksilla on sama rajoitusarvo, rivi:289, BUGI talletuksen voitehdä.
    Click Element                               ${FA_Jaa_Nopeusrajoitus}
    Element should be visible                  css=.save[disabled]
    Log  Painetaan tallennus nappia, mitään ei pitäisi tapahtua.
    Click Element                               ${FA_footer_Tallenna}

    Log  "Jaa nopeusrajoitus kaksisuuntaiseksi"-painike luo kartalle nopeusrajoituksen kohdalle kaksi erisuuntaista nopeusrajoitusta Rivi 288
    Click Element                               ${FA_Rajoitus_A}
    Click Element                               ${FA_Rajoitus_A_DDM}
    Click Element                               ${FA_Rajoitus_B}
    Click Element                               ${FA_Rajoitus_B_DDM}
    Click Element                               ${FA_footer_Tallenna}
    Wait Until Element Is Not Visible           ${Spinner_Overlay}
    Odota sivun latautuminen

    Log  Nollataan Rajoitukset
    Click Element At Coordinates                ${Kartta}  0  -55
    Wait Until Element Is Visible               ${FA_otsikko}
    Click Element                               ${Popup_NopeusRajoitus}
    Click Element                               ${Popup_NopeusRajoitus_DDM}
    Click Element                               ${FA_footer_Tallenna}
    Wait Until Element Is Not Visible           ${Spinner_Overlay}
    Odota sivun latautuminen

    Click Element At Coordinates                ${Kartta}  0  85
    Wait Until Element Is Visible               ${FA_otsikko}
    Click Element                               ${Popup_NopeusRajoitus}
    Click Element                               ${Popup_NopeusRajoitus_DDM}
    Click Element                               ${FA_footer_Tallenna}
    Wait Until Element Is Not Visible           ${Spinner_Overlay}
    Odota sivun latautuminen

    Siirry Katselutilaan
    Click Element At Coordinates                ${Kartta}  0  20
    Wait Until Element Is Visible               ${FA_otsikko}
    Element Should Contain                      ${FA_Nopeusrajoitus}  60 km/h


##########################
### Sisäiset Keywordit ###
##########################

Nollaa Nopeusrajoitus
    Siirry Muokkaustilaan
    Element should be visible                   css=.${TL_Nopeusrajoitus_RB} .polygon
    Click Element                               css=.${TL_Nopeusrajoitus_RB} .polygon
    Suorita monivalinta
    Click Element                               ${Popup_NopeusRajoitus}
    Click Element                               ${Popup_NopeusRajoitus_60}
    Click Element                               ${FA_header_Tallenna}
    Wait Until Element Is Not Visible           ${Spinner_Overlay}
    Odota sivun latautuminen
    Siirry Katselutilaan


*** Variables ***
${FA_Rajoitus_A}            css=.speed-limit-a
${FA_Rajoitus_A_DDM}        css=.speed-limit-a option:nth-child(2)
${FA_Rajoitus_B}            css=.speed-limit-b
${FA_Rajoitus_B_DDM}        css=.speed-limit-b option:nth-child(8)
${FA_Nopeusrajoitus}        css=#feature-attributes-form > div > div > div:nth-child(4) > p
${Popup_NopeusRajoitus}     css=div.form-group.editable > select
${Popup_NopeusRajoitus_DDM}  css=div.form-group.editable > select option:nth-child(7)
${Popup_NopeusRajoitus_120}  css=div.form-group.editable > select option:nth-child(2)
${Popup_NopeusRajoitus_60}  css=div.form-group.editable > select option:nth-child(7)
${FA_Jaa_Nopeusrajoitus}    id=separate-limit