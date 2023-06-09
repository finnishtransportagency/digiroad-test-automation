# Joni Laari    Sitowise    2023

*** Variables ***

*** Settings ***
Documentation       Regression testcases for Digiroad
Resource            common_keywords.robot

Suite Setup         Login To DigiRoad
Suite Teardown      Close Browser

Test Setup          Testin Aloitus


*** Test Cases ***
Tietyön_tarkastelu
    [Tags]  AWS  Tietyö
    [Documentation]  Tietyön tarkastelu katselumoodissa.

    KW_Tietyot.Tietyön_tarkastelu      6888602, 430380


Tietyön_tarkastelu_FA
    [Tags]  AWS  Tietyö
    [Documentation]  Tietyön tarkastelu katselumoodissa.

    KW_Tietyot.Tietyön_tarkastelu_FA      6888602, 430380


Tietyön_vaihto_peruutus
    [Tags]  AWS  Tietyö
    [Documentation]  Tietyön muokkaus tallentamatta koko ketjulle

    KW_Tietyot.Tietyön_vaihto_peruutus      6702779, 495817    mielivaltainenmerkkijono

Tietyön_vaihto_tallennus
    [Tags]  AWS  Tietyö
    [Documentation]  Tietyön muokkaus tallentaen koko ketjulle

    KW_Tietyot.Tietyön_vaihto_tallennus     6905946, 428711


Tietyön_radionappi
    [Tags]    AWS    Tietyö
    [Documentation]    Tietyön radionappien toimivuus

    KW_Tietyot.Tietyön_radionappi      6746688, 483454