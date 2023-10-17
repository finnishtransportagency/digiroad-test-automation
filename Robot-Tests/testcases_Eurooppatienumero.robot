#     Joni Laari        Sitowise     2023

*** Settings ***
Documentation       Regression testcases for Digiroad
Resource            common_keywords.robot

Suite Setup         Login To DigiRoad
Suite Teardown      Close Browser

Test Setup          Testin Aloitus


*** Test Cases ***
Eurooppatienumeron tarkastelu
    [Tags]    Eurooppatienumero
    [Documentation]    Tarkastellaan eurooppatienumeroa
    KW_Eurooppatienumero.Eurooppatienumeron tarkastelu    7032652, 432232


Eurooppatienumeron lisääminen
    [Tags]    Eurooppatienumero
    [Documentation]    Lisätään eurooppatienumero
    KW_Eurooppatienumero.Eurooppatienumeron lisääminen    6893280, 450604


Eurooppatienumeron virheellinen lisääminen
    [Tags]    Eurooppatienumero
    [Documentation]    Lisätään virheellistä tietoa
    Log    Testataan eurooppatienumeron lisäys sekä virheellisen arvon syöttö
    KW_Eurooppatienumero.Eurooppatienumeron virheellinen lisääminen    6893280, 450604


Eurooppatienumeron lisääminen laatikko
    [Tags]  Eurooppatienumero
    [Documentation]  Lisätään useita eurooppatienumeroja laatikkovalinnalla
    KW_Eurooppatienumero.Eurooppatienumeron lisääminen laatikko    6893273, 450581


Eurooppatienumeron lisääminen polygon
    [Tags]  Eurooppatienumero
    [Documentation]  Lisätään useita eurooppatienumeroja polygonvalinnalla
    KW_Eurooppatienumero.Eurooppatienumeron lisääminen polygon    6893280, 450604


Eurooppatienumeron lisääminen ctrl
    [Tags]    Eurooppatienumero
    [Documentation]    Lisätään useita eurooppatienumeroja ctrl-napilla
    Log    Lisätään useita eurooppatienumeroja ctrl-napilla
    KW_Eurooppatienumero.Eurooppatienumeron lisääminen ctrl    6774708, 505522    6775802, 505291


Eurooppatienumeron katkaisu
    [Tags]    Eurooppatienumero
    [Documentation]    Eurooppatienumeron katkaisu
    Log    Testataan eurooppatienumeron katkaisu
    KW_Eurooppatienumero.Eurooppatienumeron katkaisu    6956319, 530010    63