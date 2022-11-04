#       Joni Laari      Sitowise Oy     2022

*** Settings ***
Documentation       Keywords for road-width (Leveys)
Library             SeleniumLibrary
Resource            common_keywords.robot

*** Keywords ***
Leveyden_tarkistus   [arguments]                ${testipaikka}
    Log                                         Päällysteen tarkastelu katselumoodissa
    Vaihda Tietolaji                            ${TL_Leveys_RB}
    Paikanna osoite                             ${testipaikka}
    Zoomaa kartta                               5    200
    Odota sivun latautuminen

    #klikkauksen kokeilu
    Click Element At Coordinates                ${Kartta}  0  20
    Wait Until Element Is Visible               ${Leveys_otsikko}
    Element Should Contain                      ${Leveys_otsikko}    ${Leveys_cm_lukema}
    Element Should Be Visible                   ${Leveys_lisätty_järjestelmään}
    Element Should Be Visible                   ${Leveys_muokattu_viimeksi}
    Element Should Be Visible                   ${Leveys_linkkien_lukumäärä}
    Element Should Be Visible                   ${Leveys_tietoruutu_boolean}
    Click Element At Coordinates                ${Kartta}  0  100

    #tuplaklikki
    Tupla Klikkaa Kartan Keskelle
    Wait Until Element Is Visible               ${Leveys_otsikko}
    Element Should Contain                      ${Leveys_otsikko}    ${Leveys_cm_lukema}
    Element Should Be Visible                   ${Leveys_lisätty_järjestelmään}
    Element Should Be Visible                   ${Leveys_muokattu_viimeksi}
    Element Should Be Visible                   ${Leveys_linkkien_lukumäärä}
    Element Should Be Visible                   ${Leveys_tietoruutu_boolean}
    Click Element At Coordinates                ${Kartta}  0  100


Leveyden_radionappi  [arguments]                ${testipaikka}
    Log    Testataan radio button
    Testin Aloitus
    Vaihda Tietolaji                            ${TL_Leveys_RB}
    Paikanna osoite                             ${testipaikka}
    Zoomaa kartta                               5   100 m
    Odota sivun latautuminen
    Siirry Muokkaustilaan
    Wait Until Element Is Not Visible           ${Map_popup}

    Wait Until Keyword Succeeds    3 x    2 s   Click Element At Coordinates    ${Kartta}  0  20
    #Annetaan leveystiedot
    Wait Until Element Is Visible               ${Leveys_tekstikenttä}
    Select Radio Button                         road-width    enabled
    Radio Button Should Be Set To               road-width    enabled
    Wait Until Element Is Visible               ${Leveys_tekstikenttä}
    Input Text                                  ${Leveys_tekstikenttä}  400  True
    Element Attribute Value Should Be           ${Leveys_tekstikenttä}  value  400

    #Poistetaan leveystiedot
    Select Radio Button                         road-width    disabled
    Radio Button Should Be Set To               road-width    disabled
    Click Element                               ${FA_footer_Peruuta}
    Wait Until Element Is Not Visible           ${Spinner_Overlay}

    #tarkistetaan, ettei tietoa tallentunut
    Wait Until Keyword Succeeds    3 x    2 s   Click Element At Coordinates    ${Kartta}  0  20
    Element Should Not Be Clickable             ${Leveys_tekstikenttä}
    Element Should Contain                      ${Leveys_lisätty_järjestelmään}    -
    Element Should Contain                      ${Leveys_muokattu_viimeksi}        -


Leveyden_muokkaus_peruutus  [arguments]         ${testipaikka}
    Log                                         Testataan leveyden muokkaaminen ja peruutus
    Testin Aloitus
    Vaihda Tietolaji                            ${TL_Leveys_RB}
    Paikanna osoite                             ${testipaikka}
    Zoomaa kartta                               5    20 m
    Odota sivun latautuminen
    Siirry Muokkaustilaan
    Wait Until Element Is Not Visible           ${Map_popup}
    Wait Until Keyword Succeeds    3 x    2 s   Click Element At Coordinates    ${Kartta}  0  20

    Wait Until Element Is Visible               ${Leveys_tekstikenttä}
    Input Text                                  ${Leveys_tekstikenttä}    400    True
    Element Attribute Value Should Be           ${Leveys_tekstikenttä}    value    400

    Wait Until Element Is Visible               ${FA_footer_Peruuta}
    Click Element                               ${FA_footer_Peruuta}
    Wait Until Element Is Not Visible           ${Spinner_Overlay}
    Siirry Katselutilaan


