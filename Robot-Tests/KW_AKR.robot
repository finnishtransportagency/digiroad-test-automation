#       Joni Laari      Sitowise Oy     2022

*** Settings ***
Documentation       Keywords for vehicle-specific constraints (ajoneuvokohtainen rajoitus)
Library    SeleniumLibrary
Resource    common_keywords.robot

*** Variables ***
${LocatorForDDM}                            css=#feature-attributes .form-group.editable. select:first-of-type
${LocatorForDDM_Selection}                  css=select >option:nth-child(2)
${Rajoituksen_poisto}                       Haluatko varmasti poistaa rajoituksen?

*** Keywords ***

AKR_1   [arguments]     ${testipaikka}
    Log     Rajoituksen tarkastelu katselutilassa.
    #testataan valinnan toimivuus
    Vaihda Tietolaji                            ${TL_Ajoneuvokohtaiset_rajoitukset_RB}
    Paikanna osoite                             ${testipaikka}
    Zoomaa kartta                               5   50 m
    Odota sivun latautuminen
    Click Element At Coordinates                ${Kartta}   0  20
    Wait Until Element Is Visible               ${FA_otsikko}
    
    #double click
    Click Element At Coordinates                ${Kartta}  -100  -100
    Tupla Klikkaa Kartan Keskelle
    Wait Until Element Is Visible               ${FA_otsikko}


AKR_2   [arguments]     ${testipaikka}
    Log     Ajoneuvorajoituksen muokkaus koko ketjulle
    Vaihda Tietolaji                            ${TL_Ajoneuvokohtaiset_rajoitukset_RB}
    Paikanna osoite                             ${testipaikka}
    Zoomaa kartta                               5   10 m
    Siirry Muokkaustilaan
    Odota sivun latautuminen
    Wait Until Element Is Visible               css=.instructions-popup
    Click Element At Coordinates                ${Kartta}   0   20
    Wait Until Element Is Visible               css=#feature-attributes-form > div > div > div.form-elements-container > div > label
    #väliaikainen, odotetaan fronttikoodin attribuuttien nimeämistä.
    Click Element                               css=.form-control
    Click Element                               css=.form-control option[value="10"]

    #poikkeuksen lisääminen, tässä tapauksessa linja-auto
    Click Element                               css=.form-control.select
    Click Element                               css=.form-control.select option[value="5"]

    #muutoksen peruutus
    Click Element                               ${FA_footer_Peruuta}


AKR_3   [arguments]     ${testipaikka}
    Log     Ketjun osan muokkaus tuplaklikkaamalla
    Vaihda Tietolaji                            ${TL_Ajoneuvokohtaiset_rajoitukset_RB}
    Paikanna osoite                             ${testipaikka}
    Zoomaa kartta                               5   50 m
    Odota sivun latautuminen
    Siirry Muokkaustilaan
    Tupla Klikkaa Kartan Keskelle
    Wait Until Element Is Visible               css=.form-elements-container

    #väliaikainen, odotetaan fronttikoodin attribuuttien nimeämistä.
    Click Element                               css=.form-control
    Click Element                               ${Popup_AjoneuvoRajoitus_Ajoneuvo}

    #muutoksen peruutus
    Click Element                               ${FA_footer_Peruuta}


AKR_4   [arguments]     ${testipaikka}    ${kohderajoite}
    Log     Luodaan uusi ajoneuvokohtainen rajoitus
    #testataan rajoituksen lisääminen
    Testin Aloitus
    Vaihda Tietolaji                            ${TL_Ajoneuvokohtaiset_rajoitukset_RB}
    Paikanna osoite                             ${testipaikka}
    Zoomaa kartta                               5   20 m
    Odota sivun latautuminen
    Nollaa Ajoneuvorajoitus
    Siirry Muokkaustilaan

    #Luodaan ajoneuvorajoite, voimassaoloaika ja poikkeus
    Click Element At Coordinates                ${Kartta}  0  20

    Wait Until Element Is Visible               css=.form-control
    Sleep                                       5
    Click Element                               css=.form-control
    Click Element                               ${kohderajoite}

    #voimassaoloaika
    Click Element                               css=.form-control.select
    Click Element                               css=.form-control.select option[value="Weekday"]

    #poikkeus
    Click Element                               css=.form-control.select
    Click Element                               css=.form-control.select option[value="Weekday"]

    #Peruutus
    Element Should Be Visible                   ${FA_footer_Peruuta}
    Click Element                               ${FA_footer_Peruuta}


