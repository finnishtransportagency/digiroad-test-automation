#       Joni Laari        Sitowise        2023

*** Settings ***
Documentation       Keywords for lit-road (Valaistus)
Library             SeleniumLibrary
Resource            common_keywords.robot


*** Keywords ***
Valaistus_tarkistus  [arguments]                ${testipaikka}
    Log                                         Valaistuksen tarkastelu katselumoodissa
    Vaihda Tietolaji                            ${TL_Valaistus_RB}
    Paikanna osoite                             ${testipaikka}
    Zoomaa kartta                               5    200
    Odota sivun latautuminen

    #klikkauksen kokeilu, tietolajin vaatimus 2
    Click Element At Coordinates                ${Kartta}  0  20
    Wait Until Element Is Visible               ${Valaistus_otsikko}
    Element Should Contain                      ${Valaistus_on}    ${Valaistus_on_arvo}
    Element Should Be Visible                   ${Valaistus_lisätty_järjestelmään}
    Element Should Be Visible                   ${Valaistus_muokattu_viimeksi}
    Element Should Be Visible                   ${Valaistus_tarkistettu}
    Element Should Be Visible                   ${Valaistus_linkkien_lukumäärä}
    Click Element At Coordinates                ${Kartta}  0  100

    #tuplaklikki
    Tupla Klikkaa Kartan Keskelle
    Wait Until Element Is Visible               ${Valaistus_otsikko}
    Element Should Contain                      ${Valaistus_on}    ${Valaistus_on_arvo}
    Element Should Be Visible                   ${Valaistus_lisätty_järjestelmään}
    Element Should Be Visible                   ${Valaistus_muokattu_viimeksi}
    Element Should Be Visible                   ${Valaistus_tarkistettu}
    Element Should Be Visible                   ${Valaistus_linkkien_lukumäärä}
    Click Element At Coordinates                ${Kartta}  0  100


Valaistuksen_radionappi  [arguments]            ${testipaikka}
    #testattava sijainnilla, jossa ei ole olemassaolevaa valaistustietoa
    Log    Testataan radio button
    Testin Aloitus
    Vaihda Tietolaji                            ${TL_Valaistus_RB}
    Paikanna osoite                             ${testipaikka}
    Zoomaa kartta                               5   100 m
    Odota sivun latautuminen
    Siirry Muokkaustilaan
    Wait Until Element Is Not Visible           ${Map_popup}

    Wait Until Keyword Succeeds    3 x    2 s   Click Element At Coordinates    ${Kartta}  0  20
    #Annetaan Valaistustiedot ja tallennetaan (vaatimus 3:n mukaisesti)
    Wait Until Element Is Visible               ${Valaistus_tekstikenttä}
    Select Radio Button                         lit-road    enabled
    Radio Button Should Be Set To               lit-road    enabled

    #Poistetaan Valaistustiedot
    Select Radio Button                         lit-road    disabled
    Radio Button Should Be Set To               lit-road    disabled
    Click Element                               ${FA_footer_Peruuta}
    Wait Until Element Is Not Visible           ${Spinner_Overlay}

    #tarkistetaan, ettei tietoa tallentunut
    Wait Until Keyword Succeeds    3 x    2 s   Click Element At Coordinates    ${Kartta}  0  20
    Element Should Not Be Clickable             ${Valaistus_tekstikenttä}
    Element Should Contain                      ${Valaistus_lisätty_järjestelmään}    -
    Element Should Contain                      ${Valaistus_muokattu_viimeksi}        -


