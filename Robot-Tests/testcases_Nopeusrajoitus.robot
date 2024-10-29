*** Settings ***
Documentation       Regression testcases for Digiroad
Resource            common_keywords.robot

Suite Setup         Login To DigiRoad
Suite Teardown      Close Browser

Test Setup          Testin Aloitus
*** Test Cases ***
Nopeusrajoitus 1
    [Tags]  AWS  Nopeus
    [Documentation]  Nopeusrajoituksen muokkaus leikkaustyökalulla.
    ...  Testaa regressio testit  206.30, 206.38, 206.86, 206.101, 206.102, 206.104
    KW_Nopeusrajoitus.Nopeusrajoitus 1  6938239, 393170

Nopeusrajoitus 2
    [Tags]  AWS
    [Documentation]  Nopeusrajotusten perus testit.
    ...  Testaa regressio testit 206.1, 206.6, 206.8, 206.25, 206.26, 206.27, 206.28, 206.36, 206.37
    Log    Nopeusrajoitus 2 RIKKI
    #KW_Nopeusrajoitus.Nopeusrajoitus 2  6785904, 446385


Nopeusrajoitus 3
    [Tags]  AWS  testi  Nopeus
    [Documentation]  Nopeusrajotusten muokkaus monivalintatyökalulla.
    ...  Testaa regressio testit 206.116, 206.118
    KW_Nopeusrajoitus.Nopeusrajoitus 3  6938911, 393122

Nopeusrajoitus 4
    [Tags]  AWS  testi  Nopeus
    [Documentation]  Nopeusrajoituksen muuntaminen kaksisuuntaiseksi.

    KW_Nopeusrajoitus.Nopeusrajoitus 4  6939251, 393673