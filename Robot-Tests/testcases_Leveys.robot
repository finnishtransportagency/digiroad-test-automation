# Joni Laari        Sitowise Oy     2022

*** Variables ***

*** Settings ***
Documentation       Regression testcases for Digiroad
Resource            common_keywords.robot
Suite Setup         Login To DigiRoad
Suite Teardown      Close Browser
Test Setup          Testin Aloitus


*** Test Cases ***
Leveyden Tarkistus
    [Tags]  Leveys
    [Documentation]  Leveyden tarkastelu katselumoodissa.
    KW_Leveys.Leveyden Tarkistus      6673869, 384243


Leveyden Radionappi
    [Tags]  Leveys
    [Documentation]    Leveyden radionappien toimivuus
    KW_Leveys.Leveyden Radionappi    6768618, 484482    -


Leveyden Muokkaus Peruutus
    [Tags]  Leveys
    [Documentation]    Leveyden muuttaminen peruutuksella
    KW_Leveys.Leveyden Muokkaus Peruutus    6843989, 457267


Leveyden Muokkaus Tallennus
    [Tags]             Leveys
    [Documentation]    Leveyden muuttaminen tallennuksella
    KW_Leveys.Leveyden Muokkaus Tallennus    6898562, 434018


Leveyden Katkaisu
    [Tags]             Leveys
    [Documentation]    Leveyden katkaisu
    KW_Leveys.Leveyden Katkaisu    6837954, 514189


Leveystieto Usealle Linkille Laatikolla
    [Tags]             Leveys
    [Documentation]    Leveystiedon lisääminen usealle linkille kahdella tavoin (laatikko ja polygon)
    KW_Leveys.Leveystieto Usealle Linkille Laatikolla    6893667, 427076


Leveystieto Usealle Linkille Polygonilla
    [Tags]             Leveys
    [Documentation]    Leveystiedon lisääminen usealle linkille kahdella tavoin (laatikko ja polygon)
    KW_Leveys.Leveystieto Usealle Linkille Polygonilla    6893667, 427076


Usean Linkin Klikkausvalinta
    [Tags]             Leveys
    [Documentation]    Leveystiedon lisääminen usealle linkille ctrl-napin avulla
    KW_Leveys.Usean Linkin Klikkausvalinta    6837568, 513925