Leveyden_muokkaus_tallennus  [arguments]                ${testipaikka}
    Log                                         Testataan leveyden muokkaaminen ja tallennus
    Testin Aloitus
    Vaihda Tietolaji                            ${TL_Leveys_RB}
    Paikanna osoite                             ${testipaikka}
    Zoomaa kartta                               5    20 m
    Odota sivun latautuminen
    Siirry Muokkaustilaan
    Wait Until Element Is Not Visible           ${Map_popup}
    Click Element At Coordinates                ${Kartta}  0  20

    Wait Until Element Is Visible               ${Leveys_muokattava}
    Select Radio Button                         road-width    enabled
    Radio Button Should Be Set To               road-width    enabled
    Wait Until Element Is Visible               ${Leveys_tekstikenttä}
    Input Text                                  ${Leveys_tekstikenttä}    400    True
    Element Attribute Value Should Be           ${Leveys_tekstikenttä}    value    400
    Wait Until Element Is Visible               ${FA_footer_Tallenna}
    Click Element                               ${FA_footer_Tallenna}

    Wait Until Element Is Not Visible           ${Spinner_Overlay}
    Click Element At Coordinates                ${Kartta}  0  20
    Wait Until Element Is Visible               xpath=//*[@id="road-width"]
    Element Attribute Value Should Be           xpath=//*[@id="road-width"]  value  400
    Click Element At Coordinates                ${Kartta}  100  0
    Nollaa Leveys


Leveyden katkaisu    [arguments]    ${testipaikka}
    Log    Katkaisutyökalun testaaminen
    Vaihda Tietolaji                            ${TL_Leveys_RB}
    Paikanna osoite                             ${testipaikka}
    Zoomaa kartta                               5    100m

    Odota sivun latautuminen
    Siirry Muokkaustilaan
    Log    Leikataan tielinkki kahteen osaan
    Wait Until Element Is Visible              ${Muokkaustila_Leikkaus}
    Click Element                              ${Muokkaustila_Leikkaus}

    Odota sivun latautuminen
    Click Element At Coordinates               ${Kartta}  0  10
    Wait Until Element Is Visible              ${Leveys_leikkausnäkymä_A}
    Element Should Be Visible                  ${Leveys_leikkausnäkymä_B}

    #Leveys-tietolajin vaatimus 5a    kokeillaan radionapit
    Select Radio Button                         road-width-a    disabled
    Radio Button Should Be Set To               road-width-a    disabled
    Select Radio Button                         road-width-b    disabled
    Radio Button Should Be Set To               road-width-b    disabled

    Select Radio Button                         road-width-a    enabled
    Radio Button Should Be Set To               road-width-a    enabled
    Select Radio Button                         road-width-b    enabled
    Radio Button Should Be Set To               road-width-b    enabled

    Input Text                                  ${Leveys_katkaisu_tekstiruutu_A}  ${Leveys_katkaisu_tekstiruutu_A_arvo}
    Input Text                                  ${Leveys_katkaisu_tekstiruutu_B}  ${Leveys_katkaisu_tekstiruutu_B_arvo}
    Element Attribute Value Should Be           ${Leveys_katkaisu_tekstiruutu_A}  value    ${Leveys_katkaisu_tekstiruutu_A_arvo}
    Element Attribute Value Should Be           ${Leveys_katkaisu_tekstiruutu_B}  value    ${Leveys_katkaisu_tekstiruutu_B_arvo}
    Wait Until Element Is Visible               ${FA_footer_Peruuta}
    Element Should Be Enabled                   ${FA_footer_Peruuta}
    Click Element                               ${FA_footer_Peruuta}


Leveystieto usealle linkille    [arguments]    ${testipaikka}
    Log    Usean leveystiedon lisäämistapojen testaaminen
    Vaihda Tietolaji                            ${TL_Leveys_RB}
    Paikanna osoite                             ${testipaikka}
    Odota sivun latautuminen
    Siirry Muokkaustilaan

    #Leveyden lisääminen laatikkotyökalulla
    Log    Tarkistetaan laatikkotyökalu
    Wait Until Element Is Enabled               ${Muokkaustila_Laatikko}
    Click Element                               ${Muokkaustila_Laatikko}
    Suorita laatikkovalinta
    Wait Until Element Is Visible               road-width
    Select Radio Button                         road-width    enabled
    Radio Button Should Be Set To               road-width    enabled
    Wait Until Element Is Visible               ${Leveys_tekstikenttä}
    Input Text                                  ${Leveys_tekstikenttä}    400    True
    Element Attribute Value Should Be           ${Leveys_tekstikenttä}    value    400
    Click Button                                ${FA_header_Tallenna}

    #Muutoksen peruutus (laatikkotyökalu)
    Odota sivun latautuminen
    Element Should Be Visible                   ${Muokkaustila_Laatikko}
    Click Element                               ${Muokkaustila_Laatikko}
    Suorita laatikkovalinta
    Wait Until Element Is Visible               road-width
    Click Button                                ${FA_header_Tallenna}

    #Leveyden lisääminen polygontyökalulla
    Log    Tarkistetaan polygontyökalu
    Odota sivun latautuminen
    Element Should Be Visible                   ${Muokkaustila_PolygonTool}
    Click Element                               ${Muokkaustila_PolygonTool}
    Suorita monivalinta
    Wait Until Element Is Visible               road-width
    Select Radio Button                         road-width    enabled
    Radio Button Should Be Set To               road-width    enabled
    Wait Until Element Is Visible               ${Leveys_tekstikenttä}
    Input Text                                  ${Leveys_tekstikenttä}    400    True
    Element Attribute Value Should Be           ${Leveys_tekstikenttä}    value    400
    Click Button                                ${FA_header_Tallenna}

    #Muutoksen peruutus (polygontyökalu)
    Odota sivun latautuminen
    Element Should Be Visible                   ${Muokkaustila_PolygonTool}
    Click Element                               ${Muokkaustila_PolygonTool}
    Suorita monivalinta
    Wait Until Element Is Visible               road-width
    Click Button                                ${FA_header_Tallenna}
    #varmistetaan, että tietoa ei jää
    Element Should Be Visible                   ${Muokkaustila_PolygonTool}
    Click Element                               ${Muokkaustila_PolygonTool}
    Suorita monivalinta
    Radio Button Should Be Set To               road-width    disabled
    Wait Until Element Is Visible               ${FA_header_Peruuta}
    Click Button                                ${FA_header_Peruuta}


