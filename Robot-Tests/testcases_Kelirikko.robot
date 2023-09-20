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
    [Tags]    Kelirikko
    [Documentation]    Tarkastellaan kelirikkotietoa (testitapaukset 1-3)

    KW_Kelirikko.Kelirikkotiedon tarkastelu    7032652, 432232


Kelirikkotiedon lisääminen
    [Tags]    Kelirikko
    [Documentation]    Lisätään kelirikkotieto (testitapaus 4)
    KW_Kelirikko.Kelirikkotiedon lisääminen    7032652, 432232


Kelirikkotiedon virheellinen lisääminen
    [Tags]    Kelirikko
    [Documentation]    Lisätään virheellistä tietoa
    KW_Kelirikko.Kelirikkotiedon virheellinen lisääminen    7311372, 478787


Kelirikon lisääminen laatikko
    [Tags]  Kelirikko
    [Documentation]  Kelirikon tarkastelu katselumoodissa.
    Log    Testataan kelirikon lisäys sekä virheellisen arvon syöttö
    KW_Kelirikko.Kelirikon lisääminen laatikko    7311372, 478787


Kelirikon lisääminen polygon
    [Tags]  Kelirikko
    [Documentation]  Kelirikon tarkastelu katselumoodissa.
    Log    Testataan kelirikon lisäys sekä virheellisen arvon syöttö
    KW_Kelirikko.Kelirikon lisääminen polygon    7311372, 478787


Kelirikon katkaisu
    [Tags]    Kelirikko
    [Documentation]    Kelirikkotiedon katkaisu
    Log    Testataan kelirikon katkaisu
    KW_Kelirikko.Kelirikon katkaisu    7310648, 477675