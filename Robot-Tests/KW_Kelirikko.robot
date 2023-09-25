#       Joni Laari        Sitowise        2023

*** Settings ***
Documentation       Keywords for thaw damage (Kelirikko)
Library             SeleniumLibrary
Resource            common_keywords.robot


*** Keywords ***
Kelirikkotiedon tarkastelu    [arguments]    ${testipaikka}
    Testin Aloitus
    Log                                         Tarkistetaan kelirikon lisäys
    Vaihda Tietolaji                            ${TL_Kelirikko_RB}
    Paikanna osoite                             ${testipaikka}
    Zoomaa kartta                               5    50
    Odota sivun latautuminen

    Click Element At Coordinates                ${Kartta}    0    20
    Wait Until Element Is Visible               ${FA_header_Kelirikko_otsikko}


Kelirikkotiedon lisääminen    [arguments]    ${testipaikka}
    Testin Aloitus
    Log                                         Tarkistetaan kelirikon lisäys
    Vaihda Tietolaji                            ${TL_Kelirikko_RB}
    Paikanna osoite                             ${testipaikka}
    Zoomaa kartta                               5    50
    Siirry Muokkaustilaan
    Odota sivun latautuminen

    Click Element At Coordinates                ${Kartta}    0    20
    Wait Until Element Is Visible               ${FA_header_Kelirikko_otsikko}
    Element Should Be Disabled                  ${Kelirikko_input_kenttä_header}
    Select Radio Button                         road-damaged-by-thaw    enabled
    Radio Button Should Be Set To               road-damaged-by-thaw    enabled

    Input Text                                  ${Kelirikko_input_kenttä_header}    100    #integer
    Element Should Be Enabled                   ${FA_header_Tallenna}
    Clear Element Text                          ${Kelirikko_input_kenttä_header}


Kelirikkotiedon virheellinen lisääminen        [arguments]    ${testipaikka}
    Testin Aloitus
    Log                                         Tarkistetaan kelirikon lisäys
    Vaihda Tietolaji                            ${TL_Kelirikko_RB}
    Paikanna osoite                             ${testipaikka}
    Zoomaa kartta                               5    50
    Siirry Muokkaustilaan
    Odota sivun latautuminen

    Click Element At Coordinates                ${Kartta}    0    20
    Wait Until Element Is Visible               ${FA_header_Kelirikko_otsikko}
    Element Should Be Disabled                  ${Kelirikko_input_kenttä_header}
    Select Radio Button                         road-damaged-by-thaw    enabled
    Radio Button Should Be Set To               road-damaged-by-thaw    enabled

    #lisätään virheellisiä tietomuotoja
    Input Text                                  ${Kelirikko_input_kenttä_header}    -99    #negative
    Element Should Be Disabled                  ${FA_header_Tallenna}
    Clear Element Text                          ${Kelirikko_input_kenttä_header}

    Input Text                                  ${Kelirikko_input_kenttä_header}    asd    #NaN
    Element Should Be Disabled                  ${FA_header_Tallenna}
    Clear Element Text                          ${Kelirikko_input_kenttä_header}

    Input Text                                  ${Kelirikko_input_kenttä_header}    99.99    #float
    Element Should Be Disabled                  ${FA_header_Tallenna}
    Clear Element Text                          ${Kelirikko_input_kenttä_header}


