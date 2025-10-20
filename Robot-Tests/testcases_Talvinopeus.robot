#Joni Laari    23/08/2024    Sitowise

*** Variables ***
@{talvinopeudet_lista}    60    80    100    120

*** Settings ***
Documentation     Regression testcases for Digiroad
Resource          common_keywords.robot
Suite Setup       Login To DigiRoad
Suite Teardown    Close All Browsers


*** Test Cases ***
Talvinopeus Perustestit
    [Tags]    AWS    Talvinopeus
    [Documentation]    Talvinopeusrajoituksen perustestit
    KW_Talvinopeus.Talvinopeus Perustestit    6876213, 481863


Talvinopeusrajoitus Monivalinta
    [Tags]    AWS    Talvinopeus    BROKEN
    [Documentation]    Talvinopeusrajotusten muokkaus monivalintatyökalulla.
    Log    RIKKI? Talvinopeusrajoitus monivalinta
    KW_Talvinopeus.Talvinopeusrajoitus Monivalinta    6769022, 438111    @{talvinopeudet_lista}


Talvinopeusrajoituksen Katkaisu
    [Tags]    AWS    Talvinopeus
    [Documentation]    Talvinopeusrajoituksen muokkaus leikkaustyökalulla.
    KW_Talvinopeus.Talvinopeusrajoituksen Katkaisu    6783934, 508727


Talvinopeusrajoitus Kaksisuuntaiseksi
    [Tags]    AWS    Talvinopeus
    [Documentation]    Talvinopeusrajoituksen muuttaminen kaksisuuntaiseksi.
    KW_Talvinopeus.Talvinopeusrajoitus Kaksisuuntaiseksi    6915150, 541904
