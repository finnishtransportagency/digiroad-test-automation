# Joni Laari        Sitowise Oy     2022

*** Variables ***

*** Settings ***
Documentation       Regression testcases for Digiroad
Resource            common_keywords.robot

Suite Setup         Login To DigiRoad
Suite Teardown      Close Browser

Test Setup          Testin Aloitus


*** Test Cases ***
Ajoneuvorajoitus 1
    [Tags]  AWS  AKR
    [Documentation]  Ajoneuvorajoituksen tarkastelu katselumoodissa.

    KW_AKR.AKR_1      6888907, 429796


Ajoneuvorajoitus 2
    [Tags]  AWS  AKR
    [Documentation]  Ajoneuvorajoituksen muokkaus koko ketjulle

    KW_AKR.AKR_2      6748291, 483946


Ajoneuvorajoitus 3
    [Tags]  AWS  AKR
    [Documentation]  Ajoneuvorajoituksen muokkaus ketjun osalle (tuplaklikkaus)

    KW_AKR.AKR_3      6674192, 386227


Ajoneuvorajoitus 4
    [Tags]  AWS  AKR
    [Documentation]  Lisätään uusi ajoneuvorajoite

    KW_AKR.AKR_4      6917537, 208490


Ajoneuvorajoitus 5
    [Tags]  AWS  AKR
    [Documentation]  Poistetaan luotu rajoite

    KW_AKR.AKR_5      6748291, 483943


Ajoneuvorajoitus 6
    [Tags]  AWS  AKR
    [Documentation]  Usean kohteen valinta ja muokkaus monikulmiovalinnalla.

    KW_AKR.AKR_6      6902077, 432044


#Jätetään odottamaan klikkausten korjausta
Ajoneuvorajoitus 7
    [Tags]  AWS  AKR
    [Documentation]  Ajoneuvorajoituksen katkaisu kahdeksi osaksi leikkaustyökalulla.

    KW_AKR.AKR_7      6821573, 332374

