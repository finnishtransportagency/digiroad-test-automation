# Joni Laari        Sitowise Oy     2022

*** Variables ***

*** Settings ***
Documentation       Regression testcases for Digiroad
Resource            common_keywords.robot

Suite Setup         Login To DigiRoad
Suite Teardown      Close Browser

Test Setup          Testin Aloitus


*** Test Cases ***
Ajoneuvorajoituksen tarkastelu zoomilla
    [Tags]  AKR
    [Documentation]  Ajoneuvorajoituksen tarkastelu katselumoodissa.

    KW_AKR.Ajoneuvorajoituksen tarkastelu zoomilla      6682951, 382428


Ajoneuvorajoituksen tarkastelu klikkaamalla
    [Tags]  AKR
    [Documentation]  Ajoneuvorajoituksen tarkastelu katselumoodissa.

    KW_AKR.Ajoneuvorajoituksen tarkastelu klikkaamalla      6821622, 328910


Ajoneuvorajoituksen muokkaus koko ketjulle
    [Tags]  AKR
    [Documentation]  Ajoneuvorajoituksen muokkaus koko ketjulle

    KW_AKR.Ajoneuvorajoituksen muokkaus koko ketjulle      6905727, 433216    ${Popup_AjoneuvoRajoitus_Ajoneuvo}           ajoneuvo
    KW_AKR.Ajoneuvorajoituksen muokkaus koko ketjulle      6905727, 433216    ${Popup_AjoneuvoRajoitus_Moottoriajoneuvo}   moottoriajoneuvo
    KW_AKR.Ajoneuvorajoituksen muokkaus koko ketjulle      6905727, 433216    ${Popup_AjoneuvoRajoitus_Lapiajo}            lapiajo


Ajoneuvorajoituksen osan muokkaus
    [Tags]    AKR
    [Documentation]  Ajoneuvorajoituksen muokkaus ketjun osalle (tuplaklikkaus)

    KW_AKR.Ajoneuvorajoituksen osan muokkaus      6820883, 329145    ${Popup_AjoneuvoRajoitus_Ajoneuvo}           ajoneuvo
    KW_AKR.Ajoneuvorajoituksen osan muokkaus      6820883, 329145    ${Popup_AjoneuvoRajoitus_Moottoriajoneuvo}   moottoriajoneuvo
    KW_AKR.Ajoneuvorajoituksen osan muokkaus      6820883, 329145    ${Popup_AjoneuvoRajoitus_Lapiajo}            lapiajo


AKR usealle linkille laatikolla
    [Tags]    AKR
    [Documentation]    Tarkistetaan monivalinta laatikkotyökalulla

    KW_AKR.AKR usealle linkille laatikolla    6905798, 433202    ${Popup_AjoneuvoRajoitus_Ajoneuvo}           ajoneuvo
    #KW_AKR.AKR usealle linkille laatikolla    6905798, 433202    ${Popup_AjoneuvoRajoitus_Moottoriajoneuvo}   moottoriajoneuvo
    #KW_AKR.AKR usealle linkille laatikolla    6905798, 433202    ${Popup_AjoneuvoRajoitus_Lapiajo}            lapiajo


AKR usealle linkille polygonilla
    [Tags]    AKR
    [Documentation]  Tarkistetaan monivalinta polygonityökalulla

    KW_AKR.AKR usealle linkille polygonilla    6905798, 433202    ${Popup_AjoneuvoRajoitus_Ajoneuvo}           ajoneuvo
    #KW_AKR.AKR usealle linkille polygonilla    6905798, 433202    ${Popup_AjoneuvoRajoitus_Moottoriajoneuvo}   moottoriajoneuvo
    #KW_AKR.AKR usealle linkille polygonilla    6905798, 433202    ${Popup_AjoneuvoRajoitus_Lapiajo}            lapiajo


AKR usealle linkille klikkaamalla
    [Tags]    AKR
    [Documentation]  Tarkistetaan monivalinta polygonityökalulla

    KW_AKR.AKR usealle linkille klikkaamalla    6902153, 432732    ${Popup_AjoneuvoRajoitus_Ajoneuvo}           ajoneuvo
    #KW_AKR.AKR usealle linkille klikkaamalla    6902153, 432732    ${Popup_AjoneuvoRajoitus_Moottoriajoneuvo}   moottoriajoneuvo
    #KW_AKR.AKR usealle linkille klikkaamalla    6902153, 432732    ${Popup_AjoneuvoRajoitus_Lapiajo}            lapiajo


AKR jako kahdeksi
    [Tags]    AKR
    [Documentation]  Ajoneuvorajoituksen katkaisu kahdeksi osaksi leikkaustyökalulla.

    KW_AKR.AKR jako kahdeksi      6893843, 431315    ajoneuvo

