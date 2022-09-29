#       Joni Laari      Sitowise Oy     2022

*** Settings ***
Documentation       Keywords for paving (Päällyste)
Library             SeleniumLibrary
Resource            common_keywords.robot

*** Variables ***

*** Keywords ***
Leveyden_tarkistus   [arguments]                ${testipaikka}
    Log                                         Päällysteen tarkastelu katselumoodissa
    Vaihda Tietolaji                            ${TL_Leveys_RB}
    Paikanna osoite                             ${testipaikka}
    Zoomaa kartta                               5    50
    Odota sivun latautuminen

    #klikkauksen kokeilu
    Click Element At Coordinates                ${Kartta}    0    20
    Wait Until Element Is Visible               ${Leveys_otsikko}
    Element Should Contain                      ${Leveys_otsikko}    ${Leveys_lukema}
    Click Element At Coordinates                ${Kartta}    0    100

    #tuplaklikki
    Tupla Klikkaa Kartan Keskelle
    Wait Until Element Is Visible               ${Leveys_otsikko}
    Element Should Contain                      ${Leveys_otsikko}    ${Leveys_lukema}
    Click Element At Coordinates                ${Kartta}    0    100


Leveyden_radionappi  [arguments]                ${testipaikka}
    Log    Testataan radio button
    Testin Aloitus
    Vaihda Tietolaji                            ${TL_Leveys_RB}
    Paikanna osoite                             ${testipaikka}
    Zoomaa kartta                               5   20 m
    Odota sivun latautuminen
    Siirry Muokkaustilaan
    Wait Until Element Is Not Visible           ${Map_popup}

    Click Element At Coordinates                ${Kartta}  0  20
    #Annetaan leveystiedot
    Wait Until Element Is Visible               ${Leveys_muokattava}
    Select Radio Button                         road-width    enabled
    Radio Button Should Be Set To               road-width    enabled
    Wait Until Element Is Visible               ${Leveys_tekstikenttä}
    Input Text                                  ${Leveys_tekstikenttä}    400    True
    Click Element                               ${FA_footer_Tallenna}
    Wait Until Element Is Not Visible           ${Spinner_Overlay}

    #Poistetaan leveystiedot
    Click Element At Coordinates                ${Kartta}  0  20
    Wait Until Element Is Visible               ${Leveys_muokattava}
    Select Radio Button                         road-width    disabled
    Radio Button Should Be Set To               road-width    disabled
    Click Element                               ${FA_footer_Tallenna}
    Wait Until Element Is Not Visible           ${Spinner_Overlay}


Leveyden_muokkaus_peruutus  [arguments]         ${testipaikka}
    Log                                         Testataan leveyden muokkaaminen ja peruutus
    Testin Aloitus
    Vaihda Tietolaji                            ${TL_Leveys_RB}
    Paikanna osoite                             ${testipaikka}
    Zoomaa kartta                               5    20 m
    Odota sivun latautuminen
    Siirry Muokkaustilaan
    Wait Until Element Is Not Visible           ${Map_popup}
    Click Element At Coordinates                ${Kartta}  0  20

    Wait Until Element Is Visible               ${Leveys_tekstikenttä}
    Input Text                                  ${Leveys_tekstikenttä}    400    True

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

    Wait Until Element Is Visible               ${FA_footer_Tallenna}
    Click Element                               ${FA_footer_Tallenna}

    Wait Until Element Is Not Visible           ${Spinner_Overlay}
    Siirry Katselutilaan
    Nollaa Leveys


Nollaa Leveys
    Odota sivun latautuminen
    Click Element At Coordinates                ${Kartta}  0  20
    Siirry Muokkaustilaan
    Wait Until Element Is Visible               ${Leveys_muokattava}
    Select Radio Button                         road-width    disabled
    Click Element                               ${FA_footer_Tallenna}
    Wait Until Element Is Not Visible           ${Spinner_Overlay}
    Siirry Katselutilaan


*** Variables ***
${Leveys_otsikko}                              css=.input-unit-combination
${Leveys_muokattava}                           css=.form-editable-road-width
${Leveys_lukema}                               cm
${Leveys_tekstikenttä}                         css=#road-width