AKR_5   [arguments]     ${testipaikka}
    Log     Rajoituksen poisto
    Vaihda Tietolaji                            ${TL_Ajoneuvokohtaiset_rajoitukset_RB}
    Paikanna osoite                             ${testipaikka}
    Zoomaa kartta                               5   50 m
    Odota sivun latautuminen
    Siirry Muokkaustilaan
    Click Element At Coordinates                ${Kartta}  0  20

    #Poistetaan rajoitus
    Wait Until Element Is Visible               css=.delete.btn-delete
    Click Element                               css=.delete.btn-delete

    #Peruutus
    Element Should Be Visible                   ${FA_footer_Peruuta}
    Click Element                               ${FA_footer_Peruuta}


AKR_6   [arguments]                             ${testipaikka}
    Log     Valitaan laatikolla useampi kohde
    Vaihda Tietolaji                            ${TL_Ajoneuvokohtaiset_rajoitukset_RB}
    Paikanna osoite                             ${testipaikka}
    Zoomaa kartta                               5   50 m
    Odota sivun latautuminen
    Siirry Muokkaustilaan

    #Valitaan laatikolla alue
    Element should be visible                   css=.prohibition .polygon
    Click Element                               css=.prohibition .polygon
    Suorita monivalinta
    Wait Until Element Is Visible               css=#feature-attributes
    Click Element                               css=.form-control
    Click Element                               ${Popup_AjoneuvoRajoitus_Ajoneuvo}

    #Peruutus
    Element Should Be Visible                   ${AKR_Popup_Peruuta_Muutos}
    Click Element                               ${AKR_Popup_Peruuta_Muutos}


AKR_7   [arguments]     ${testipaikka}
    #todo rework, nyt tarpeettoman monimutkainen
    Log     Katkaisutyökalun testaaminen
    Vaihda Tietolaji                            ${TL_Ajoneuvokohtaiset_rajoitukset_RB}
    Paikanna osoite                             ${testipaikka}
    Zoomaa kartta                               5   50 m

    Odota sivun latautuminen
    Siirry Muokkaustilaan
    Log  Leikataan rajoitus kahteen osaan 206.86
    Log  Katkaisun jälkeen peruuta-nappi toimii 206.91
    Element should be visible                   css=.prohibition .cut
    Click Element                               css=.prohibition .cut
    Wait Until Element Is Visible               css=.ol-unselectable
    Click Element At Coordinates                css=.ol-unselectable      -50     0
    Wait Until Element Is Visible               xpath=//*[contains(text(),'Rajoitus')]
    Wait Until Element Is Visible               ${FA_footer_Peruuta}
    Click Element                               ${FA_footer_Peruuta}

    Log  Katkaisun jälkeen peruuta-napin painalluksen jälkeen katkaisutyökalu jää käyttöön
    Element Should Be Visible                   xpath=//*[@id="map-tools"]/div/div[3]/div[5]/div/div[4]/div[2]
    Log  Katkaisun jälkeen peruuta-napin painalluksen jälkeen yksittäisen ajoneuvorajoituksen valinta poistuu
    Element Should Not Be Visible               xpath=//*[@id="feature-attributes-header"]/span[2]
    Click Element At Coordinates                css=.ol-viewport      -50     0

    Log  Asetetaan leikkauskohdan rajoitukset
    Wait Until Element Is Visible               ${FA_Prohibition_A}
    Click Element                               ${FA_Prohibition_A}
    Click Element                               ${FA_Prohibition_A_DDM}
    Click Element                               ${FA_Prohibition_B}
    Click Element                               ${FA_Prohibition_B_DDM}

    Wait Until Element Is Visible               css=.ol-unselectable
    Click Element At Coordinates                ${Kartta}  0  100   #klikattava käsin?
    Wait Until Element Is Visible               ${MuokkausVaroitus}
    Element Should Contain                      ${MuokkausVaroitus}  ${MuokkausVaroitus_teksti}
    Click Element                               ${Muokkausvaroitus_Sulje_btn}
    Click Element                               xpath=//*[@id="feature-attributes-footer"]/div/button[2]
    Wait Until Element Is Not Visible           ${Spinner_Overlay}
    Odota sivun latautuminen
    Log  Yhden linkin mittaisen ajoneuvorajoituksen katkaisun ja tallennuksen jälkeen valintatyökalu jää aktiiviseksi, 206.101
    Element should be visible                   css=.panel-group:not([style="display: none;"]) .action.select.action
    Siirry Katselutilaan

    Log  Yhden linkin mittaisen ajoneuvorajoituksen katkaisun jälkeen uudet ajoneuvorajoituspätkien arvot ovat muokattavissa 206.102
    Click Element At Coordinates                ${Kartta}  0  20 
    Siirry Muokkaustilaan
    Click Element                               ${Popup_AjoneuvoRajoitus}
    Click Element                               ${Popup_AjoneuvoRajoitus_Moottoriajoneuvo}
    Click Element                               ${Popup_AjoneuvoRajoitus_Huoltoajo}
    Click Element                               ${FA_header_Tallenna}
    Wait Until Element Is Not Visible           ${Spinner_Overlay}
    Odota sivun latautuminen
    Siirry Katselutilaan
    Wait Until Element Is Visible               ${FA_otsikko}
    ${date}=                                    Get Current Date                  result_format=%d.%m.%Y %H:%M:%S
    Element Should Contain                      ${FA_Muokattu_viimeksi}     /
