#       Joni Laari      Sitowise Oy     2022

*** Settings ***
Documentation       Keywords for vehicle-specific constraints (ajoneuvokohtainen rajoitus)
Library    SeleniumLibrary
Library    selenium_extensions.py
Library    Screenshot
Resource   common_keywords.robot

*** Keywords ***
Ajoneuvorajoituksen tarkastelu zoomilla   [arguments]     ${testipaikka}
    Log     Rajoituksen tarkastelu katselutilassa.
    #testataan valinnan toimivuus
    Vaihda Tietolaji                            ${TL_Ajoneuvokohtaiset_rajoitukset_RB}
    Paikanna osoite                             ${testipaikka}
    Zoomaa kartta                               5   200 m
    Odota sivun latautuminen
    Wait Until Element Is Visible               ${Kartta}
    Element Should Be Visible                   ${Kartta}
    #testataan checkboxit
    Select Checkbox                             ${AKR_Näytä_liikennemerkit_checkbox}
    Checkbox Should Be Selected                 ${AKR_Näytä_liikennemerkit_checkbox}
    Select Checkbox                             ${AKR_Näytä_täydentävä_geometria_checkbox}
    Checkbox Should Be Selected                 ${AKR_Näytä_täydentävä_geometria_checkbox}
    #Take Screenshot    #voidaan tarkistaa tarvittaessa silmämääräisesti logista


Ajoneuvorajoituksen tarkastelu klikkaamalla   [arguments]     ${testipaikka}
    Log     Rajoituksen tarkastelu katselutilassa.
    #testataan valinnan toimivuus
    #Rajoitustietojen tarkastelu: tulee olla ID, lisätty järjestelmään, muokattu viimeksi -tiedot sekä tieto linkkien määrästä valitussa rajoitusketjussa. Lisäksi tiedot siitä, mitä ajoneuvoa rajoitus koskee. Joillain kohteilla voi myös olla tiedot rajoituksen voimassaoloajasta sekä ajoneuvoista, joita rajoitus ei koske.
    #Kerran napauttamalla tulee valituksi koko rajoitustieto, eli kaikki linkit, joilla on sama rajoitustieto ja tienumero (maantiellä) tai tien nimi (katuverkko ja yksityistie)
    #Kaksoisnapauttamalla kohdetta tulee näkyviin yhden linkin ajoneuvokohtaisen rajoituksen tiedot
    Vaihda Tietolaji                            ${TL_Ajoneuvokohtaiset_rajoitukset_RB}
    Paikanna osoite                             ${testipaikka}
    Zoomaa kartta                               5   50 m
    Odota sivun latautuminen
    Click Element At Coordinates                ${Kartta}   0  20
    Wait Until Element Is Visible               ${FA_otsikko}
    Element Should Be Visible                   ${FA_AKR_RajoitusID}
    Element Should Be Visible                   ${FA_AKR_Lisätty_järjestelmään}
    Element Should Be Visible                   ${FA_AKR_Muokattu_viimeksi}
    Element Should Be Visible                   ${FA_AKR_Linkkien_lukumäärä}
    Element Should Be Visible                   ${FA_AKR_Olemassaoleva_rajoitus}
    Click Element At Coordinates                ${Kartta}  -100  -100
    
    #double click
    Tupla Klikkaa Kartan Keskelle
    Wait Until Element Is Visible               ${FA_otsikko}
    Element Should Be Visible                   ${FA_AKR_RajoitusID}
    Element Should Be Visible                   ${FA_AKR_Lisätty_järjestelmään}
    Element Should Be Visible                   ${FA_AKR_Muokattu_viimeksi}
    Element Should Be Visible                   ${FA_AKR_Linkkien_lukumäärä}
    Element Should Be Visible                   ${FA_AKR_Olemassaoleva_rajoitus}


