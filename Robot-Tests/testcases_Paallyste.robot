# Joni Laari        Sitowise Oy     2022

*** Variables ***

*** Settings ***
Documentation       Regression testcases for Digiroad
Resource            common_keywords.robot

Suite Setup         Login To DigiRoad
Suite Teardown      Close Browser

Test Setup          Testin Aloitus


*** Test Cases ***
Päällysteen_tarkastelu
    [Tags]  AWS  Päällyste
    [Documentation]  Päällysteen tarkastelu katselumoodissa.

    KW_Paallyste.Päällysteen_tarkastelu      6888602, 430380


Päällysteen_vaihto_peruutus
    [Tags]  AWS  Päällyste
    [Documentation]  Päällysteen muokkaus koko ketjulle

    KW_Paallyste.Päällysteen_vaihto_peruutus      6701160, 494083    ${Popup_Päällyste_Betoni}                   
    KW_Paallyste.Päällysteen_vaihto_peruutus      6701160, 494083    ${Popup_Päällyste_Kivi}                     
    KW_Paallyste.Päällysteen_vaihto_peruutus      6701160, 494083    ${Popup_Päällyste_Kovat_asfalttibetonit}    
    KW_Paallyste.Päällysteen_vaihto_peruutus      6701160, 494083    ${Popup_Päällyste_Pehmeät_asfalttibetonit}  
    KW_Paallyste.Päällysteen_vaihto_peruutus      6701160, 494083    ${Popup_Päällyste_Soratien_pintaus}         
    KW_Paallyste.Päällysteen_vaihto_peruutus      6701160, 494083    ${Popup_Päällyste_Sorakulutuskerros}        
    KW_Paallyste.Päällysteen_vaihto_peruutus      6701160, 494083    ${Popup_Päällyste_Muut_pinnoitteet}         


Päällysteen_vaihto_tallennus
    [Tags]  AWS  Päällyste
    [Documentation]  Päällysteen muokkaus koko ketjulle

    KW_Paallyste.Päällysteen_vaihto_tallennus     6902636, 431258    ${Popup_Päällyste_Betoni}                       Betoni
    KW_Paallyste.Päällysteen_vaihto_tallennus     6902636, 431258    ${Popup_Päällyste_Kivi}                         Kivi
    KW_Paallyste.Päällysteen_vaihto_tallennus     6902636, 431258    ${Popup_Päällyste_Kovat_asfalttibetonit}        Kovat asfalttibetonit
    KW_Paallyste.Päällysteen_vaihto_tallennus     6902636, 431258    ${Popup_Päällyste_Pehmeät_asfalttibetonit}      Pehmeät asfalttibetonit
    KW_Paallyste.Päällysteen_vaihto_tallennus     6902636, 431258    ${Popup_Päällyste_Soratien_pintaus}             Soratien pintaus
    KW_Paallyste.Päällysteen_vaihto_tallennus     6902636, 431258    ${Popup_Päällyste_Sorakulutuskerros}            Sorakulutuskerros
    KW_Paallyste.Päällysteen_vaihto_tallennus     6902636, 431258    ${Popup_Päällyste_Muut_pinnoitteet}             Muut pinnoitteet


Päällysteen_radionappi
    [Tags]    AWS    Päällyste
    [Documentation]    Päällysteen radionappien toimivuus

    KW_Paallyste.Päällysteen_radionappi      6746688, 483454