END


##########################
### Sisäiset Keywordit ###
##########################

Nollaa Ajoneuvorajoitus
    Siirry Muokkaustilaan
    Element should be visible                   css=.prohibition .polygon
    Click Element                               css=.prohibition .polygon
    Suorita monivalinta
    Click Element                               ${Popup_AjoneuvoRajoitus}
    Click Element                               ${FA_header_Tallenna}
    Wait Until Element Is Not Visible           ${Spinner_Overlay}
    Odota sivun latautuminen
    Siirry Katselutilaan


*** Variables ***
${FA_Prohibition_A}            css=.prohibition-a
${FA_Prohibition_A_DDM}        css=.prohibition-a option:nth-child(2)
${FA_Prohibition_B}            css=.prohibition-b
${FA_Prohibition_B_DDM}        css=.prohibition-b option:nth-child(8)
${FA_Ajoneuvorajoitus}         css=.feature-attributes-form

${Popup_AjoneuvoRajoitus}                       css=.form-control.select
${Popup_AjoneuvoRajoitus_Ajoneuvo}              css=.form-control option[data-value="ajoneuvo"]
${Popup_AjoneuvoRajoitus_Moottoriajoneuvo}      css=.form-control option[data-value="moottoriajoneuvo"]
${Popup_AjoneuvoRajoitus_Lapiajo}               css=.form-control option[data-value="lapiajo"]
${Popup_AjoneuvoRajoitus_Jalankulku}            css=.form-control option[data-value="jalankulku"]
${Popup_AjoneuvoRajoitus_Polkupyora}            css=.form-control option[data-value="polkupyora"]
${Popup_AjoneuvoRajoitus_Ratsastus}              css=.form-control option[data-value="ratsastus"]
${Popup_AjoneuvoRajoitus_Mopo}                  css=.form-control option[data-value="mopo"]
${Popup_AjoneuvoRajoitus_Moottoripyora}          css=.form-control option[data-value="moottoripyora"]
${Popup_AjoneuvoRajoitus_Moottorikelkka}          css=.form-control option[data-value="moottorikelkka"]
${Popup_AjoneuvoRajoitus_Linja-auto}              css=.form-control option[data-value="linja-auto"]
${Popup_AjoneuvoRajoitus_Taksi}                  css=.form-control option[data-value="taksi"]
${Popup_AjoneuvoRajoitus_Henkiloauto}           css=.form-control option[data-value="henkiloauto"]
${Popup_AjoneuvoRajoitus_Kuorma-auto}           css=.form-control option[data-value="kuorma-auto"]
${Popup_AjoneuvoRajoitus_Matkailuajoneuvo}      css=.form-control option[data-value="matkailuajoneuvo"]
${Popup_AjoneuvoRajoitus_Sotilasajoneuvo}          css=.form-control option[data-value="sotilasajoneuvo"]
${Popup_AjoneuvoRajoitus_Ajoneuvoyhdistelma}      css=.form-control option[data-value="ajoneuvoyhdistelma"]
${Popup_AjoneuvoRajoitus_Traktori}              css=.form-control option[data-value="traktori-tai-maatalousajoneuvo"]

${Popup_AjoneuvoRajoitus_Huoltoajo}            css=.form-control option[data-value="huoltoajo"]
${Popup_AjoneuvoRajoitus_Numero}    css=.form-control option[value="10"]

${FA_Jaa_Ajoneuvorajoitus}    id=separate-limit
${AKR_Peruuta_Muutos}        css=.cancel.btn.btn-secondary
${AKR_Popup_Peruuta_Muutos}        css=.btn.btn-secondary.close