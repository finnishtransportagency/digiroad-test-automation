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


Usean_tietyön_muuttaminen_klikkaamalla
    [Tags]  AWS  Tietyö
    [Documentation]  Usean tietyön valinta ctrl-napilla

    KW_Tietyot.Usean_tietyön_muuttaminen_klikkaamalla      6899638, 435711    mielivaltainenmerkkijono

Usean_tietyön_muuttaminen_polygonilla
    [Tags]  AWS  Tietyö
    [Documentation]  Usean tietyön valinta ctrl-napilla

    KW_Tietyot.Usean_tietyön_muuttaminen_polygonilla      6899638, 435711    mielivaltainenmerkkijono

Usean_tietyön_muuttaminen_laatikolla
    [Tags]  AWS  Tietyö
    [Documentation]  Usean tietyön valinta ctrl-napilla

    KW_Tietyot.Usean_tietyön_muuttaminen_laatikolla      6899638, 435711    mielivaltainenmerkkijono

Tietyön katkaisu
    [Tags]  AWS  Tietyö
    [Documentation]  Tietyön katkaisu

    KW_Tietyot.Tietyön katkaisu     6890592, 436036    mielivaltainenmerkkijono    merkkijonomielivaltainen


Tietyö kaksisuuntaiseksi
    [Tags]    AWS    Tietyö
    [Documentation]    Tietyön muuntaminen kaksisuuntaiseksi

    KW_Tietyot.Tietyö kaksisuuntaiseksi      6746688, 483454    mielivaltainenmerkkijono    merkkijonomielivaltainen