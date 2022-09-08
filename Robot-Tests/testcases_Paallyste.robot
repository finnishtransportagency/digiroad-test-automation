# Joni Laari        Sitowise Oy     2022

*** Variables ***

*** Settings ***
Documentation       Regression testcases for Digiroad
Resource            common_keywords.robot

Suite Setup         Login To DigiRoad
Suite Teardown      Close Browser

Test Setup          Testin Aloitus


*** Test Cases ***
Päällyste 1
    [Tags]  AWS  Päällyste
    [Documentation]  Päällysteen tarkastelu katselumoodissa.

    KW_Paallyste.Päällyste_1      6888907, 429796


Päällyste 2
    [Tags]  AWS  Päällyste
    [Documentation]  Päällysteen muokkaus koko ketjulle

    KW_Paallyste.Päällyste_2      6701160, 494083    ${Popup_Päällyste_Betoni}
    KW_Paallyste.Päällyste_2      6701160, 494083    ${Popup_Päällyste_Kivi}
    KW_Paallyste.Päällyste_2      6701160, 494083    ${Popup_Päällyste_Kovat_asfalttibetonit}
    KW_Paallyste.Päällyste_2      6701160, 494083    ${Popup_Päällyste_Pehmeät_asfalttibetonit}
    KW_Paallyste.Päällyste_2      6701160, 494083    ${Popup_Päällyste_Soratien_pintaus}
    KW_Paallyste.Päällyste_2      6701160, 494083    ${Popup_Päällyste_Sorakulutuskerros}
    KW_Paallyste.Päällyste_2      6701160, 494083    ${Popup_Päällyste_Muut_pinnoitteet}


Päällyste 3
    [Tags]    AWS    Päällyste
    [Documentation]    Päällysteen poisto

    KW_Paallyste.Päällyste_3      6705045, 494826