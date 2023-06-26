#       Joni Laari      Sitowise     2023

*** Settings ***
Documentation       Keywords for roadworks (Tietyöt)
Resource    common_keywords.robot
Library    robotframework-doctestlibrary
Library    DocTest.VisualTest

*** Keywords ***
Tietyön tarkastelu   [arguments]            ${testipaikka}
    #Testitapaukset 1 ja 2
    Log     Tietyön tarkastelu katselutilassa.
    Vaihda Tietolaji                            ${TL_Tietyöt_RB}
    Paikanna osoite                             ${testipaikka}
    Zoomaa kartta                               5   20 m
    TRY
        Odota sivun latautuminen
    EXCEPT    
        Log    Sivu ei lataudu oikein
    END
    Odota sivun latautuminen
    Select Checkbox                ${Tietyö_liikennemerkki_valinta}
    Checkbox Should Be Selected    ${Tietyö_liikennemerkki_valinta}
    Select Checkbox                ${Tietyö_täydentävätlinkit_valinta}
    Checkbox Should Be Selected    ${Tietyö_täydentävätlinkit_valinta}
    Odota sivun latautuminen


Tietyön tarkastelu_FA    [arguments]        ${testipaikka}
    #testitapaus 3
    Vaihda Tietolaji                            ${TL_Tietyöt_RB}
    Paikanna osoite                             ${testipaikka}
    Zoomaa kartta                               5   50 m
    Odota sivun latautuminen
    Click Element At Coordinates                ${Kartta}   0  20
    Wait Until Element Is Visible               ${FA_otsikko}
    Element Should Be Visible                   ${FA_tietyö_kohde_ID}
    Element Should Be Visible                   ${FA_tietyö_Lisätty_järjestelmään}
    Element Should Be Visible                   ${FA_tietyö_Muokattu_viimeksi}
    Element Should Be Visible                   ${FA_tietyö_Linkkien_lukumäärä}
    Element Should Be Visible                   ${FA_tietyö_Olemassaoleva_tietyö}
    Element Should Be Visible                   ${FA_tietyö_Tietyön_tunnus}
    Element Should Be Visible                   ${FA_tietyö_Tietyön_pvm}
    Click Element At Coordinates                ${Kartta}  -100  -100
    
    #double click
    Tupla Klikkaa Kartan Keskelle
    Wait Until Element Is Visible               ${FA_otsikko}
    Element Should Be Visible                   ${FA_tietyö_kohde_ID}
    Element Should Be Visible                   ${FA_tietyö_Lisätty_järjestelmään}
    Element Should Be Visible                   ${FA_tietyö_Muokattu_viimeksi}
    Element Should Be Visible                   ${FA_tietyö_Linkkien_lukumäärä}
    Element Should Be Visible                   ${FA_tietyö_Olemassaoleva_tietyö}
    Element Should Be Visible                   ${FA_tietyö_Tietyön_tunnus}
    Element Should Be Visible                   ${FA_tietyö_Tietyön_pvm}


