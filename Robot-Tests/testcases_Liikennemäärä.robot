# Joni Laari        Sitowise     2024

*** Variables ***

*** Settings ***
Documentation       Regression testcases for Digiroad
Resource            common_keywords.robot

Suite Setup         Login To DigiRoad
Suite Teardown      Close Browser

Test Setup          Testin Aloitus

*** Test Cases ***
Liikennemäärän tarkastelu zoomilla
    [Tags]  Liikennemäärä
    [Documentation]  Liikennemäärän tarkastelu katselumoodissa.

    KW_Liikennemäärä.Liikennemäärän tarkastelu zoomilla      6901342, 435068


Liikennemäärän tarkastelu klikkaamalla
    [Tags]    Liikennemäärä
    [Documentation]    Liikennemäärän tarkastelu klikkaamalla

    KW_Liikennemäärä.Liikennemäärän tarkastelu klikkaamalla    6905144, 434064


Liikennemäärän muokkaus koko ketjulle
    [Tags]    Liikennemäärä
    [Documentation]    Liikennemäärän muokkaus koko ketjulle

    KW_Liikennemäärä.Liikennemäärän muokkaus koko ketjulle    6905144, 434064