Valaistustieto usealle linkille laatikolla    [arguments]    ${testipaikka}
    #testattava sijainnilla, jossa ei ole olemassaolevaa valaistustietoa
    Log    Usean valaistustiedon lisäämistapojen testaaminen
    Vaihda Tietolaji                            ${TL_valaistus_RB}
    Paikanna osoite                             ${testipaikka}
    Odota sivun latautuminen
    Siirry Muokkaustilaan

    #Valaistuksen lisääminen laatikkotyökalulla
    Log    Tarkistetaan laatikkotyökalu
    Wait Until Element Is Enabled               ${Muokkaustila_Laatikko}
    Click Element                               ${Muokkaustila_Laatikko}
    Suorita laatikkovalinta
    Wait Until Element Is Visible               lit-road
    Select Radio Button                         lit-road    enabled
    Radio Button Should Be Set To               lit-road    enabled
    Wait Until Element Is Visible               ${Valaistus_popup_otsikko}
    Click Button                                ${FA_header_Tallenna}

    #Muutoksen peruutus (laatikkotyökalu)
    Odota sivun latautuminen
    Element Should Be Visible                   ${Muokkaustila_Laatikko}
    Click Element                               ${Muokkaustila_Laatikko}
    Suorita laatikkovalinta
    #tarkistetaan, että valaistus oli tallentunut
    Wait Until Element Is Visible               ${Valaistus_popup_otsikko}
    Wait Until Element Is Visible               lit-road
    Select Radio Button                         lit-road    disabled
    Radio Button Should Be Set To               lit-road    disabled
    Click Button                                ${FA_header_Tallenna}


Valaistustieto usealle linkille polygonilla    [arguments]    ${testipaikka}
    #testattava sijainnilla, jossa ei ole olemassaolevaa Valaistustietoa
    Log    Usean Valaistustiedon lisäämistapojen testaaminen
    Vaihda Tietolaji                            ${TL_Valaistus_RB}
    Paikanna osoite                             ${testipaikka}
    Odota sivun latautuminen
    Siirry Muokkaustilaan

    #Valaistuksen lisääminen polygontyökalulla
    Log    Tarkistetaan polygontyökalu
    Wait Until Element Is Enabled               ${Valaistus_polygon}
    Click Element                               ${Valaistus_polygon}
    Suorita monivalinta
    Wait Until Element Is Visible               lit-road
    Select Radio Button                         lit-road    enabled
    Radio Button Should Be Set To               lit-road    enabled
    Click Button                                ${FA_header_Tallenna}

    #Muutoksen peruutus (polygontyökalu)
    Odota sivun latautuminen
    Wait Until Element Is Not Visible           ${Spinner_Overlay}
    Element Should Be Visible                   ${Valaistus_polygon}
    Click Element                               ${Valaistus_polygon}
    Suorita monivalinta
    #tarkistetaan, että Valaistus oli tallentunut
    Wait Until Element Is Visible               ${Valaistus_popup_otsikko}
    Wait Until Element Is Visible               lit-road
    Click Button                                ${FA_header_Tallenna}


Usean valaistuslinkin klikkausvalinta    [arguments]          ${testipaikka}
    #testattava sijainnilla, jossa on suoraan pohjois-etelä-suunnassa kulkeva linkki
    Testin Aloitus
    Log    Usean Valaistustiedon lisäämistapojen testaaminen
    Vaihda Tietolaji                                          ${TL_Valaistus_RB}
    Paikanna osoite                                           ${testipaikka}
    Zoomaa kartta                                             5  20 m
    Odota sivun latautuminen
    Siirry Muokkaustilaan
    Wait Until Element Is Not Visible                         ${Map_popup}

    #painetaan control pohjaan ja klikataan
    Hold Control And Click Element At Coordinates             ${Kartta}  0  0
    selenium_extensions.Hold Control And Drag By Offset       ${Kartta}  0  100
    Click Element At Coordinates                              ${Kartta}  0  0
    selenium_extensions.Hold Control And Drag By Offset       ${Kartta}  0  -200
    Click Element At Coordinates                              ${Kartta}  0  0
    Release Control

    Odota sivun latautuminen
    Wait Until Element Is Visible                             lit-road
    Select Radio Button                                       lit-road    enabled
    Radio Button Should Be Set To                             lit-road    enabled
    Wait Until Element Is Visible                             ${Valaistus_popup_otsikko}
    Wait Until Element Is Visible                             ${FA_header_Peruuta}
    Click Button                                              ${FA_header_Peruuta}

    #painetaan control pohjaan ja klikataan; varmistetaan ettei tietoa tallentunut
    Hold Control And Click Element At Coordinates             ${Kartta}  0  0
    selenium_extensions.Hold Control And Drag By Offset       ${Kartta}  0  200
    Hold Control And Click Element At Coordinates             ${Kartta}  0  0
    selenium_extensions.Hold Control And Drag By Offset       ${Kartta}  0  -100
    Hold Control And Click Element At Coordinates             ${Kartta}  0  0
    Release Control

    Wait Until Element Is Visible                             lit-road
    Select Radio Button                                       lit-road    disabled
    Radio Button Should Be Set To                             lit-road    disabled
    Click Button                                              ${FA_header_Peruuta}


