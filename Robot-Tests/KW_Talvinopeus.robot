#Joni Laari    Sitowise    2023
*** Settings ***
Documentation        Pageobject for winter speed limit (talvinopeusrajoitus)
Resource    common_keywords.robot


*** Keywords ***
Talvinopeus perustestit    [arguments]    ${testipaikka}
    Testin Aloitus
    Vaihda Tietolaji        ${TL_Talvinopeusrajoitus_RB}
    Paikanna osoite                             ${testipaikka}
    Odota sivun latautuminen
    Click Element At Coordinates                ${Kartta}  0  20
    Wait Until Element Is Visible               ${FA_otsikko}
    Element Should Contain                      ${FA_linkkien_lukumaara}  1
    Click Element At Coordinates                ${Kartta}  100  0
    Click Element At Coordinates         ${Kartta}  0  20
    Wait Until Element Is Visible               ${FA_linkkien_lukumaara}
    Element Should Contain                      ${FA_linkkien_lukumaara}  1

    Log  Säilytä nopeusrajoitusvalinta, kun siirrytään muokkaustilaan
    ${id}=  Get Text                            ${FA_otsikko}
    Siirry Muokkaustilaan
    Element Should Contain                      ${FA_otsikko}  ${id}

    Log  Tarkistaa, että nopeusrajoitukset ovat laskevassa järjestyksessä.
    Click Element                               ${Popup_TalviNopeusRajoitus}
    FOR  ${i}  IN RANGE  2  5
        ${n}=  Evaluate  ${i}-1
        Element Should Contain  xpath=/html/body/div[1]/div[2]/main/article/div/div/div[4]/div/div/div[3]/select  ${Talvinopeusrajoitukset}[${n}]
        Click Element    css=#feature-attributes-form > div > div > div.form-elements-container > div > div > div.input-unit-combination > select option:nth-child(${n})
        Capture Page Screenshot
    END

    #Siirry Katselutilaan
    Click Element            ${FA_footer_Peruuta}
    Sleep  5 s
    Element Should Not Be Visible               ${FA_otsikko}

    Log  Nopeusrajoitusten kohdalla näkyy teksti:"Zoomaa lähemmäksi, jos haluat nähdä kohteita".
    Click Element                               ${zoombar_minus}
    Element should be visible                   ${Map_popup}
    Element should contain                      ${Map_popup}  ${Zoom_popup_context}
    Odota sivun latautuminen
    Click Element At Coordinates                ${Kartta}  0  20
    Repeat Keyword  10 s  Element Should Not Be Visible    ${FA_otsikko}


Talvinopeusrajoitus monivalinta    [arguments]    ${testipaikka}
    Testin Aloitus
    Paikanna osoite                             ${testipaikka}
    vaihda tietolaji                            ${TL_Talvinopeusrajoitus_RB}
    Siirry Muokkaustilaan
    Wait Until Element Is Enabled               ${Muokkaustila_PolygonTool}
    Click Element                               ${Muokkaustila_PolygonTool}
    Suorita monivalinta
    Wait Until Element Is Visible               ${Popup_valikko_talvinopeus}
    Element Should Be Visible                   ${Popup_valikko_talvinopeus}
    Element Should Be Enabled                   ${FA_header_Tallenna}
    Click Element                               ${FA_header_Peruuta}

    Siirry Katselutilaan
    sleep  1 s
    Click Element at Coordinates                ${Kartta}  0  20
    Wait Until Element contains                 ${FA_Talvinopeusrajoitus}  ${talvinopeudet_lista}[2] km/h

    Log  Ei voi aloittaa monivalintaa, jos on muokannut jotain toista nopeusrajoitusta ensin 206.118
    Siirry Muokkaustilaan
    Click Element                               ${Popup_TalviNopeusRajoitus}
    Click Element                               css=.form-control.winter-speed-limits
    Press Keys    None    DOWN
    Press Keys    None    DOWN
    Press Keys    None    ENTER
    Click Element                               css=.${TL_Talvinopeusrajoitus_RB} .polygon
    Click Element At Coordinates                ${Kartta}    100    100
    Wait Until Element Is Visible               ${MuokkausVaroitus}
    Wait Until Element Is Not Visible           ${Map_popup}
    Click Element                               ${Muokkausvaroitus_Sulje_btn}
    Click Element                               ${FA_footer_Peruuta}

    Log  Talletetaan rajoitus monivalintatyökalulla.
    Click Element                               css=.${TL_Talvinopeusrajoitus_RB} .polygon
    Suorita monivalinta
    Select Radio Button                         winter-speed-limits    enabled
    Click Element                               ${Popup_TalviNopeusRajoitus_DDM}
    #Click Element                               ${Popup_TalviNopeusRajoitus_100}
    Click Element                               ${FA_header_Tallenna}
    Wait Until Element Is Not Visible           ${Spinner_Overlay}
    Odota sivun latautuminen

    Log  Tarkistetaan edellinen talletus, sekä asetetaan rajoitus\=60 km/h
    Siirry Katselutilaan
    Click Element At Coordinates         ${Kartta}  0  20
    Wait Until Element Is Visible               ${FA_otsikko}
    Element Should Contain                      ${FA_Talvinopeusrajoitus}  100 km/h
    Siirry Muokkaustilaan
    Click Element                               css=.${TL_Talvinopeusrajoitus_RB} .polygon
    Suorita monivalinta
    Select Radio Button    winter-speed-limits    enabled
    Click Element    css=body > div.container > div.modal-overlay.mass-update-modal > div > div.form-elements-container > div > div > div.input-unit-combination > select
    Press Keys    None    DOWN
    Press Keys    None    DOWN
    Press Keys    None    DOWN
    Press Keys    None    Enter
    #Click Element                               ${Popup_TalviNopeusRajoitus}
    #Click Element                               ${Popup_TalviNopeusRajoitus_DDM}
    Click Element                               ${FA_header_Tallenna}
    Wait Until Element Is Not Visible           ${Spinner_Overlay}
    Odota sivun latautuminen


