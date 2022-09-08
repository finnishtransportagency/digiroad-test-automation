#       Joni Laari      Sitowise Oy     2022

*** Settings ***
Documentation       Keywords for paving (Päällyste)
Library    SeleniumLibrary
Resource    common_keywords.robot

*** Variables ***
${LocatorForDDM}                            css=#feature-attributes .form-group.editable. select:first-of-type
${LocatorForDDM_Selection}                  css=select >option:nth-child(2)
#varmistusviesti ajoneuvorajoituksen poistolle
${Rajoituksen_poisto}                       Haluatko varmasti poistaa rajoituksen?

*** Keywords ***

Päällyste_1   [arguments]     ${testipaikka}
    Log     Päällysteen tarkastelu katselutilassa.
    #testataan valinnan toimivuus
    Vaihda Tietolaji                            ${TL_Päällyste_RB}
    Paikanna osoite                             ${testipaikka}
    Zoomaa kartta                               5   50 m
    Odota sivun latautuminen
    Click Element At Coordinates                ${Kartta}   0  20
    Wait Until Element Is Visible               ${FA_otsikko}
    #Klikataan näkymä pois
    Click Element At Coordinates                ${Kartta}  -100  -100
    
    #double click
    Tupla Klikkaa Kartan Keskelle
    Wait Until Element Is Visible               ${FA_otsikko}


Päällyste_2    [arguments]    ${testipaikka}    ${päällysteluokka}
    Log                                         Testataan päällysteen vaihto
    Testin Aloitus
    Vaihda Tietolaji                            ${TL_Päällyste_RB}
    Paikanna osoite                             ${testipaikka}
    Zoomaa kartta                               5   50 m
    Odota sivun latautuminen
    Siirry Muokkaustilaan
    Click Element At Coordinates                ${Kartta}   0   20

    Wait Until Element Is Visible               css=.form-control.paved-road
    Click Element                               css=.form-control.paved-road
    Click Element                               ${päällysteluokka}
    Wait Until Element Is Visible               ${FA_footer_Tallenna}

    #muutoksen peruutus vs
    Wait Until Element Is Visible               ${FA_footer_Peruuta}
    Click Element                               ${FA_footer_Peruuta}

    #muutoksen tallennuksen kokeileminen, korjataan kun seleniumin klikkiongelmille viivakohteiden kanssa saadaan jokin selkeä syy.
    #Wait Until Element Is Visible               ${FA_footer_Tallenna}
    #Click Element                               ${FA_footer_Tallenna}

    Wait Until Element Is Not Visible           ${Spinner_Overlay}
    Siirry Katselutilaan
    #Nollaa Päällyste    #kts rivi 52 ja seleniumin klikkausongelmat


Päällyste_3    [arguments]    ${testipaikka}
    Testin Aloitus
    Vaihda Tietolaji                            ${TL_Päällyste_RB}
    Paikanna osoite                             ${testipaikka}
    Zoomaa kartta                               5   20 m
    Odota sivun latautuminen
    Siirry Muokkaustilaan

    Click Element At Coordinates                ${Kartta}  0  20
    Wait Until Element Is Visible               css=input.paved-road
    Select Radio Button                         paved-road    disabled
    Click Element                               ${FA_footer_Tallenna}
    Wait Until Element Is Not Visible           ${Spinner_Overlay}

    Click Element At Coordinates                ${Kartta}  0  20
    Wait Until Element Is Visible               css=input.paved-road
    Select Radio Button                         paved-road    enabled
    Click Element                               ${FA_footer_Tallenna}
    Wait Until Element Is Not Visible           ${Spinner_Overlay}


##########################
### Sisäiset Keywordit ###
##########################

Nollaa Päällyste
    Odota sivun latautuminen
    #Wait Until Element Is Not Visible           ${Map_popup}
    Click Element                               ${Kartta}    0    20
    Siirry Muokkaustilaan
    Wait Until Element Is Visible               ${Popup_Päällyste}
    Click Element                               ${Popup_Päällyste}
    Click Element                               ${Popup_Päällyste_Kovat_asfalttibetonit}
    Click Element                               ${FA_footer_Tallenna}
    Wait Until Element Is Not Visible           ${Spinner_Overlay}
    Odota sivun latautuminen
    Siirry Katselutilaan



*** Variables ***
${FA_Pavement_A}                                css=.paved_road-a
${FA_Pavement_A_DDM}                            css=.paved_road-a option:nth-child(2)
${FA_Pavement_B}                                css=.paved_road-b
${FA_Pavement_B_DDM}                            css=.paved_road-b option:nth-child(6)
${FA_Ajoneuvorajoitus}                          css=.feature-attributes-form
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