Tietyön_vaihto_peruutus    [arguments]        ${testipaikka}    ${tietyöteksti}
    #testitapaus 4
    Log     Tietyön muokkaus koko ketjulle
    Testin Aloitus
    Vaihda Tietolaji                            ${TL_Tietyöt_RB}
    Paikanna osoite                             ${testipaikka}
    Zoomaa kartta                               5   50 m
    Odota sivun latautuminen
    Siirry Muokkaustilaan
    Wait Until Element Is Not Visible           ${Map_popup}
    Click Element At Coordinates                ${Kartta}  0  20
    Wait Until Element Is Visible               ${FA_tietyö_Lisätty_järjestelmään}
    Element Should Be Visible                   ${FA_tietyö_Muokattu_viimeksi}
    Element Should Be Visible                   ${FA_tietyö_Linkkien_lukumäärä}

    Select Radio Button                         road-works-asset    enabled
    Radio Button Should Be Set To               road-works-asset    enabled
    Input Text                                  ${FA_tietyö_tietyön_kuvaus}    ${tietyöteksti}
    Element Should Be Visible                   ${FA_tietyö_aloituspvm}
    Click Element                               ${FA_tietyö_aloituspvm}
    Press Keys                                  None    ARROW_RIGHT
    Press Keys                                  None    ENTER

    Element Should Be Visible                   ${FA_tietyö_päättymispvm}
    Click Element                               ${FA_tietyö_päättymispvm}

    FOR    ${tietyö_nuolinäppäin_laskuri}    IN RANGE    10
        Press Keys                              None    ARROW_RIGHT
    END
    Press Keys                                  None    ENTER

    #muutoksen peruutus
    Element Should Be Enabled                   ${FA_footer_Tallenna}    #tarkistetaan että tallennusnappi on painettavissa, mutta ei paineta
    Click Element                               ${FA_footer_Peruuta}

    #varmistetaan ettei vääränlainen muutos (loppupvm ennen alkua) tallennu
    Click Element At Coordinates                ${Kartta}  0  20
    Wait Until Element Is Visible               ${FA_tietyö_Lisätty_järjestelmään}
    Element Should Be Visible                   ${FA_tietyö_Muokattu_viimeksi}
    Element Should Be Visible                   ${FA_tietyö_Linkkien_lukumäärä}

    Radio Button Should Be Set To               road-works-asset    enabled
    Input Text                                  ${FA_tietyö_tietyön_kuvaus}    ${tietyöteksti}
    Element Should Be Visible                   ${FA_tietyö_aloituspvm}
    Click Element                               ${FA_tietyö_aloituspvm}
    FOR    ${tietyö_nuolinäppäin_laskuri}    IN RANGE    20
        Press Keys                              None    ARROW_LEFT
    END
    Press Keys                                  None    ENTER
    Element Should Be Visible                   ${FA_tietyö_päättymispvm}
    Element Should Be Disabled                  ${FA_footer_Tallenna}
    Click Element                               ${FA_footer_Peruuta}


Usean_tietyön_muuttaminen_klikkaamalla    [arguments]        ${testipaikka}    ${tietyöteksti}
    #testitapaus 5a
    Log    Muutetaan usean linkin tietyötietoa
    Testin Aloitus
    Vaihda Tietolaji                            ${TL_Tietyöt_RB}
    Paikanna osoite                             ${testipaikka}
    Zoomaa kartta                               5   100 m
    Odota sivun latautuminen
    Siirry Muokkaustilaan
    Wait Until Element Is Not Visible           ${Map_popup}

    #Tietöiden lisääminen ctrl+klikkauksella, testattava pohjois-eteläsuuntaisella linkillä
    Log    Tarkistetaan monivalinta hiirellä
    Hold Control And Click Element At Coordinates             ${Kartta}  0  0
    selenium_extensions.Hold Control And Drag By Offset       ${Kartta}  0  100
    Click Element At Coordinates                              ${Kartta}  0  0
    selenium_extensions.Hold Control And Drag By Offset       ${Kartta}  0  -200
    Click Element At Coordinates                              ${Kartta}  0  0
    Release Control

    #popupin tiedot
    Wait Until Element Is Visible               ${Tietyö_popup_otsikko}
    Select Radio Button                         road-works-asset    enabled
    Radio Button Should Be Set To               road-works-asset    enabled
    
    Input Text                                  ${Tietyö_popup_työntunnus}    ${tietyöteksti}
    Element Should Be Visible                   ${Tietyö_popup_aloituspvm}
    Click Element                               ${Tietyö_popup_aloituspvm}
    Press Keys                                  None    ARROW_RIGHT
    Press Keys                                  None    ENTER

    Element Should Be Visible                   ${Tietyö_popup_päättymispvm}
    Click Element                               ${Tietyö_popup_päättymispvm}

    FOR    ${tietyö_nuolinäppäin_laskuri}    IN RANGE    10
        Press Keys                              None    ARROW_RIGHT
    END
    Press Keys                                  None    ENTER

    #muutoksen peruutus
    Element Should Be Enabled                   ${FA_header_Tallenna}    #tarkistetaan että tallennusnappi on painettavissa, mutta ei paineta
    Click Element                               ${FA_header_Peruuta}


