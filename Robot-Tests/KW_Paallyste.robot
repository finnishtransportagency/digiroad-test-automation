#       Joni Laari      Sitowise Oy     2022

*** Settings ***
Documentation       Keywords for paving (Päällyste)
Library    SeleniumLibrary
Resource    common_keywords.robot

*** Variables ***

*** Keywords ***
Päällysteen_tarkastelu   [arguments]            ${testipaikka}
    Log     Päällysteen tarkastelu katselutilassa.
    #testataan valinnan toimivuus
    Vaihda Tietolaji                            ${TL_Päällyste_RB}
    Paikanna osoite                             ${testipaikka}
    Zoomaa kartta                               5   20 m
    Odota sivun latautuminen

    #klikkauksen kokeilu
    Click Element At Coordinates                ${Kartta}   0  20
    Wait Until Element Is Visible               ${Päällysteluokka_Teksti}
    Element Should Contain                      ${Päällysteluokka_Teksti}    ${Päällyste_Kova_asfaltti}
    Click Element At Coordinates                ${Kartta}    0    100


    #tuplaklikin kokeilu
    Tupla Klikkaa Kartan Keskelle
    Wait Until Element Is Visible               ${Päällysteluokka_Teksti}
    Element Should Contain                      ${Päällysteluokka_Teksti}    ${Päällyste_Kova_asfaltti}
    Click Element At Coordinates                ${Kartta}    0    100


Päällysteen_vaihto_peruutus    [arguments]      ${testipaikka}    ${päällysteluokka_parametri}    ${päällysteluokan_nimi}
    Log                                         Testataan päällysteen vaihto
    Testin Aloitus
    Vaihda Tietolaji                            ${TL_Päällyste_RB}
    Paikanna osoite                             ${testipaikka}
    Zoomaa kartta                               5   20 m
    Odota sivun latautuminen
    Siirry Muokkaustilaan
    Wait Until Element Is Not Visible           ${Map_popup}
    Click Element At Coordinates                ${Kartta}  0  20

    #kokeillaan päällystelajin vaihto
    Wait Until Element Is Visible               css=.form-control.paved-road
    Click Element                               css=.form-control.paved-road
    Click Element                               ${päällysteluokka_parametri}

    #muutoksen peruutus
    Wait Until Element Is Visible               ${FA_footer_Peruuta}
    Click Element                               ${FA_footer_Peruuta}

    Wait Until Element Is Not Visible           ${Spinner_Overlay}
    Siirry Katselutilaan

    #tarkistetaan, että muutoksia ei ole tapahtunut
    Click Element At Coordinates                ${Kartta}    0    20
    Wait Until Element Is Visible               ${Päällysteluokka_Teksti}
    Element Should Contain                      ${Päällysteluokka_Teksti}    Kovat asfalttibetonit    #Tekstinä alkuperäinen päällyste
    Click Element At Coordinates                ${Kartta}    0    100


Päällysteen_vaihto_tallennus    [arguments]    ${testipaikka}    ${päällysteluokka_parametri}    ${päällysteen_kuvaus}
    Log                                         Testataan päällysteen vaihto
    Testin Aloitus
    Vaihda Tietolaji                            ${TL_Päällyste_RB}
    Paikanna osoite                             ${testipaikka}
    Zoomaa kartta                               5   20 m
    Odota sivun latautuminen
    Siirry Muokkaustilaan
    Wait Until Element Is Not Visible           ${Map_popup}
    Sleep                                       5
    Click Element At Coordinates                ${Kartta}  0  20

    Wait Until Element Is Visible               ${FA_Pavement}
    Select Radio Button                         paved-road    enabled
    Radio Button Should Be Set To               paved-road    enabled
    Wait Until Element Is Visible               css=.form-control.paved-road
    Click Element                               ${päällysteluokka_parametri}

    Wait Until Element Is Visible               ${FA_footer_Tallenna}
    Click Element                               ${FA_footer_Tallenna}

    Wait Until Element Is Not Visible           ${Spinner_Overlay}
    Siirry Katselutilaan
    Odota sivun latautuminen
    Wait Until Element Is Not Visible           ${Map_popup}
    Click Element At Coordinates                ${Kartta}  0  20
    Wait Until Element Is Visible               ${Päällysteluokka_Teksti}
    Element Should Contain                      ${Päällysteluokka_Teksti}    ${päällysteen_kuvaus}
    Click Element At Coordinates                ${Kartta}    100    100

    Nollaa Päällyste