Ajoneuvorajoituksen muokkaus koko ketjulle   [arguments]     ${testipaikka}    ${rajoitelaji}    ${tietolajinimi}
    Log     Ajoneuvorajoituksen muokkaus koko ketjulle
    Testin Aloitus
    Vaihda Tietolaji                            ${TL_Ajoneuvokohtaiset_rajoitukset_RB}
    Paikanna osoite                             ${testipaikka}
    Zoomaa kartta                               5   50 m
    Odota sivun latautuminen
    Siirry Muokkaustilaan
    Wait Until Element Is Not Visible           ${Map_popup}
    Click Element At Coordinates                ${Kartta}  0  20
    Wait Until Element Is Visible               ${FA_AKR_Lisätty_järjestelmään}
    Element Should Be Visible                   ${FA_AKR_Muokattu_viimeksi}
    Element Should Be Visible                   ${FA_AKR_Linkkien_lukumäärä}

    Click Element                               ${Popup_AjoneuvoRajoitus}
    Click Element                               ${rajoitelaji}
    Element Attribute Value Should Be           ${rajoitelaji}    data-value    ${tietolajinimi}
    Click Element                               ${FA_AKR_Uusi_viikonpäivä}
    Click Element                               ${Popup_AjoneuvoRajoitus_Viikonpaiva}
    Element Attribute Value Should Be           ${FA_AKR_Olemassaoleva_viikonpäivä}    data-days    Weekday
    Click Element                               ${FA_AKR_Uusi_poikkeus}
    Click Element                               ${Popup_AjoneuvoRajoitus_Huoltoajo}
    Element Should Contain                      ${FA_AKR_Olemassaoleva_poikkeus}    Huoltoajo
    #muutoksen peruutus
    Element Should Be Enabled                   ${FA_footer_Tallenna}    #tarkistetaan että tallennusnappi on painettavissa, mutta ei paineta
    Click Element                               ${FA_footer_Peruuta}


Ajoneuvorajoituksen osan muokkaus   [arguments]     ${testipaikka}    ${rajoitelaji}    ${tietolajinimi}
    Log     Ketjun osan muokkaus tuplaklikkaamalla
    Testin Aloitus
    Vaihda Tietolaji                            ${TL_Ajoneuvokohtaiset_rajoitukset_RB}
    Paikanna osoite                             ${testipaikka}
    Zoomaa kartta                               5   50 m
    Odota sivun latautuminen
    Siirry Muokkaustilaan
    Tupla Klikkaa Kartan Keskelle
    Wait Until Element Is Visible               ${FA_AKR_Lisätty_järjestelmään}
    Element Should Be Visible                   ${FA_AKR_Muokattu_viimeksi}
    Element Should Be Visible                   ${FA_AKR_Linkkien_lukumäärä}

    Click Element                               ${Popup_AjoneuvoRajoitus}
    Click Element                               ${rajoitelaji}
    Element Attribute Value Should Be           ${rajoitelaji}    data-value    ${tietolajinimi}
    Click Element                               ${FA_AKR_Uusi_viikonpäivä}
    Click Element                               ${Popup_AjoneuvoRajoitus_Viikonpaiva}
    Element Attribute Value Should Be           ${FA_AKR_Olemassaoleva_viikonpäivä}    data-days    Weekday
    Click Element                               ${FA_AKR_Uusi_poikkeus}
    Click Element                               ${Popup_AjoneuvoRajoitus_Huoltoajo}
    Element Should Contain                      ${FA_AKR_Olemassaoleva_poikkeus}    Huoltoajo
    #muutoksen peruutus
    Element Should Be Enabled                   ${FA_footer_Tallenna}    #tarkistetaan että tallennusnappi on painettavissa, mutta ei paineta
    Click Element                               ${FA_footer_Peruuta}


AKR usealle linkille laatikolla   [arguments]     ${testipaikka}    ${rajoitelaji}    ${tietolajinimi}
    Log     Usean rajoituksen lisäämistapojen testaaminen
    Log    Tarkistetaan laatikkotyökalu
    #testataan rajoituksen lisääminen
    Testin Aloitus
    Vaihda Tietolaji                            ${TL_Ajoneuvokohtaiset_rajoitukset_RB}
    Paikanna osoite                             ${testipaikka}
    Zoomaa kartta                               5   100 m
    Odota sivun latautuminen
    Siirry Muokkaustilaan
    Wait Until Element Is Not Visible           ${Map_popup}
    #Leveyden lisääminen laatikkotyökalulla
    Log    Tarkistetaan laatikkotyökalu
    Wait Until Element Is Visible               ${Muokkaustila_Laatikko}
    Click Element                               ${Muokkaustila_Laatikko}
    Suorita laatikkovalinta
    Click Element                               ${Popup_AjoneuvoRajoitus}
    Click Element                               ${rajoitelaji}
    Element Attribute Value Should Be           ${rajoitelaji}    data-value    ${tietolajinimi}

    #asetetaan voimassaoloaika
    Click Element                               ${FA_AKR_Uusi_viikonpäivä}
    Click Element                               ${Popup_AjoneuvoRajoitus_Viikonpaiva}
    Element Attribute Value Should Be           ${FA_AKR_Olemassaoleva_viikonpäivä}    data-days    Weekday

    #lisätään poikkeus
    Click Element                               ${FA_AKR_Uusi_poikkeus}
    Click Element                               ${Popup_AjoneuvoRajoitus_Huoltoajo}
    Element Should Contain                      ${FA_AKR_Olemassaoleva_poikkeus}    Huoltoajo
    #muutoksen peruutus
    Element Should Be Enabled                   ${FA_header_Tallenna}    #tarkistetaan että tallennusnappi on painettavissa, mutta ei paineta
    Click Element                               ${FA_header_Peruuta}


