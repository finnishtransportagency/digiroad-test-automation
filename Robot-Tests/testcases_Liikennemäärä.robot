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

    KW_Liikennemäärä.Liikennemäärän tarkastelu klikkaamalla    6899004, 433707


Liikennemäärän muokkaus koko ketjulle
    [Tags]    Liikennemäärä
    [Documentation]    Liikennemäärän muokkaus koko ketjulle

    KW_Liikennemäärä.Liikennemäärän muokkaus koko ketjulle    6905144, 434064


Liikennemäärän muokkaus ketjun osalle
    [Tags]    Liikennemäärä
    [Documentation]    Liikennemäärän muokkaus ketjun osalle

    KW_Liikennemäärä.Liikennemäärän muokkaus koko ketjulle    6905144, 434064


Liikennemäärän laatikkovalinta
    [Tags]    Liikennemäärä
    [Documentation]    Liikennemäärän laatikkovalinta

    KW_Liikennemäärä.Liikennemäärän laatikkovalinta           6905144, 434064


Liikennemäärän polygonvalinta
    [Tags]    Liikennemäärä
    [Documentation]    Liikennemäärän monikulmiovalinta

    KW_Liikennemäärä.Liikennemäärän polygonvalinta           6905144, 434064
    

Liikennemäärän ctrlvalinta
    [Tags]    Liikennemäärä
    [Documentation]    Liikennemäärän ctrl-valinta

    KW_Liikennemäärä.Liikennemäärän ctrlvalinta           6905144, 434064