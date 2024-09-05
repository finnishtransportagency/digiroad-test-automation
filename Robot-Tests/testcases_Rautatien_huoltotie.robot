#    Joni Laari    Sitowise    2024

*** Settings ***
Documentation       Regression testcases for Digiroad
Resource            common_keywords.robot

Suite Setup         Login To DigiRoad
Suite Teardown      Close Browser

Test Setup          Testin Aloitus


*** Test Cases ***
Rautateiden huoltotien tarkastelu
    [Tags]  Rautateiden_huoltotiet
    [Documentation]  Huoltoteiden tarkastelu katselumoodissa.
    Log    Testataan huoltoteiden tarkastelu
    KW_Rautatien_huoltotie.Rautateiden huoltotien tarkastelu    7057407, 480798