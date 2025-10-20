#       Joni Laari      Sitowise Oy     2022

*** Settings ***
Documentation       Keywords for road-width (Leveys)
Library             SeleniumLibrary
Resource            common_keywords.robot


*** Keywords ***
Leveyden Tarkistus    [Arguments]    ${testipaikka}
    Log    Päällysteen tarkastelu katselumoodissa
    Vaihda Tietolaji    ${TL_Leveys_RB}
    Paikanna Osoite    ${testipaikka}
    Zoomaa Kartta    5    200
    Odota Sivun Latautuminen
    # klikkauksen kokeilu
    Click Center Of The Map And Wait For Locator    ${Leveys_otsikko}
    Element Should Contain    ${Leveys_otsikko}    ${Leveys_cm_lukema}
    Element Should Be Visible    ${Leveys_lisätty_järjestelmään}
    Element Should Be Visible    ${Leveys_muokattu_viimeksi}
    Element Should Be Visible    ${Leveys_linkkien_lukumäärä}
    Element Should Be Visible    ${Leveys_tietoruutu_boolean}
    Click Element At Coordinates    ${Kartta}  0  100
    #tuplaklikki
    Tuplaklikkaa Kartan Keskella Ja Odota Lokaattori    ${Leveys_otsikko}
    Element Should Contain    ${Leveys_otsikko}    ${Leveys_cm_lukema}
    Element Should Be Visible    ${Leveys_lisätty_järjestelmään}
    Element Should Be Visible    ${Leveys_muokattu_viimeksi}
    Element Should Be Visible    ${Leveys_linkkien_lukumäärä}
    Element Should Be Visible    ${Leveys_tietoruutu_boolean}
    Click Element At Coordinates    ${Kartta}  0  100


Leveyden Radionappi    [Arguments]    ${testipaikka}    ${lisäyspäivä}
    # testattava sijainnilla, jossa ei ole olemassaolevaa leveystietoa
    Log    Testataan radio button
    Testin Aloitus
    Vaihda Tietolaji    ${TL_Leveys_RB}
    Paikanna Osoite    ${testipaikka}
    Zoomaa Kartta    5   100 m
    Odota Sivun Latautuminen
    Siirry Muokkaustilaan
    Wait Until Element Is Not Visible    ${Map_popup}
    Wait Until Keyword Succeeds    3 x    2 s    Click Element At Coordinates    ${Kartta}  0  20
    # Annetaan leveystiedot
    Wait Until Element Is Visible    ${Leveys_tekstikenttä}
    Select Radio Button    road-width    enabled
    Radio Button Should Be Set To    road-width    enabled
    Wait Until Element Is Visible    ${Leveys_tekstikenttä}
    Input Text    ${Leveys_tekstikenttä}    400    True
    Element Attribute Value Should Be    ${Leveys_tekstikenttä}    value    400
    # Poistetaan leveystiedot
    Select Radio Button    road-width    disabled
    Radio Button Should Be Set To    road-width    disabled
    Click Element    ${FA_footer_Peruuta}
    Wait Until Element Is Not Visible    ${Spinner_Overlay}
    # tarkistetaan, ettei tietoa tallentunut
    Wait Until Keyword Succeeds    3 x    2 s   Click Element At Coordinates    ${Kartta}  0  20
    Element Should Not Be Clickable    ${Leveys_tekstikenttä}
    Element Should Contain    ${Leveys_lisätty_järjestelmään}    ${lisäyspäivä}


Leveyden Muokkaus Peruutus    [Arguments]    ${testipaikka}
    Log    Testataan leveyden muokkaaminen ja peruutus
    Testin Aloitus
    Vaihda Tietolaji    ${TL_Leveys_RB}
    Paikanna Osoite    ${testipaikka}
    Zoomaa Kartta    5    20 m
    Odota Sivun Latautuminen
    Siirry Muokkaustilaan
    Wait Until Element Is Not Visible    ${Map_popup}
    Wait Until Keyword Succeeds    3 x    2 s    Click Element At Coordinates    ${Kartta}    0    20
    Wait Until Element Is Visible    ${Leveys_tekstikenttä}
    Input Text    ${Leveys_tekstikenttä}    400    True
    Element Attribute Value Should Be    ${Leveys_tekstikenttä}    value    400
    Wait Until Element Is Visible    ${FA_footer_Peruuta}
    Click Element    ${FA_footer_Peruuta}
    Wait Until Element Is Not Visible    ${Spinner_Overlay}
    Siirry Katselutilaan