AKR usealle linkille polygonilla   [arguments]     ${testipaikka}    ${rajoitelaji}    ${tietolajinimi}
    Log    Usean rajoituksen lisäämistapojen testaaminen
    Log    Tarkistetaan polygontyökalu
    #testataan rajoituksen lisääminen
    Testin Aloitus
    Vaihda Tietolaji                            ${TL_Ajoneuvokohtaiset_rajoitukset_RB}
    Paikanna osoite                             ${testipaikka}
    Zoomaa kartta                               5   100 m
    Odota sivun latautuminen
    Siirry Muokkaustilaan
    Wait Until Element Is Not Visible           ${Map_popup}
    #Leveyden lisääminen polygontyökalulla
    Log    Tarkistetaan polygontyökalu
    Wait Until Element Is Visible               ${Muokkaustila_PolygonTool}
    Click Element                               ${Muokkaustila_PolygonTool}
    Suorita monivalinta
    Click Element                               ${Popup_AjoneuvoRajoitus}
    Click Element                               ${rajoitelaji}
    Element Attribute Value Should Be           ${rajoitelaji}    data-value    ${tietolajinimi}
    Click Element                               ${FA_AKR_Uusi_viikonpäivä}
    Click Element                               ${Popup_AjoneuvoRajoitus_Viikonpaiva}
    Element Attribute Value Should Be           ${FA_AKR_Olemassaoleva_viikonpäivä}    data-days    Weekday
    Click Element                               ${FA_AKR_Uusi_poikkeus}
    Click Element                               ${Popup_AjoneuvoRajoitus_Huoltoajo}
    Element Should Contain                      ${FA_AKR_Olemassaoleva_poikkeus}    Huoltoajo
    #muutoksen peruutus
    Element Should Be Enabled                   ${FA_header_Tallenna}    #tarkistetaan että tallennusnappi on painettavissa, mutta ei paineta
    Click Element                               ${FA_header_Peruuta}


AKR usealle linkille klikkaamalla    [arguments]    ${testipaikka}    ${rajoitelaji}    ${tietolajinimi}
    Log    Usean rajoituksen lisäämistapojen testaaminen
    Log    Tarkistetaan control+klikkaus
    #testataan rajoituksen lisääminen
    Testin Aloitus
    Vaihda Tietolaji                            ${TL_Ajoneuvokohtaiset_rajoitukset_RB}
    Paikanna osoite                             ${testipaikka}
    Zoomaa kartta                               5   100 m
    Odota sivun latautuminen
    Siirry Muokkaustilaan
    Wait Until Element Is Not Visible           ${Map_popup}

    #Leveyden lisääminen ctrl+klikkauksella
    Log    Tarkistetaan monivalinta hiirellä
    Hold Control And Click Element At Coordinates             ${Kartta}  0  0
    selenium_extensions.Hold Control And Drag By Offset       ${Kartta}  0  100
    Click Element At Coordinates                              ${Kartta}  0  0
    selenium_extensions.Hold Control And Drag By Offset       ${Kartta}  0  -200
    Click Element At Coordinates                              ${Kartta}  0  0
    Release Control

    Click Element                               ${Popup_AjoneuvoRajoitus}
    Click Element                               ${rajoitelaji}
    Element Attribute Value Should Be           ${rajoitelaji}    data-value    ${tietolajinimi}
    Click Element                               ${FA_AKR_Uusi_viikonpäivä}
    Click Element                               ${Popup_AjoneuvoRajoitus_Viikonpaiva}
    Element Attribute Value Should Be           ${FA_AKR_Olemassaoleva_viikonpäivä}    data-days    Weekday
    Click Element                               ${FA_AKR_Uusi_poikkeus}
    Click Element                               ${Popup_AjoneuvoRajoitus_Huoltoajo}
    Element Should Contain                      ${FA_AKR_Olemassaoleva_poikkeus}    Huoltoajo
    #muutoksen peruutus
    Element Should Be Enabled                   ${FA_header_Tallenna}    #tarkistetaan että tallennusnappi on painettavissa, mutta ei paineta
    Click Element                               ${FA_header_Peruuta}