Talvinopeusrajoituksen katkaisu    [arguments]    ${testipaikka}
    Testin Aloitus
    Log    Testataan talvinopeusrajoituksen katkaisu.
        Paikanna osoite                             ${testipaikka}
    vaihda tietolaji                            ${TL_Talvinopeusrajoitus_RB}
    Zoomaa kartta                               5  50 m
    Siirry Muokkaustilaan
    Log  Leikataan rajoitus kahteen osaan 206.86
    Log  Katkaisun jälkeen peruuta-nappi toimii 206.91
    Element should be visible                   css=.winterSpeedlimits .cut
    Click Element                               css=.winterSpeedlimits .cut
    Click Element At Coordinates                ${Kartta}  0  20
    Wait Until Element Is Visible               css=#feature-attributes-header > span.edit-mode-title
    Click Element                               ${FA_footer_Peruuta}
    Log  Katkaisun jälkeen peruuta-napin painalluksen jälkeen katkaisutyökalu jää käyttöön
    Element Should Be Visible                   css=.winterSpeedlimits .cut.active
    Log  Katkaisun jälkeen peruuta-napin painalluksen jälkeen yksittäisen nopeusrajoituksen valinta poistuu 206.93
    Element Should Not Be Visible               css=.edit-mode-title

    Click Element At Coordinates    ${Kartta}    0    10
    Wait Until Element Is Visible    css=#feature-attributes-form > div > div > div.form-elements-container > div:nth-child(1)
    Select Radio Button                               ${FA_Talvinopeusrajoitus_A}    enabled
    Radio Button Should Be Set To                     ${FA_Talvinopeusrajoitus_A}    enabled
    Select Radio Button                               ${FA_Talvinopeusrajoitus_B}    enabled
    Radio Button Should Be Set To                     ${FA_Talvinopeusrajoitus_B}    enabled

    Log  "Olet muokannut.." -dialogi jos katkaisun jälkeen klikkaa karttaa ennen tallennusta 206.104
    Click Element At Coordinates                ${Kartta}  -100  -100
    Wait Until Element Is Visible               ${MuokkausVaroitus}
    Element Should Contain                      ${MuokkausVaroitus}  ${MuokkausVaroitus_teksti}
    Click Element                               ${Muokkausvaroitus_Sulje_btn}

    #Element Should Be Enabled                   ${FA_footer_Tallenna}
    Click Element                               ${FA_footer_Peruuta}
    Wait Until Element Is Not Visible           ${Spinner_Overlay}
    Odota sivun latautuminen
    Log  Yhden linkin mittaisen nopeusrajoituksen katkaisun ja tallennuksen jälkeen valintatyökalu jää aktiiviseksi, 206.101
    Element should be visible                   css=.panel-group:not([style="display: none;"]) .action.select.action
    Siirry Katselutilaan

    Log  Yhden linkin mittaisen nopeusrajoituksen katkaisun jälkeen uudet nopeusrajoituspätkien arvot ovat muokattavissa 206.102
    Click Element At Coordinates                ${Kartta}  10  0
    Wait Until Element Is Visible               css=#feature-attributes-header > span
    Element Should Contain                      ${FA_Talvinopeusrajoitus}  80 km/h
    Siirry Muokkaustilaan
    Click Element                               ${Popup_TalviNopeusRajoitus}
    Click Element                               css=#feature-attributes-form > div > div > div.form-elements-container > div > div > div.input-unit-combination > select > option:nth-child(1)
    Press Keys    None    Enter
    Odota sivun latautuminen
    Click Element                               ${FA_footer_Peruuta}
    Wait Until Element Is Not Visible           ${Spinner_Overlay}
    Odota sivun latautuminen
    Siirry Katselutilaan

    Click Element At Coordinates                ${Kartta}  0  40
    #Wait Until Element Is Visible               css=#feature-attributes-header > span.edit-mode-title
    #Element Should Contain                      xpath=//*[@id="feature-attributes-form"]/div/div/div[4]/div/p        80 km/h
    #Click Element                               ${FA_header_Peruuta}
    Click Element At Coordinates    ${Kartta}    200    200
    Wait Until Element Is Not Visible           ${Spinner_Overlay}
    Odota sivun latautuminen

    Log  Valittaessa nopeusrajoituksen ominaisuustietonäkymässä näkyy nopeusrajoituksen ID, lisäys ja muokkaus tiedot. 206.30
    Click Element At Coordinates                ${Kartta}  0  20
    Wait Until Element Is Visible               ${FA_otsikko}
    #${date}=  Get Current Date                  result_format=%d.%m.%Y
    #Element Should Contain                      ${FA_Muokattu_viimeksi}  ${date}
    #Element Should Contain                      ${FA_otsikko}  87408330


