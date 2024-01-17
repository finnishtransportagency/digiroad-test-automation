#Joni Laari    Sitowise    2023
*** Settings ***
Documentation        Pageobject for winter speed limit (talvinopeusrajoitus)
Resource    common_keywords.robot

*** Keywords ***

Talvinopeus perustestit    [arguments]    ${testipaikka}
    Vaihda Tietolaji        ${TL_Talvinopeusrajoitus_RB}
    Paikanna osoite                             ${testipaikka}
    Odota sivun latautuminen
    Click Element At Coordinates                ${Kartta}  0  20
    Wait Until Element Is Visible               ${FA_otsikko}
    Element Should Contain                      ${FA_linkkien_lukumaara}  5
    Click Element At Coordinates                ${Kartta}  100  0
    Double Click Element At Coordinates         ${Kartta}  0  20
    Wait Until Element Is Visible               ${FA_linkkien_lukumaara}
    Element Should Contain                      ${FA_linkkien_lukumaara}  1

    Log  Säilytä nopeusrajoitusvalinta, kun siirrytään muokkaustilaan 206.109
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
    vaihda tietolaji                            ${TL_Talvinopeusrajoitus_RB}
    Paikanna osoite                             ${testipaikka}
    Odota sivun latautuminen

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
    Wait Until Element contains                 ${FA_Nopeusrajoitus}  60 km/h

    Log  Ei voi aloittaa monivalintaa, jos on muokannut jotain toista nopeusrajoitusta ensin 206.118
    Siirry Muokkaustilaan
    Click Element                               ${Popup_NopeusRajoitus}
    Click Element                               ${Popup_NopeusRajoitus_120}
    Click Element                               css=.${TL_Talvinopeus_RB} .polygon
    Wait Until Element Is Visible               ${MuokkausVaroitus}
    Wait Until Element Is Not Visible           ${Map_popup}
    Click Element                               ${Muokkausvaroitus_Sulje_btn}
    Click Element                               ${FA_footer_Peruuta}

    Log  Talletetaan rajoitus monivalintatyökalulla.
    Click Element                               css=.${TL_Talvinopeus_RB} .polygon
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
    Click Element                               css=.${TL_Talvinopeus_RB} .polygon
    Suorita monivalinta
    Click Element                               ${Popup_NopeusRajoitus}
    Click Element                               ${Popup_NopeusRajoitus_DDM}
    Click Element                               ${FA_header_Tallenna}
    Wait Until Element Is Not Visible           ${Spinner_Overlay}
    Odota sivun latautuminen


*** Variables ***

${aloitussivu}    css=.panel-group:not([style="display: none;"]) .action.select.action
${Popup_TalviNopeusRajoitus}    css=#feature-attributes-form > div > div > div.form-elements-container > div > div > div.input-unit-combination > select
${Popup_valikko_talvinopeus}                css=body > div.container > div.modal-overlay.mass-update-modal > div > div.form-elements-container > div