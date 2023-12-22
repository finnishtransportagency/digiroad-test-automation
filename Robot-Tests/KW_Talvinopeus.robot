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
    FOR  ${i}  IN RANGE  2  6
        ${n}=  Evaluate  -${i}+1
        Element Should Contain  xpath=/html/body/div[1]/div[2]/main/article/div/div/div[4]/div/div/div[3]/select  ${Talvinopeusrajoitukset}[${n}]
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


*** Variables ***

${aloitussivu}    css=.panel-group:not([style="display: none;"]) .action.select.action
${Popup_TalviNopeusRajoitus}    css=#feature-attributes-form > div > div > div.form-elements-container > div > div > div.input-unit-combination > select