Kelirikon lisääminen laatikko    [arguments]    ${testipaikka}
    Testin Aloitus
    Log                                         Tarkistetaan usean kelirikkotiedon lisäys laatikolla
    Vaihda Tietolaji                            ${TL_Kelirikko_RB}
    Paikanna osoite                             ${testipaikka}
    Zoomaa kartta                               5    200
    Odota sivun latautuminen
    Siirry Muokkaustilaan
    Odota sivun latautuminen
    Wait Until Element Is Enabled               ${Muokkaustila_Laatikko}
    Click Element                               ${Muokkaustila_Laatikko}
    Suorita laatikkovalinta
    Wait Until Element Is Visible               ${Kantavuus_popup_valikko}
    Element Should Be Visible                   ${Kantavuus_popup_valikko}
    Select Radio Button                         ${Kelirikko_näkymä_radionappi_group}    enabled
    Radio Button Should Be Set To               ${Kelirikko_näkymä_radionappi_group}    enabled

    Input Text                                  ${Kelirikko_input_kenttä_header}    5000    #positiivinen kokonaisluku

    #Syötetään päivämäärät
    Element Should Be Visible                   ${Popup_kelirikkokausi_aloituspvm}
    Click Element                               ${Popup_kelirikkokausi_aloituspvm}
    Press Keys                                  None    ARROW_RIGHT
    Press Keys                                  None    ENTER

    Element Should Be Visible                   ${Popup_kelirikkokausi_päättymispvm}
    Click Element                               ${Popup_kelirikkokausi_päättymispvm}

    Kalenterin siirto 10x

    Select Checkbox                             ${Kelirikko_popup_toistuuvuosittain_checkbox}
    Checkbox Should Be Selected                 ${Kelirikko_popup_toistuuvuosittain_checkbox}

    Element Should Be Enabled                   ${FA_header_Tallenna}
    Element Should Be Enabled                   ${FA_header_Peruuta}
    Click Element                               ${FA_header_Peruuta}


Kelirikon lisääminen polygon    [arguments]    ${testipaikka}
    #testitapaus nro 5b
    Testin Aloitus
    Log                                         Tarkistetaan usean kelirikkotiedon lisäys polygonilla
    Vaihda Tietolaji                            ${TL_Kelirikko_RB}
    Paikanna osoite                             ${testipaikka}
    Zoomaa kartta                               5    200
    Odota sivun latautuminen

    Siirry Muokkaustilaan
    Odota sivun latautuminen

    Wait Until Element Is Enabled               ${Muokkaustila_PolygonTool}
    Click Element                               ${Muokkaustila_PolygonTool}
    Suorita monivalinta
    Wait Until Element Is Visible               ${Kantavuus_popup_valikko}
    Element Should Be Visible                   ${Kantavuus_popup_valikko}
    Select Radio Button                         ${Kelirikko_näkymä_radionappi_group}    enabled
    Radio Button Should Be Set To               ${Kelirikko_näkymä_radionappi_group}    enabled

    Input Text                                  ${Kelirikko_input_kenttä_header}    5000    #positiivinen kokonaisluku

    #Syötetään päivämäärät
    Element Should Be Visible                   ${Popup_kelirikkokausi_aloituspvm}
    Click Element                               ${Popup_kelirikkokausi_aloituspvm}
    Press Keys                                  None    ARROW_RIGHT
    Press Keys                                  None    ENTER

    Element Should Be Visible                   ${Popup_kelirikkokausi_päättymispvm}
    Click Element                               ${Popup_kelirikkokausi_päättymispvm}

    Kalenterin siirto 10x

    Select Checkbox                             ${Kelirikko_popup_toistuuvuosittain_checkbox}
    Checkbox Should Be Selected                 ${Kelirikko_popup_toistuuvuosittain_checkbox}

    Element Should Be Enabled                   ${FA_header_Tallenna}
    Element Should Be Enabled                   ${FA_header_Peruuta}
    Click Element                               ${FA_header_Peruuta}


Kelirikon lisääminen ctrl    [arguments]        ${testipaikka}
    Testin Aloitus
    Log                                                       Tarkistetaan usean kelirikkotiedon lisäys ctrl-napilla
    Vaihda Tietolaji                                          ${TL_Kelirikko_RB}
    Paikanna osoite                                           ${testipaikka}
    Zoomaa kartta                                             5    200
    Odota sivun latautuminen
    Siirry Muokkaustilaan
    Odota sivun latautuminen

    #painetaan control pohjaan ja klikataan
    Hold Control And Click Element At Coordinates             ${Kartta}  0  0
    selenium_extensions.Hold Control And Drag By Offset       ${Kartta}  0  100
    Click Element At Coordinates                              ${Kartta}  0  0
    selenium_extensions.Hold Control And Drag By Offset       ${Kartta}  0  -200
    Click Element At Coordinates                              ${Kartta}  0  0
    Release Control

    #lisätään tietoja
    Odota sivun latautuminen
    Wait Until Element Is Visible                             road-damaged-by-thaw
    Select Radio Button                                       road-damaged-by-thaw    enabled
    Radio Button Should Be Set To                             road-damaged-by-thaw    enabled
    Wait Until Element Is Visible                             ${Valaistus_popup_otsikko}
    Wait Until Element Is Visible                             ${FA_header_Peruuta}
    Click Button                                              ${FA_header_Peruuta}


