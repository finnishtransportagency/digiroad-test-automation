#Joni Laari    2023    Sitowise

*** Variables ***
@{talvinopeudet_lista}    60    80    100    120

*** Settings ***
Documentation    Regression testcases for Digiroad
Resource         common_keywords.robot

Suite Setup      Login To DigiRoad
Suite Teardown    Close All Browsers


*** Test Cases ***
Talvinopeus perustestit
    [Tags]    AWS    Talvinopeus
    [Documentation]    Talvinopeusrajoituksen perustestit
    KW_Talvinopeus.Talvinopeus perustestit    6782293, 446161

Talvinopeusrajoitus monivalinta
    [Tags]  AWS  Talvinopeus
    [Documentation]  Nopeusrajotusten muokkaus monivalintatyökalulla.
    ...  Testaa regressio testit 206.116, 206.118
    KW_Talvinopeus.Talvinopeusrajoitus monivalinta  6783934, 508727

Talvinopeusrajoituksen katkaisu
    [Tags]    AWS    Talvinopeus
    [Documentation]    Talvinopeusrajoituksen muokkaus leikkaustyökalulla.
    KW_Talvinopeus.Talvinopeusrajoituksen katkaisu    6783934, 508727

Talvinopeusrajoitus kaksisuuntaiseksi
    [Tags]    AWS    Talvinopeus
    [Documentation]    Talvinopeusrajoituksen muuttaminen kaksisuuntaiseksi.
    KW_Talvinopeus.Talvinopeusrajoitus kaksisuuntaiseksi    6915150, 541904