AKR jako kahdeksi   [arguments]     ${testipaikka}    ${tietolajinimi}
    #todo rework, nyt tarpeettoman monimutkainen
    Log     Katkaisutyökalun testaaminen
    Vaihda Tietolaji                            ${TL_Ajoneuvokohtaiset_rajoitukset_RB}
    Paikanna osoite                             ${testipaikka}
    Zoomaa kartta                               5   50 m

    Odota sivun latautuminen
    Siirry Muokkaustilaan
    Log  Leikataan rajoitus kahteen osaan
    Wait Until Element Is Not Visible           ${Map_popup}
    Tupla Klikkaa Kartan Keskelle
    Wait Until Element Is Visible               ${FA_AKR_Lisätty_järjestelmään}
    Element Should Be Visible                   ${FA_AKR_Muokattu_viimeksi}
    Element Should Be Visible                   ${FA_AKR_Linkkien_lukumäärä}

    Click Element                               ${AKR_Jaa_kaksisuuntaiseksi}
    Element Should Be Visible                   ${FA_Prohibition_A}
    Element Should Be Visible                   ${FA_Prohibition_B}

    Click Element                               ${DDM_AKR_ajoneuvo_a}
    Element Attribute Value Should Be           ${DDM_AKR_ajoneuvo_a}    data-value    ${tietolajinimi}
    #poikkeukset ja viikonpäivät

    Click Element                               ${DDM_AKR_ajoneuvo_b}
    Element Attribute Value Should Be           ${DDM_AKR_ajoneuvo_b}    data-value    ${tietolajinimi}
    #poikkeukset ja viikonpäivät

    Element Should Be Enabled                    ${FA_footer_Tallenna}    #tarkistetaan että tallennusnappi on painettavissa, mutta ei paineta
    Click Element                                ${FA_footer_Peruuta}
END


##########################
### Sisäiset Keywordit ###
##########################


*** Variables ***
${FA_Prohibition_A}            css=#feature-attributes-form > div > div > div.form-elements-container > div.form-group.editable.prohibition-a
${FA_Prohibition_A_DDM}        css=#feature-attributes-form > div > div > div.form-elements-container > div.form-group.editable.prohibition-a > ul.edit-control-group > li > div > select
${FA_Prohibition_B}            css=#feature-attributes-form > div > div > div.form-elements-container > div.form-group.editable.prohibition-b
${FA_Prohibition_B_DDM}        css=#feature-attributes-form > div > div > div.form-elements-container > div.form-group.editable.prohibition-b > ul.edit-control-group > li > div > select
${FA_Ajoneuvorajoitus}         css=.feature-attributes-form

#splittaustestin muuttujat
${DDM_AKR_ajoneuvo_a}                       css=#feature-attributes-form > div > div > div.form-elements-container > div.form-group.editable.prohibition-a > ul.edit-control-group > li > div > select > option[data-value="ajoneuvo"]
${DDM_AKR_ajoneuvo_b}                       css=#feature-attributes-form > div > div > div.form-elements-container > div.form-group.editable.prohibition-b > ul.edit-control-group > li > div > select > option[data-value="ajoneuvo"]


${FA_AKR_RajoitusID}                            xpath=/html/body/div[1]/div[2]/header/div[1]/span
${FA_AKR_Lisätty_järjestelmään}                 xpath=/html/body/div[1]/div[2]/main/article/div/div/div[1]/p
${FA_AKR_Muokattu_viimeksi}                     xpath=/html/body/div[1]/div[2]/main/article/div/div/div[2]/p
${FA_AKR_Linkkien_lukumäärä}                    xpath=/html/body/div[1]/div[2]/main/article/div/div/div[3]/p
${FA_AKR_Olemassaoleva_rajoitus}                xpath=/html/body/div[1]/div[2]/main/article/div/div/div[4]/div/ul[1]/li/div

