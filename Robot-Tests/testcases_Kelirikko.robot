#     Joni Laari        Sitowise     2023

*** Variables ***


*** Settings ***
Documentation       Regression testcases for Digiroad
Resource            common_keywords.robot

Suite Setup         Login To DigiRoad
Suite Teardown      Close Browser

Test Setup          Testin Aloitus


*** Test Cases ***
Kelirikkotiedon tarkastelu
    [Tags]
    [Documentation]

    KW_Kelirikko.Kelirikkotiedon tarkastelu    7032651, 432231