Talvinopeusrajoitus kaksisuuntaiseksi    [arguments]    ${testipaikka}
    Testin Aloitus
    Vaihda tietolaji                            ${TL_Talvinopeusrajoitus_RB}
    Paikanna osoite                             ${testipaikka}
    Zoomaa kartta                               10  5 m
    Siirry Muokkaustilaan
    Odota sivun latautuminen

    Click Element At Coordinates                ${Kartta}  0  20
    Wait Until Element Is Visible               ${FA_otsikko}
    Element Should Be Visible               ${FA_Jaa_Nopeusrajoitus}

    Log  Peruuta-painike peruuttaa molempisuuntaisen nopeusrajoituksen jaon, rivi:290
    Click Element                               ${FA_Jaa_Nopeusrajoitus}
    Click Element                               ${FA_Talvinopeusrajoitus_A}
    Click Element                               ${FA_Talvinopeusrajoitus_A_DDM}
    Click Element                               ${FA_Talvinopeusrajoitus_B}
    Click Element                               ${FA_Talvinopeusrajoitus_B_DDM}
    Click Element                               ${FA_footer_Peruuta}
    Click Element At Coordinates                ${Kartta}  0  20
    Wait Until Element Is Visible               ${FA_otsikko}

    Log  Kaksisuuntaiseksi jaettua nopeusrajoitusta ei voi tallentaa, jos molemmilla nopeusrajoituksilla on sama rajoitusarvo, rivi:289, BUGI talletuksen voitehdä.
    Click Element                               ${FA_Jaa_Nopeusrajoitus}
    Element should be visible                  css=.save[disabled]
    Log  Painetaan tallennus nappia, mitään ei pitäisi tapahtua.
    Click Element                               ${FA_footer_Tallenna}

    Log  "Jaa nopeusrajoitus kaksisuuntaiseksi"-painike luo kartalle nopeusrajoituksen kohdalle kaksi erisuuntaista nopeusrajoitusta Rivi 288
    Click Element                               ${FA_Talvinopeusrajoitus_A}
    Click Element                               ${FA_Talvinopeusrajoitus_A_DDM}
    Click Element                               ${FA_Talvinopeusrajoitus_B}
    Click Element                               ${FA_Talvinopeusrajoitus_B_DDM}
    #Element Should Be Enabled                   ${FA_footer_Tallenna}
    Click Element                               ${FA_footer_Peruuta}
    Wait Until Element Is Not Visible           ${Spinner_Overlay}
    Odota sivun latautuminen

    Siirry Katselutilaan
    Click Element At Coordinates                ${Kartta}  0  20
    Wait Until Element Is Visible               ${FA_otsikko}
    Element Should Contain                      ${FA_Talvinopeusrajoitus}  80 km/h


*** Variables ***
${aloitussivu}                      css=.panel-group:not([style="display: none;"]) .action.select.action
${Popup_TalviNopeusRajoitus}        css=#feature-attributes-form > div > div > div.form-elements-container > div > div > div.input-unit-combination > select
${Popup_TalviNopeusRajoitus_100}        css=#feature-attributes-form > div > div > div.form-elements-container > div > div > div.input-unit-combination > select option:nth-child(2)
${Popup_TalviNopeusRajoitus_DDM}        css=body > div.container > div.modal-overlay.mass-update-modal > div > div.form-elements-container > div > div > div.input-unit-combination > select
${Popup_valikko_talvinopeus}                css=body > div.container > div.modal-overlay.mass-update-modal > div > div.form-elements-container > div
${FA_Talvinopeusrajoitus}                   css=#feature-attributes-form > div > div > div.form-elements-container > div
${FA_Talvinopeusrajoitus_A}                   winter-speed-limits-a
${FA_Talvinopeusrajoitus_B}                   winter-speed-limits-b
${FA_Talvinopeusrajoitus_A_DDM}                 css=#feature-attributes-form > div > div > div.form-elements-container > div:nth-child(1) > div > div.input-unit-combination > select
${FA_Talvinopeusrajoitus_B_DDM}                css=#feature-attributes-form > div > div > div.form-elements-container > div:nth-child(2) > div > div.input-unit-combination > select