Valaistuksen katkaisu    [arguments]            ${testipaikka}
    Log    Katkaisutyökalun testaaminen
    Vaihda Tietolaji                            ${TL_Valaistus_RB}
    Paikanna osoite                             ${testipaikka}
    Zoomaa kartta                               5    100m

    Odota sivun latautuminen
    Siirry Muokkaustilaan
    Log    Leikataan tielinkki kahteen osaan
    Wait Until Element Is Visible               ${Muokkaustila_Leikkaus}
    Click Element                               ${Muokkaustila_Leikkaus}

    Odota sivun latautuminen
    Click Element At Coordinates                ${Kartta}  0  10
    Wait Until Element Is Visible               ${Valaistus_leikkausnäkymä_A}
    Element Should Be Visible                   ${Valaistus_leikkausnäkymä_B}

    #Valaistus-tietolajin vaatimus 5a    kokeillaan radionapit
    Select Radio Button                         lit-road-a    disabled
    Radio Button Should Be Set To               lit-road-a    disabled
    Select Radio Button                         lit-road-b    disabled
    Radio Button Should Be Set To               lit-road-b    disabled

    Select Radio Button                         lit-road-a    enabled
    Radio Button Should Be Set To               lit-road-a    enabled
    Select Radio Button                         lit-road-b    enabled
    Radio Button Should Be Set To               lit-road-b    enabled

    Wait Until Element Is Visible               ${FA_footer_Peruuta}
    Element Should Be Enabled                   ${FA_footer_Peruuta}
    Click Element                               ${FA_footer_Peruuta}


*** Variables ***
${Valaistus_otsikko}                              css=.input-unit-combination
${Valaistus_muokattava}                           css=.form-editable-lit-road
${Valaistus_lisätty_järjestelmään}                xpath=//*[@id="feature-attributes-form"]/div/div/div[1]/p
${Valaistus_muokattu_viimeksi}                    xpath=//*[@id="feature-attributes-form"]/div/div/div[2]/p
${Valaistus_linkkien_lukumäärä}                   xpath=//*[@id="feature-attributes-form"]/div/div/div[4]/p
${Valaistus_tarkistettu}                          xpath=//*[@id="feature-attributes-form"]/div/div/div[3]/p
${Valaistus_on}                                   xpath=//*[@id="feature-attributes-form"]/div/div/div[5]/p
${Valaistus_valintaryhmä}                         css=.choice-group
${Valaistus_on_arvo}                              on
${Valaistus_tekstikenttä}                         xpath=//*[@id="feature-attributes-form"]/div/div/div[4]/label
${Valaistus_leikkausnäkymä_A}                     css=.form-editable-lit-road-a
${Valaistus_leikkausnäkymä_B}                     css=.form-editable-lit-road-b
${Valaistus_monivalinta_ruutu}                    css=div.form-elements-container
${Valaistus_polygon}                              xpath=//*[@id="map-tools"]/div/div[3]/div[18]/div/div[4]/div[4]
${Valaistus_popup_otsikko}                        xpath=/html/body/div[1]/div[5]/div/div[2]/div/label