Kelirikon katkaisu    [arguments]    ${testipaikka}    ${kelirikkorajoitus}
    Testin Aloitus
    Vaihda Tietolaji                            ${TL_Kelirikko_RB}
    Paikanna osoite                             ${testipaikka}
    Zoomaa kartta                               5   50 m
    Odota sivun latautuminen
    Siirry Muokkaustilaan
    Wait Until Element Is Not Visible           ${Map_popup}
    Wait Until Element Is Visible               ${Muokkaustila_Leikkaus}
    Click Element                               ${Muokkaustila_Leikkaus}
    Click Element At Coordinates                ${Kartta}  0  20

    #tarkistetaan tiedot
    Wait Until Element Is Visible               ${FA_Lisätty_Järjestelmään}
    Element Should Be Visible                   ${FA_Muokattu_viimeksi}
    Element Should Be Visible                   ${FA_linkkien_lukumaara}
    Radio Button Should Be Set To               road-damaged-by-thaw-a    enabled
    Radio Button Should Be Set To               road-damaged-by-thaw-b    enabled
    Element Attribute Value Should Be           ${Kelirikko_rajoitusarvo_a}    value    ${kelirikkorajoitus}
    Element Attribute Value Should Be           ${Kelirikko_rajoitusarvo_b}    value    ${kelirikkorajoitus}
    Element Attribute Value Should Be           ${Kelirikko_rajoitusarvo_b}    value    ${kelirikkorajoitus}
    Element Attribute Value Should Be           ${Kelirikko_rajoitusarvo_b}    value    ${kelirikkorajoitus}

    Element Should Be Visible                   ${Kelirikkokausi_aloituspvm_a}
    Element Should Be Visible                   ${Kelirikkokausi_aloituspvm_a}
    #Päivämääräkentän tarkkaa sisältöä ei kannata testata, sillä sisältö vaihtuu turhan usein

    Checkbox Should Be Selected                 name=annual_repetition-a
    Checkbox Should Be Selected                 name=annual_repetition-b


*** Variables ***
${FA_header_Kelirikko_otsikko}                   css=#feature-attributes-header
${Kelirikko_input_kenttä_header}                 css=#road-damaged-by-thaw
${Kelirikko_näkymä_radionappi_group}             road-damaged-by-thaw
${Kelirikko_popup_toistuuvuosittain_checkbox}    css=body > div.container > div.modal-overlay.mass-update-modal > div > div.form-elements-container > div > div.input-unit-combination > div:nth-child(3) > div > input
${Popup_kelirikkokausi_aloituspvm}               css=#datePeriod-start1
${Popup_kelirikkokausi_päättymispvm}             css=#datePeriod-end1

#xpathit pakollisia johtuen elementtien nimeämisistä
${Kelirikko_rajoitusarvo_a}                      xpath=/html/body/div[1]/div[2]/main/article/div/div/div[4]/div[2]/div[1]/input
${Kelirikko_rajoitusarvo_b}                      xpath=html/body/div[1]/div[2]/main/article/div/div/div[5]/div[2]/div[1]/input

${Kelirikkokausi_aloituspvm_a}                     id=datePeriod-start1
${Kelirikkokausi_lopetuspvm_a}                     id=datePeriod-end1

${Kelirikkokausi_aloituspvm_b}                     id=datePeriod-start2
${Kelirikkokausi_lopetuspvm_b}                     id=datePeriod-end2