Usean_tietyön_muuttaminen_laatikolla    [arguments]        ${testipaikka}    ${tietyöteksti}
    Log     Usean tietyön lisäämistapojen testaaminen
    Log    Tarkistetaan laatikkotyökalu
    #testataan tietyön lisääminen
    Testin Aloitus
    Vaihda Tietolaji                            ${TL_Tietyöt_RB}
    Paikanna osoite                             ${testipaikka}
    Zoomaa kartta                               5   100 m
    Odota sivun latautuminen
    Siirry Muokkaustilaan
    Wait Until Element Is Not Visible           ${Map_popup}
    #Tietyön lisääminen laatikkotyökalulla
    Log    Tarkistetaan laatikkotyökalu
    Wait Until Element Is Visible               ${Muokkaustila_Laatikko}
    Click Element                               ${Muokkaustila_Laatikko}
    Suorita laatikkovalinta

    #popupin tiedot
    Wait Until Element Is Visible               ${Tietyö_popup_otsikko}
    Select Radio Button                         road-works-asset    enabled
    Radio Button Should Be Set To               road-works-asset    enabled
    
    Input Text                                  ${Tietyö_popup_työntunnus}    ${tietyöteksti}
    Element Should Be Visible                   ${Tietyö_popup_aloituspvm}
    Click Element                               ${Tietyö_popup_aloituspvm}
    Press Keys                                  None    ARROW_RIGHT
    Press Keys                                  None    ENTER

    Element Should Be Visible                   ${Tietyö_popup_päättymispvm}
    Click Element                               ${Tietyö_popup_päättymispvm}

    FOR    ${tietyö_nuolinäppäin_laskuri}    IN RANGE    10
        Press Keys                              None    ARROW_RIGHT
    END
    Press Keys                                  None    ENTER

    #muutoksen peruutus
    Element Should Be Enabled                   ${FA_header_Tallenna}    #tarkistetaan että tallennusnappi on painettavissa, mutta ei paineta
    Click Element                               ${FA_header_Peruuta}


Usean_tietyön_muuttaminen_polygonilla    [arguments]        ${testipaikka}    ${tietyöteksti}
    #testitapaus 5c
    Log    Usean tietyön lisäämistapojen testaaminen
    Log    Tarkistetaan polygontyökalu
    #testataan tietyön lisääminen
    Testin Aloitus
    Vaihda Tietolaji                            ${TL_Tietyöt_RB}
    Paikanna osoite                             ${testipaikka}
    Zoomaa kartta                               5   100 m
    Odota sivun latautuminen
    Siirry Muokkaustilaan
    Wait Until Element Is Not Visible           ${Map_popup}
    #Tietyön lisääminen polygontyökalulla
    Log    Tarkistetaan polygontyökalu
    Wait Until Element Is Visible               ${Muokkaustila_PolygonTool}
    Click Element                               ${Muokkaustila_PolygonTool}
    Suorita monivalinta

    #popupin tiedot
    Wait Until Element Is Visible               ${Tietyö_popup_otsikko}
    Select Radio Button                         road-works-asset    enabled
    Radio Button Should Be Set To               road-works-asset    enabled
    
    Input Text                                  ${Tietyö_popup_työntunnus}    ${tietyöteksti}
    Element Should Be Visible                   ${Tietyö_popup_aloituspvm}
    Click Element                               ${Tietyö_popup_aloituspvm}
    Press Keys                                  None    ARROW_RIGHT
    Press Keys                                  None    ENTER

    Element Should Be Visible                   ${Tietyö_popup_päättymispvm}
    Click Element                               ${Tietyö_popup_päättymispvm}

    FOR    ${tietyö_nuolinäppäin_laskuri}    IN RANGE    10
        Press Keys                              None    ARROW_RIGHT
    END
    Press Keys                                  None    ENTER

    #muutoksen peruutus
    Element Should Be Enabled                   ${FA_header_Tallenna}    #tarkistetaan että tallennusnappi on painettavissa, mutta ei paineta
    Click Element                               ${FA_header_Peruuta}


