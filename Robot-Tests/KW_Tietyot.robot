#       Joni Laari      Sitowise     2023

*** Settings ***
Documentation       Keywords for roadworks (Tietyöt)
Library    SeleniumLibrary
Resource    common_keywords.robot

*** Keywords ***
Tietyön_tarkastelu   [arguments]            ${testipaikka}
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


Tietyön_tarkastelu_FA    [arguments]        ${testipaikka}
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
    Log     Ajoneuvorajoituksen muokkaus koko ketjulle
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

*** Variables ***
${Tietyö_liikennemerkki_valinta}         xpath=/html/body/div[1]/nav/div/div[3]/div[21]/div/div[3]/input
${Tietyö_täydentävätlinkit_valinta}      xpath=/html/body/div[1]/nav/div/div[3]/div[21]/div/div[4]/input

${FA_tietyö_kohde_ID}                    xpath=/html/body/div[1]/div[2]/header/div[1]/span
${FA_tietyö_Lisätty_järjestelmään}       xpath=/html/body/div[1]/div[2]/main/article/div/div/div[1]/p
${FA_tietyö_Muokattu_viimeksi}           xpath=/html/body/div[1]/div[2]/main/article/div/div/div[2]/p
${FA_tietyö_Linkkien_lukumäärä}          xpath=/html/body/div[1]/div[2]/main/article/div/div/div[3]/p
${FA_tietyö_Olemassaoleva_tietyö}        xpath=/html/body/div[1]/div[2]/main/article/div/div/div[4]/p
${FA_tietyö_Tietyön_tunnus}              xpath=/html/body/div[1]/div[2]/main/article/div/div/div[4]/div[2]/div[1]/p
${FA_tietyö_Tietyön_pvm}                 xpath=/html/body/div[1]/div[2]/main/article/div/div/div[4]/div[2]/div[2]/ul

${FA_tietyö_tietyön_kuvaus}              xpath=/html/body/div[1]/div[2]/main/article/div/div/div[4]/div[2]/div[1]/input
${FA_tietyö_aloituspvm}                  xpath=/html/body/div[1]/div[2]/main/article/div/div/div[4]/div[2]/div[2]/ul/li/input[1]
${FA_tietyö_päättymispvm}                xpath=/html/body/div[1]/div[2]/main/article/div/div/div[4]/div[2]/div[2]/ul/li/input[2]
${tietyö_nuolinäppäin_laskuri}    1