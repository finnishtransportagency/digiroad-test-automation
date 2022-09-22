# Joni Laari        Sitowise Oy     2022

*** Variables ***

*** Settings ***
Documentation       Regression testcases for Digiroad
Resource            common_keywords.robot

Suite Setup         Login To DigiRoad
Suite Teardown      Close Browser

Test Setup          Testin Aloitus


*** Test Cases ***
Leveyden_tarkistus
    [Tags]  Leveys
    [Documentation]  Leveyden tarkastelu katselumoodissa.

    KW_Leveys.Leveyden_tarkistus      6673869, 384243


Leveyden_radionappi
    [Tags]  Leveys
    [Documentation]    Leveyden radionappien toimivuus

    KW_Leveys.Leveyden_radionappi    6768570, 484985

Leveyden_muokkaus_peruutus
    [Tags]  Leveys
    [Documentation]    Leveyden muokkaus peruutuksella

    KW_Leveys.Leveyden_muokkaus_peruutus    6768570, 484985

Leveyden_muokkaus_tallennus
    [Tags]  Leveys
    [Documentation]    Leveyden muokkaus tallennuksella

    KW_Leveys.Leveyden_muokkaus_tallennus    6768570, 484985