Päällysteen_radionappi    [arguments]    ${testipaikka}
    Log    Testataan radio button
    Testin Aloitus
    Vaihda Tietolaji                            ${TL_Päällyste_RB}
    Paikanna osoite                             ${testipaikka}
    Zoomaa kartta                               5   20 m
    Odota sivun latautuminen
    Siirry Muokkaustilaan
    Wait Until Element Is Not Visible           ${Map_popup}
    Click Element At Coordinates                ${Kartta}  0  20
    #Ei päällystettä
    Wait Until Element Is Visible               ${FA_Pavement}
    Select Radio Button                         paved-road    disabled
    Radio Button Should Be Set To               paved-road    disabled
    Click Element                               ${FA_footer_Tallenna}
    Wait Until Element Is Not Visible           ${Spinner_Overlay}

    Click Element At Coordinates                ${Kartta}  0  20
    #Päällyste 
    Wait Until Element Is Visible               ${FA_Pavement}
    Select Radio Button                         paved-road    enabled
    Radio Button Should Be Set To               paved-road    enabled
    Click Element                               ${FA_footer_Tallenna}
    Wait Until Element Is Not Visible           ${Spinner_Overlay}


##########################
### Sisäiset Keywordit ###
##########################

Nollaa Päällyste
    Odota sivun latautuminen
    Wait until keyword succeeds  5x  200ms    Click Element At Coordinates    ${Kartta}  0  20
    Siirry Muokkaustilaan
    Wait Until Element Is Visible               ${FA_Pavement}
    Select Radio Button                         paved-road    disabled
    Click Element                               ${FA_footer_Tallenna}
    Wait Until Element Is Not Visible           ${Spinner_Overlay}
    Siirry Katselutilaan


*** Variables ***
${FA_Pavement}                                  css=input.paved-road
${FA_Pavement_A_DDM}                            css=.paved_road-a option:nth-child(2)
${FA_Pavement_B}                                css=.paved_road-b
${FA_Pavement_B_DDM}                            css=.paved_road-b option:nth-child(6)
${Popup_Päällyste}                              css=.form-control

${Popup_Päällyste_Päällystetty_Tuntematon}      css=.form-control.paved-road option[data-value="paallystetty,-tyyppi-tuntematon"]
${Popup_Päällyste_Betoni}                       css=.form-control.paved-road option[data-value="betoni"]
${Popup_Päällyste_Kivi}                         css=.form-control.paved-road option[data-value="kivi"]
${Popup_Päällyste_Kovat_asfalttibetonit}        css=.form-control.paved-road option[data-value="kovat-asfalttibetonit"]
${Popup_Päällyste_Pehmeät_asfalttibetonit}      css=.form-control.paved-road option[data-value="pehmeat-asfalttibetonit"]
${Popup_Päällyste_Soratien_pintaus}             css=.form-control.paved-road option[data-value="soratien-pintaus"]
${Popup_Päällyste_Sorakulutuskerros}            css=.form-control.paved-road option[data-value="sorakulutuskerros"]
${Popup_Päällyste_Muut_pinnoitteet}             css=.form-control.paved-road option[data-value="muut-pinnoitteet"]

${Popup_Päällyste_Numero}                       css=.form-control.paved-road option[value="10"]
${FA_Jaa_Ajoneuvorajoitus}                      id=separate-limit
${Päällyste_Peruuta_Muutos}                     css=.cancel.btn.btn-secondary
${Päällyste_Popup_Peruuta_Muutos}               css=.btn.btn-secondary.close
${Päällysteluokka_Teksti}                       css=.form-editable-paved-road
${Päällyste_Kova_asfaltti}                      Kovat asfalttibetonit