Leveyden Muokkaus Tallennus    [Arguments]    ${testipaikka}
    # jos testi keskeytyy tallennuksen jälkeen, käytävä korjaamassa sijainnin tielinkki käsin
    Log    Testataan leveyden muokkaaminen ja tallennus
    Testin Aloitus
    Vaihda Tietolaji    ${TL_Leveys_RB}
    Paikanna Osoite    ${testipaikka}
    Zoomaa Kartta    5    20 m
    Odota Sivun Latautuminen
    Siirry Muokkaustilaan
    Wait Until Element Is Not Visible    ${Map_popup}
    Click Center Of The Map And Wait For Locator    ${Leveys_muokattava}
    Select Radio Button    road-width    enabled
    Radio Button Should Be Set To    road-width    enabled
    Wait Until Element Is Visible    ${Leveys_tekstikenttä}
    Input Text    ${Leveys_tekstikenttä}    400    True
    Element Attribute Value Should Be    ${Leveys_tekstikenttä}    value    400
    Wait Until Element Is Visible    ${FA_footer_Tallenna}
    Tallenna Muutokset
    Click Center Of The Map And Wait For Locator    xpath=//*[@id="road-width"]
    Element Attribute Value Should Be    xpath=//*[@id="road-width"]  value  400
    Click Element At Coordinates    ${Kartta}  100  0
    Nollaa Leveys


Leveyden Katkaisu    [Arguments]    ${testipaikka}
    Log    Katkaisutyökalun testaaminen
    Vaihda Tietolaji    ${TL_Leveys_RB}
    Paikanna Osoite    ${testipaikka}
    Zoomaa Kartta    5    100m
    Odota Sivun Latautuminen
    Siirry Muokkaustilaan
    Log    Leikataan tielinkki kahteen osaan
    Wait Until Element Is Visible    ${Muokkaustila_Leikkaus}
    Click Element    ${Muokkaustila_Leikkaus}
    Odota sivun latautuminen
    Click Element At Coordinates    ${Kartta}    0    10
    Wait Until Element Is Visible    ${Leveys_leikkausnäkymä_A}
    Element Should Be Visible    ${Leveys_leikkausnäkymä_B}
    # Leveys-tietolajin vaatimus 5a    kokeillaan radionapit
    Select Radio Button    road-width-a    disabled
    Radio Button Should Be Set To    road-width-a    disabled
    Select Radio Button    road-width-b    disabled
    Radio Button Should Be Set To    road-width-b    disabled
    Select Radio Button    road-width-a    enabled
    Radio Button Should Be Set To    road-width-a    enabled
    Select Radio Button    road-width-b    enabled
    Radio Button Should Be Set To    road-width-b    enabled
    Input Text    ${Leveys_katkaisu_tekstiruutu_A}    ${Leveys_katkaisu_tekstiruutu_A_arvo}
    Input Text    ${Leveys_katkaisu_tekstiruutu_B}    ${Leveys_katkaisu_tekstiruutu_B_arvo}
    Element Attribute Value Should Be    ${Leveys_katkaisu_tekstiruutu_A}    value    ${Leveys_katkaisu_tekstiruutu_A_arvo}
    Element Attribute Value Should Be    ${Leveys_katkaisu_tekstiruutu_B}    value    ${Leveys_katkaisu_tekstiruutu_B_arvo}
    Wait Until Element Is Visible    ${FA_footer_Peruuta}
    Element Should Be Enabled    ${FA_footer_Peruuta}
    Click Element    ${FA_footer_Peruuta}


Leveystieto Usealle Linkille Laatikolla    [Arguments]    ${testipaikka}
    # testattava sijainnilla, jossa ei ole olemassaolevaa leveystietoa
    Log    Usean leveystiedon lisäämistapojen testaaminen
    Vaihda Tietolaji    ${TL_Leveys_RB}
    Paikanna Osoite    ${testipaikka}
    Odota Sivun Latautuminen
    Siirry Muokkaustilaan
    # Leveyden lisääminen laatikkotyökalulla
    Log    Tarkistetaan laatikkotyökalu
    Wait Until Element Is Enabled    ${Muokkaustila_Laatikko}
    Click Element    ${Muokkaustila_Laatikko}
    Suorita Laatikkovalinta
    Wait Until Element Is Visible    road-width
    Select Radio Button    road-width    enabled
    Radio Button Should Be Set To    road-width    enabled
    Wait Until Element Is Visible    ${Leveys_tekstikenttä}
    Input Text    ${Leveys_tekstikenttä}    400    True
    Element Attribute Value Should Be    ${Leveys_tekstikenttä}    value    400
    Tallenna Dialogista
    # Muutoksen peruutus (laatikkotyökalu)
    Odota Sivun Latautuminen
    Element Should Be Visible    ${Muokkaustila_Laatikko}
    Click Element    ${Muokkaustila_Laatikko}
    Suorita Laatikkovalinta
    # tarkistetaan, että leveys oli tallentunut
    Wait Until Element Is Visible    ${Leveys_tekstikenttä}
    Element Attribute Value Should Be    ${Leveys_tekstikenttä}    value    400
    Wait Until Element Is Visible    road-width
    Tallenna Dialogista


