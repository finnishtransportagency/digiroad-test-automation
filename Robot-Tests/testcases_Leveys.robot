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
    [Documentation]    Leveyden muuttaminen peruutuksella

    KW_Leveys.Leveyden_muokkaus_peruutus    6843989, 457267

Leveyden_muokkaus_tallennus
    [Tags]  Leveys
    [Documentation]    Leveyden muuttaminen tallennuksella

    KW_Leveys.Leveyden_muokkaus_tallennus    6768570, 484985

Leveyden katkaisu
    [Tags]    Leveys
    [Documentation]    Leveyden katkaisu

    KW_Leveys.Leveyden katkaisu              6837954, 514189

Leveystieto usealle linkille
    [Tags]    Leveys
    [Documentation]    Leveystiedon lisääminen usealle linkille kahdella tavoin

    KW_Leveys.Leveystieto usealle linkille    6893667, 427076

Usean linkin klikkausvalinta
    [Tags]    Leveys
    [Documentation]    Leveystiedon lisääminen usealle linkille ctrl-napin avulla

    KW_Leveys.Usean linkin klikkausvalinta    7406758, 557075