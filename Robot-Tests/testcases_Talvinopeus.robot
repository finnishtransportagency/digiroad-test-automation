#Joni Laari    2023    Sitowise

*** Variables ***

*** Settings ***
Documentation    Regression testcases for Digiroad
Resource         common_keywords.robot

Suite Setup      Login To DigiRoad
Suite Teardown    Close All Browsers

Test Setup        Testin Aloitus


*** Test Cases ***
Talvinopeus perustestit
    [Tags]    AWS    Talvinopeus
    [Documentation]    Talvinopeusrajoituksen perustestit

    KW_Talvinopeus.Talvinopeus perustestit    6782293, 446161


Talvinopeusrajoitus 3
    [Tags]  AWS  testi  Nopeus
    [Documentation]  Nopeusrajotusten muokkaus monivalintatyökalulla.
    ...  Testaa regressio testit 206.116, 206.118
    KW_Talvinopeusrajoitus.Talvinopeusrajoitus monivalinta  6938911, 393122