Tietyön katkaisu    [arguments]        ${testipaikka}    ${tietyöteksti}    ${tietyöteksti2}
    Testin Aloitus
    Vaihda Tietolaji                            ${TL_Tietyöt_RB}
    Paikanna osoite                             ${testipaikka}
    Zoomaa kartta                               5   50 m
    Odota sivun latautuminen
    Siirry Muokkaustilaan
    Wait Until Element Is Not Visible           ${Map_popup}
    Click Element At Coordinates                ${Kartta}  0  20
    Wait Until Element Is Visible               ${FA_tietyö_Lisätty_järjestelmään}
    Element Should Be Visible                   ${FA_tietyö_Muokattu_viimeksi}
    Element Should Be Visible                   ${FA_tietyö_Linkkien_lukumäärä}

    Select Radio Button                         road-works-asset    enabled
    Radio Button Should Be Set To               road-works-asset    enabled
    Input Text                                  ${FA_tietyö_tietyön_kuvaus}    ${tietyöteksti}
    Element Should Be Visible                   ${FA_tietyö_aloituspvm}
    Click Element                               ${FA_tietyö_aloituspvm}
    Press Keys                                  None    ARROW_RIGHT
    Press Keys                                  None    ENTER

    Element Should Be Visible                   ${FA_tietyö_päättymispvm}
    Click Element                               ${FA_tietyö_päättymispvm}

    FOR    ${tietyö_nuolinäppäin_laskuri}    IN RANGE    10
        Press Keys                              None    ARROW_RIGHT
    END
    Press Keys                                  None    ENTER

    Element Should Be Enabled                   ${FA_footer_Tallenna}
    Click Element                               ${FA_footer_Tallenna}

    Wait Until Element Is Not Visible           ${Map_popup}
    Wait Until Element Is Visible               ${Muokkaustila_Leikkaus}
    Click Element                               ${Muokkaustila_Leikkaus}
    Click Element At Coordinates                ${Kartta}  0  20
    Wait Until Element Is Visible               ${FA_tietyö_Lisätty_järjestelmään}
    Element Should Be Visible                   ${FA_tietyö_Muokattu_viimeksi}
    Element Should Be Visible                   ${FA_tietyö_Linkkien_lukumäärä}

    Input Text                                  ${Tietyö_FA_työntunnus_katkaisu_B}    ${tietyöteksti2}

    Element Should Be Enabled                   ${FA_header_Tallenna}

    Select Radio Button                         road-works-asset-a    disabled
    Radio Button Should Be Set To               road-works-asset-a    disabled

    Select Radio Button                         road-works-asset-b    disabled
    Radio Button Should Be Set To               road-works-asset-b    disabled

    Click Element                               xpath=/html/body/div[1]/div[2]/footer/div/button[2]
    Odota sivun latautuminen

    Click Element At Coordinates                ${Kartta}  0  20
    Wait Until Element Is Visible               ${FA_tietyö_Lisätty_järjestelmään}
    Element Should Be Visible                   ${FA_tietyö_Muokattu_viimeksi}
    Element Should Be Visible                   ${FA_tietyö_Linkkien_lukumäärä}

    Select Radio Button                         road-works-asset    disabled
    Radio Button Should Be Set To               road-works-asset    disabled

    Element Should Be Enabled                   ${FA_header_Tallenna}
    Click Element                               ${FA_header_Tallenna}


Tietyö kaksisuuntaiseksi    [arguments]        ${testipaikka}    ${tietyöteksti}    ${tietyöteksti2}
    Testin Aloitus
    Log    Tietyön vaihto kaksisuuntaiseksi
    Vaihda Tietolaji                            ${TL_Tietyöt_RB}
    Paikanna osoite                             ${testipaikka}
    Zoomaa kartta                               5   50 m
    Odota sivun latautuminen
    Siirry Muokkaustilaan
    Wait Until Element Is Not Visible           ${Map_popup}
    Tupla Klikkaa Kartan Keskelle
    Wait Until Element Is Visible               ${FA_tietyö_Lisätty_järjestelmään}
    Element Should Be Visible                   ${FA_tietyö_Muokattu_viimeksi}
    Element Should Be Visible                   ${FA_tietyö_Linkkien_lukumäärä}
    Element Should Be Enabled                   ${Tietyö_muutos_kaksisuuntaiseksi}
    Click Element                               ${Tietyö_muutos_kaksisuuntaiseksi}

    Input Text                                  ${Tietyö_FA_työntunnus_kaksisuuntainen_A}    ${tietyöteksti}
    Input Text                                  ${Tietyö_FA_työntunnus_kaksisuuntainen_B}    ${tietyöteksti2}
    Element Should Be Enabled                   ${FA_footer_Tallenna}
    Click Element                               ${FA_footer_Peruuta}


