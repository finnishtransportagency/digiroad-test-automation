#   2022    Joni Laari      Sitowise Oy


*** Settings ***
Documentation       Pageobject for lane tool (Kaistatyökalu)

*** Keywords ***

Kaistatyökalu_1  [arguments]  ${testipaikka}
    Log  Vaihdetaan experimetal osoitteseen ja siirrytään testipaikkaan.
    vaihda tietolaji                            ${TL_Kaistan_mallinnustyökalu_RB}
    Paikanna osoite                             ${testipaikka}
    Zoomaa kartta                               5  50 m

    Click Element At Coordinates                ${Kartta}  0  20
    Wait Until Element Is Visible               ${FA_otsikko}
    Siirry Muokkaustilaan
    Click Element                               ${FA_Lisää_kaista_oikealle}
    Click Element                               ${FA_Lisää_kaista_vasemmalle}

    Log  Poistetaan lisäkaistat
    Valitse Kaista                              3
    Click Element                               ${KT_Poista_Lisakaista}


    Valitse Kaista                              1
    Wait Until Element Is Visible               ${KT_Poista_Lisakaista}
    Click Element                               ${KT_Poista_Lisakaista}
    Element Should Not Be Clickable             ${KT_Poista_Lisakaista}    
    Element Should Contain                      ${KT_Kaista}    1
    Click Element                               ${FA_footer_Peruuta}


Kaistatyökalu_2  [arguments]  ${testipaikka}
    Log  Vaihdetaan experimetal osoitteseen ja siirrytään testipaikkaan.
    vaihda tietolaji                            ${TL_Kaistan_mallinnustyökalu_RB}
    Paikanna osoite                             ${testipaikka}
    Zoomaa kartta                               5  50 m
    
    Click Element At Coordinates                ${Kartta}  0  20
    Wait Until Element Is Visible               ${FA_otsikko}
    Siirry Muokkaustilaan
    Wait Until Element Is Not Visible           ${Map_popup}
    
    #Poista Ylimääräiset Kaistat    
    #for-loop ei tällä hetkellä mahdollinen fronttikoodin rajoitusten takia 12/2022
    
    Click Element                               ${FA_Lisää_kaista_oikealle}
    Input Text                                  ${KT_Alkupäivämäärä}    18.3.2022
    Press Keys                                  ${KT_Alkupäivämäärä}    RETURN
    Click Element                               ${FA_Lisää_kaista_vasemmalle}
    Input Text                                  ${KT_Alkupäivämäärä}    18.3.2022
    Press Keys                                  ${KT_Alkupäivämäärä}    RETURN

    Log  Talletetaan ja päätetään kaistat
    Click Element                               ${FA_footer_Tallenna}
    Wait Until Element Is Not Visible           ${Map_popup}
    Click Element                               ${Muokkausvaroitus_Kyllä_btn}
    Wait Until Element Is Not Visible           ${Spinner_Overlay}
    Odota sivun latautuminen

    Click Element at Coordinates                ${Kartta}  0  20
    Wait Until Element Is Visible               ${FA_otsikko}
    Valitse Kaista                              1
    
    Element Should Contain                      ${KT_Kaista}  2
    
    Click Element                               ${KT_Päätä_Lisakaista}
    Click Element                               ${Muokkausvaroitus_Kyllä_btn}

    Valitse Kaista                              2
    Element Should Contain                      ${KT_Kaista}  3
    Click Element                               ${KT_Päätä_Lisakaista}
    Click Element                               ${Muokkausvaroitus_Kyllä_btn}

    Click Element                               ${FA_footer_Tallenna}
    Wait Until Element Is Not Visible           ${Map_popup}
    Click Element                               ${Muokkausvaroitus_Kyllä_btn}
    Wait Until Element Is Not Visible           ${Spinner_Overlay}
    Odota sivun latautuminen


##########################
### Sisäiset Keywordit ###
##########################

Valitse Kaista  [Arguments]  ${indeksi}
    #Kaistan indeksi kasvaa kaistanumeron mukaan vasemmalta oikealle
    Click Element                               css=div.preview-div tr:nth-child(2) td:nth-child(${indeksi})


Poista Ylimääräiset Kaistat
    FOR  ${i}  IN RANGE  20
        Valitse Kaista                              1
        ${status}=  Run Keyword And Return Status  Element Should Contain  ${KT_Kaista}  1
        Exit For Loop If  ${status}==True
        Run Keyword If  ${status}==False  Click Element  ${KT_Päätä_Lisakaista}
        Run Keyword If  ${status}==False  Click Element  ${Muokkausvaroitus_Kyllä_btn}
    END
    

    FOR  ${i}  IN RANGE  20
        #Tarkisetaan onko pääkaistan oikeallapuolella kaistoja
        ${status}=  Run Keyword And Return Status  Element Should Be Visible  css=div.preview-div tr:nth-child(2) td:nth-child(2)
        Exit For Loop If    ${Status}==False
        Valitse Kaista                              2
        Click Element  ${KT_Päätä_Lisakaista}
        Click Element  ${Muokkausvaroitus_Kyllä_btn}
    END


Element Should Not Be Clickable
    #kokeilee, onko argumenttina annettu elementti klikattavissa (ei vain näkyvissä) ja antaa failin jos on
    [Arguments]   ${element}
    ${status}=    Run Keyword And Return Status    Click Element    ${element}
    Run Keyword If    'disabled'=='${status}'    Fail    "Elementin ei tule olla klikattavissa"


*** Variables ***
${FA_Lisää_kaista}                  css=.list-lane-buttons > li:nth-of-type(1) .btn
${FA_Lisää_kaista_oikealle}         css=.list-lane-buttons > li:nth-of-type(3) .btn
${FA_Lisää_kaista_vasemmalle}       css=.list-lane-buttons > li:nth-of-type(2) .btn
${KT_Kaistan_tyyppi}                lane_type
${KT_Kaistan_tyyppi_DDM}            css=.form-control.lane-modelling-tool option:nth-child(2)  #ohituskaista
${KT_Päätä_Lisakaista}              css=button.btn.btn-secondary.lane-button.expire-lane    #DROTH-3348
${KT_Poista_Lisakaista}             css=button.btn.btn-secondary.lane-button.delete-lane    #DROTH-3348

${KT_Tien_Numero}                   css=.input-unit-combination div:nth-child(2) p
${KT_Tien_Osanumero}                css=.input-unit-combination div:nth-child(3) p
${KT_Ajorata}                       css=.input-unit-combination div:nth-child(4) p
${KT_Etäisyys_Alusta}               css=.input-unit-combination div:nth-child(5) p
${KT_Etäisyys_Lopusta}              css=.input-unit-combination div:nth-child(6) p
${KT_Pituus}                        css=.input-unit-combination div:nth-child(7) p
${KT_Hallinnollinen_Luokka}         css=.input-unit-combination div:nth-child(8) p
${KT_Kaistan_tiedot}                css=.input-unit-combination div:nth-child(9) p
${KT_Kaista}                        css=.input-unit-combination div:nth-child(10) p
${KT_Alkupäivämäärä}                id=start_date
${KT_Loppupäivämäärä}               id=end_date