Leveystieto Usealle Linkille Polygonilla    [Arguments]    ${testipaikka}
    # testattava sijainnilla, jossa ei ole olemassaolevaa leveystietoa
    Log    Usean leveystiedon lisäämistapojen testaaminen
    Vaihda Tietolaji    ${TL_Leveys_RB}
    Paikanna Osoite    ${testipaikka}
    Odota Sivun Latautuminen
    Siirry Muokkaustilaan
    # Leveyden lisääminen polygontyökalulla
    Log    Tarkistetaan polygontyökalu
    Odota Sivun Latautuminen
    Element Should Be Visible    ${Muokkaustila_PolygonTool}
    Click Element    ${Muokkaustila_PolygonTool}
    Suorita Monivalinta
    Wait Until Element Is Visible    road-width
    Select Radio Button    road-width    enabled
    Radio Button Should Be Set To    road-width    enabled
    Wait Until Element Is Visible    ${Leveys_tekstikenttä}
    Input Text    ${Leveys_tekstikenttä}    400    True
    Element Attribute Value Should Be    ${Leveys_tekstikenttä}    value    400
    Tallenna Dialogista
    # Muutoksen peruutus (polygontyökalu)
    Odota Sivun Latautuminen
    Element Should Be Visible    ${Muokkaustila_PolygonTool}
    Click Element    ${Muokkaustila_PolygonTool}
    Suorita Monivalinta
    # tarkistetaan, että leveys oli tallentunut
    Wait Until Element Is Visible    ${Leveys_tekstikenttä}
    Element Attribute Value Should Be    ${Leveys_tekstikenttä}    value    400
    Wait Until Element Is Visible    road-width
    Tallenna Dialogista
    # varmistetaan, että tietoa ei jää
    Element Should Be Visible    ${Muokkaustila_PolygonTool}
    Click Element    ${Muokkaustila_PolygonTool}
    Suorita Monivalinta
    Radio Button Should Be Set To    road-width    disabled
    Wait Until Element Is Visible    ${FA_header_Peruuta}
    Click Button    ${FA_header_Peruuta}


Usean Linkin Klikkausvalinta    [Arguments]    ${testipaikka}
    # testattava sijainnilla, jossa on suoraan pohjois-etelä-suunnassa kulkeva linkki
    Testin Aloitus
    Log    Usean leveystiedon lisäämistapojen testaaminen
    Vaihda Tietolaji    ${TL_Leveys_RB}
    Paikanna Osoite    ${testipaikka}
    Zoomaa Kartta   5    20 m
    Odota Sivun Latautuminen
    Siirry Muokkaustilaan
    Wait Until Element Is Not Visible    ${Map_popup}
    # painetaan control pohjaan ja klikataan
    Hold Control And Click Element At Coordinates    ${Kartta}    0    0
    selenium_extensions.Hold Control And Drag By Offset    ${Kartta}    0    100
    Click Element At Coordinates    ${Kartta}    0    0
    selenium_extensions.Hold Control And Drag By Offset    ${Kartta}    0    -200
    Click Element At Coordinates    ${Kartta}    0    0
    Release Control
    Odota Sivun Latautuminen
    Wait Until Element Is Visible    road-width
    Select Radio Button    road-width    enabled
    Radio Button Should Be Set To    road-width    enabled
    Wait Until Element Is Visible    ${Leveys_tekstikenttä}
    Input Text    ${Leveys_tekstikenttä}    400    True
    Element Attribute Value Should Be    ${Leveys_tekstikenttä}    value    400
    Wait Until Element Is Visible    ${FA_header_Peruuta}
    Click Button    ${FA_header_Peruuta}
    # painetaan control pohjaan ja klikataan
    Hold Control And Click Element At Coordinates    ${Kartta}    0    0
    selenium_extensions.Hold Control And Drag By Offset    ${Kartta}    0    200
    Hold Control And Click Element At Coordinates    ${Kartta}    0    0
    selenium_extensions.Hold Control And Drag By Offset    ${Kartta}    0    -100
    Hold Control And Click Element At Coordinates    ${Kartta}    0    0
    Release Control
    Wait Until Element Is Visible    road-width
    Select Radio Button    road-width    disabled
    Radio Button Should Be Set To    road-width    disabled
    Click Button    ${FA_header_Peruuta}


Nollaa Leveys
    Odota sivun latautuminen
    Wait Until Element Is Not Visible    ${Map_popup}
    Click Element    ${zoombar_minus}
    Wait Until Keyword Succeeds    3 x    2 s   Click Element At Coordinates    ${Kartta}  0  30
    Wait Until Element Is Visible    ${Leveys_muokattava}
    Select Radio Button    road-width    disabled
    Radio Button Should Be Set To    road-width    disabled
    Tallenna Muutokset
    Siirry Katselutilaan


*** Variables ***
${Leveys_otsikko}                              css=.input-unit-combination
${Leveys_muokattava}                           css=.form-editable-road-width
${Leveys_lisätty_järjestelmään}                css=#feature-attributes-form > div > div > div:nth-child(1) > p
${Leveys_muokattu_viimeksi}                    css=#feature-attributes-form > div > div > div:nth-child(2) > p
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