*** Variables ***
${Tietyö_liikennemerkki_valinta}              xpath=/html/body/div[1]/nav/div/div[3]/div[21]/div/div[3]/input
${Tietyö_täydentävätlinkit_valinta}           xpath=/html/body/div[1]/nav/div/div[3]/div[21]/div/div[4]/input

${FA_tietyö_kohde_ID}                         xpath=/html/body/div[1]/div[2]/header/div[1]/span
${FA_tietyö_Lisätty_järjestelmään}            xpath=/html/body/div[1]/div[2]/main/article/div/div/div[1]/p
${FA_tietyö_Muokattu_viimeksi}                xpath=/html/body/div[1]/div[2]/main/article/div/div/div[2]/p
${FA_tietyö_Linkkien_lukumäärä}               xpath=/html/body/div[1]/div[2]/main/article/div/div/div[3]/p
${FA_tietyö_Olemassaoleva_tietyö}             xpath=/html/body/div[1]/div[2]/main/article/div/div/div[4]/p
${FA_tietyö_Tietyön_tunnus}                   xpath=/html/body/div[1]/div[2]/main/article/div/div/div[4]/div[2]/div[1]/p
${FA_tietyö_Tietyön_pvm}                      xpath=/html/body/div[1]/div[2]/main/article/div/div/div[4]/div[2]/div[2]/ul

${FA_tietyö_tietyön_kuvaus}                   xpath=/html/body/div[1]/div[2]/main/article/div/div/div[4]/div[2]/div[1]/input
${FA_tietyö_aloituspvm}                       xpath=/html/body/div[1]/div[2]/main/article/div/div/div[4]/div[2]/div[2]/ul/li/input[1]
${FA_tietyö_päättymispvm}                     xpath=/html/body/div[1]/div[2]/main/article/div/div/div[4]/div[2]/div[2]/ul/li/input[2]

${Tietyö_popup_otsikko}                       xpath=/html/body/div[1]/div[5]/div/div[2]/div/label
${Tietyö_popup_työntunnus}                    xpath=/html/body/div[1]/div[5]/div/div[2]/div/div[2]/div[1]/input

${Tietyö_FA_työntunnus_katkaisu_A}            xpath=/html/body/div[1]/div[2]/main/article/div/div/div[4]/div[2]/div[1]/input
${Tietyö_FA_työntunnus_katkaisu_B}            xpath=/html/body/div[1]/div[2]/main/article/div/div/div[5]/div[2]/div[1]/input

${Tietyö_popup_aloituspvm}                    xpath=/html/body/div[1]/div[5]/div/div[2]/div/div[2]/div[2]/ul/li/input[1]
${Tietyö_popup_päättymispvm}                  xpath=/html/body/div[1]/div[5]/div/div[2]/div/div[2]/div[2]/ul/li/input[2]

${tietyö_nuolinäppäin_laskuri}                1

${tietyö_katkaisu_nappi}                     css=#map-tools > div > div.asset-type-container > div.panel-group.simple-limit.road-works-assets > div > div.panel-section.panel-actions > div.action.cut.active

${Tietyö_muutos_kaksisuuntaiseksi}           id=separate-limit
${Tietyö_FA_työntunnus_kaksisuuntainen_A}    xpath=/html/body/div[1]/div[2]/main/article/div/div/div[4]/div[2]/div[1]/input
${Tietyö_FA_työntunnus_kaksisuuntainen_B}    xpath=/html/body/div[1]/div[2]/main/article/div/div/div[5]/div[2]/div[1]/input