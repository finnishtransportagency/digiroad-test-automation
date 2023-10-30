#     Joni Laari        Sitowise     2023

*** Settings ***
Documentation       Regression testcases for Digiroad
Resource            common_keywords.robot

Suite Setup         Login To DigiRoad
Suite Teardown      Close Browser

Test Setup          Testin Aloitus


*** Test Cases ***
Liittymänumeron tarkastelu
    [Tags]    Liittymänumero
    [Documentation]    Tarkastellaan liittymänumeroa
    KW_Liittymänumero.Liittymänumeron tarkastelu    6676452, 378930


Liittymänumeron lisääminen
    [Tags]    Liittymänumero
    [Documentation]    Lisätään liittymänumero
    KW_Liittymänumero.Liittymänumeron lisääminen    6893280, 450604


Liittymänumeron virheellinen lisääminen
    [Tags]    Liittymänumero
    [Documentation]    Lisätään virheellistä tietoa
    Log    Testataan liittymänumeron lisäys sekä virheellisen arvon syöttö
    KW_Liittymänumero.Liittymänumeron virheellinen lisääminen    6893280, 450604


Liittymänumeron lisääminen laatikko
    [Tags]  Liittymänumero
    [Documentation]  Lisätään useita liittymänumeroja laatikkovalinnalla
    KW_Liittymänumero.Liittymänumeron lisääminen laatikko    6893273, 450581


Liittymänumeron lisääminen polygon
    [Tags]  Liittymänumero
    [Documentation]  Lisätään useita liittymänumeroja polygonvalinnalla
    KW_Liittymänumero.Liittymänumeron lisääminen polygon    6893280, 450604


Liittymänumeron lisääminen ctrl
    [Tags]    Liittymänumero
    [Documentation]    Lisätään useita liittymänumeroja ctrl-napilla
    Log    Lisätään useita liittymänumeroja ctrl-napilla
    KW_Liittymänumero.Liittymänumeron lisääminen ctrl    6774708, 505522


Liittymänumeron katkaisu
    [Tags]    Liittymänumero
    [Documentation]    Liittymänumeron katkaisu
    Log    Testataan liittymänumeron katkaisu
    KW_Liittymänumero.Liittymänumeron katkaisu    6676452, 378930    45