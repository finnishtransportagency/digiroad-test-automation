#    Joni Laari    Sitowise    2024

*** Settings ***
Documentation       Regression testcases for Digiroad
Resource            common_keywords.robot

Suite Setup         Login To DigiRoad
Suite Teardown      Close Browser

Test Setup          Testin Aloitus


*** Test Cases ***
Hoitoluokan tarkastelu
    [Tags]  Hoitoluokat
    [Documentation]  Hoitoluokan tarkastelu katselumoodissa.
    Log    Testataan hoitoluokan tarkastelu
    KW_Hoitoluokat.Hoitoluokan tarkastelu    7057407, 480798


Hoitoluokan muokkaus koko ketjulle
    [Tags]    Hoitoluokat
    [Documentation]  Hoitoluokan muokkaus koko ketjulle.
    Log    Testataan hoitoluokan tarkastelu
    KW_Hoitoluokat.Hoitoluokan muokkaus koko ketjulle    7055586, 488170