Usean linkin klikkausvalinta    [arguments]                   ${testipaikka}
    Testin Aloitus
    Log    Usean leveystiedon lisäämistapojen testaaminen
    Vaihda Tietolaji                                          ${TL_Leveys_RB}
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
    Wait Until Element Is Visible                             road-width
    Select Radio Button                                       road-width    enabled
    Radio Button Should Be Set To                             road-width    enabled
    Wait Until Element Is Visible                             ${Leveys_tekstikenttä}
    Input Text                                                ${Leveys_tekstikenttä}    400    True
    Element Attribute Value Should Be                         ${Leveys_tekstikenttä}    value    400
    Wait Until Element Is Visible                             ${FA_header_Peruuta}
    Click Button                                              ${FA_header_Peruuta}

    #painetaan control pohjaan ja klikataan
    Hold Control And Click Element At Coordinates             ${Kartta}  0  0
    selenium_extensions.Hold Control And Drag By Offset       ${Kartta}  0  200
    Hold Control And Click Element At Coordinates             ${Kartta}  0  0
    selenium_extensions.Hold Control And Drag By Offset       ${Kartta}  0  -100
    Hold Control And Click Element At Coordinates             ${Kartta}  0  0
    Release Control

    Wait Until Element Is Visible                             road-width
    Select Radio Button                                       road-width    disabled
    Radio Button Should Be Set To                             road-width    disabled
    Click Button                                              ${FA_header_Peruuta}


Nollaa Leveys
    Odota sivun latautuminen
    Wait Until Element Is Not Visible           ${Map_popup}
    Click Element                               ${zoombar_minus}
    Wait Until Keyword Succeeds    3 x    2 s   Click Element At Coordinates    ${Kartta}  0  30
    Wait Until Element Is Visible               ${Leveys_muokattava}
    Select Radio Button                         road-width    disabled
    Radio Button Should Be Set To               road-width    disabled
    Click Element                               ${FA_footer_Tallenna}
    Wait Until Element Is Not Visible           ${Spinner_Overlay}
    Siirry Katselutilaan


*** Variables ***
${Leveys_otsikko}                              css=.input-unit-combination
${Leveys_muokattava}                           css=.form-editable-road-width
${Leveys_lisätty_järjestelmään}                xpath=//*[@id="feature-attributes-form"]/div/div/div[1]/p
${Leveys_muokattu_viimeksi}                    xpath=//*[@id="feature-attributes-form"]/div/div/div[2]/p
${Leveys_linkkien_lukumäärä}                   xpath=//*[@id="feature-attributes-form"]/div/div/div[3]/p
${Leveys_tietoruutu_boolean}                   xpath=//*[@id="feature-attributes-form"]/div/div/div[4]/p
${Leveys_valintaryhmä}                         css=.choice-group
${Leveys_cm_lukema}                            cm
${Leveys_tekstikenttä}                         css=#road-width
${Leveys_leikkausnäkymä_A}                     css=.form-editable-road-width-a
${Leveys_leikkausnäkymä_B}                     css=.form-editable-road-width-b
${Leveys_monivalinta_ruutu}                    css=div.form-elements-container
${Leveys_katkaisu_tekstiruutu_A}               xpath=/html/body/div[1]/div[2]/main/article/div/div/div[4]/div[2]/div[1]/input
${Leveys_katkaisu_tekstiruutu_B}               xpath=/html/body/div[1]/div[2]/main/article/div/div/div[5]/div[2]/div[1]/input
${Leveys_katkaisu_tekstiruutu_A_arvo}          955
${Leveys_katkaisu_tekstiruutu_B_arvo}          330