${FA_AKR_Uusi_viikonpäivä}                      css=.form-group.new-validity-period
${FA_AKR_Uusi_poikkeus}                         css=.form-group.new-exception
${FA_AKR_Olemassaoleva_viikonpäivä}             css=.form-group.existing-validity-period
${FA_AKR_Olemassaoleva_poikkeus}                css=.form-group.existing-exception

${Popup_AjoneuvoRajoitus_Voimassaoloaika}       xpath=/html/body/div[1]/div[2]/main/article/div/div/div[4]/div/ul[2]/li[1]/div/div[2]/ul/li[2]/div/select
${Popup_AjoneuvoRajoitus_Poikkeus}              xpath=/html/body/div[1]/div[2]/main/article/div/div/div[4]/div/ul[2]/li[1]/div/div[3]/ul/li[2]/div/select

${Popup_AjoneuvoRajoitus}                           css=.form-control.select
${Popup_AjoneuvoRajoitus_Ajoneuvo}                  css=.form-control option[data-value="ajoneuvo"]
${Popup_AjoneuvoRajoitus_Moottoriajoneuvo}          css=.form-control option[data-value="moottoriajoneuvo"]
${Popup_AjoneuvoRajoitus_Lapiajo}                   css=.form-control option[data-value="lapiajo"]
${Popup_AjoneuvoRajoitus_Jalankulku}                css=.form-control option[data-value="jalankulku"]
${Popup_AjoneuvoRajoitus_Polkupyora}                css=.form-control option[data-value="polkupyora"]
${Popup_AjoneuvoRajoitus_Ratsastus}                 css=.form-control option[data-value="ratsastus"]
${Popup_AjoneuvoRajoitus_Mopo}                      css=.form-control option[data-value="mopo"]
${Popup_AjoneuvoRajoitus_Moottoripyora}             css=.form-control option[data-value="moottoripyora"]
${Popup_AjoneuvoRajoitus_Moottorikelkka}            css=.form-control option[data-value="moottorikelkka"]
${Popup_AjoneuvoRajoitus_Linja-auto}                css=.form-control option[data-value="linja-auto"]
${Popup_AjoneuvoRajoitus_Taksi}                     css=.form-control option[data-value="taksi"]
${Popup_AjoneuvoRajoitus_Henkiloauto}               css=.form-control option[data-value="henkiloauto"]
${Popup_AjoneuvoRajoitus_Kuorma-auto}               css=.form-control option[data-value="kuorma-auto"]
${Popup_AjoneuvoRajoitus_Matkailuajoneuvo}          css=.form-control option[data-value="matkailuajoneuvo"]
${Popup_AjoneuvoRajoitus_Sotilasajoneuvo}           css=.form-control option[data-value="sotilasajoneuvo"]
${Popup_AjoneuvoRajoitus_Ajoneuvoyhdistelma}        css=.form-control option[data-value="ajoneuvoyhdistelma"]
${Popup_AjoneuvoRajoitus_Traktori}                  css=.form-control option[data-value="traktori-tai-maatalousajoneuvo"]

${Popup_AjoneuvoRajoitus_Huoltoajo}                 css=.form-control option[data-value="huoltoajo"]
${Popup_AjoneuvoRajoitus_Numero}                    css=.form-control option[value="10"]

${Popup_AjoneuvoRajoitus_Viikonpaiva}               css=.form-control.select option[value="Weekday"]
${Popup_AjoneuvoRajoitus_Lauantai}                  css=.form-control.select option[value="Saturday"]
${Popup_AjoneuvoRajoitus_Sunnuntai}                 css=.form-control.select option[value="Sunday"]

${AKR_Jaa_kaksisuuntaiseksi}                        css=#separate-limit
${AKR_Peruuta_Muutos}                               css=.cancel.btn.btn-secondary
${AKR_Popup_Peruuta_Muutos}                         css=.btn.btn-secondary.close

${AKR_Näytä_liikennemerkit_checkbox}                xpath=/html/body/div[1]/nav/div/div[3]/div[5]/div/div[3]/input
${AKR_Näytä_täydentävä_geometria_checkbox}          xpath=/html/body/div[1]/nav/div/div[3]/div[5]/div/div[4]/input