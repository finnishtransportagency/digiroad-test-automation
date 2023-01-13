#     Joni Laari        Sitowise     2023

*** Variables ***

*** Settings ***
Documentation       Regression testcases for Digiroad
Resource            common_keywords.robot

Suite Setup         Login To DigiRoad
Suite Teardown      Close Browser

Test Setup          Testin Aloitus


*** Test Cases ***
Valaistuksen_tarkistus
    [Tags]  Valaistus
    [Documentation]  Valaistuksen tarkastelu katselumoodissa.
    Log    Testataan valaistuksen tarkastelu

    KW_Valaistus.Valaistus_tarkistus    6900857, 432893


Valaistuksen_radionappi
    [Tags]  Valaistus
    [Documentation]    Valaistuksen radionappien toimivuus

    KW_Valaistus.Valaistuksen_radionappi    6900126, 432644


Valaistustieto usealle linkille laatikolla
    [Tags]    Valaistus
    [Documentation]    Valaistustiedon lisääminen usealle linkille kahdella tavoin (laatikko ja polygon)

    KW_Valaistus.Valaistustieto usealle linkille laatikolla    6892730, 417555


Valaistustieto usealle linkille polygonilla
    [Tags]    Valaistus
    [Documentation]    Valaistustiedon lisääminen usealle linkille kahdella tavoin (laatikko ja polygon)

    KW_Valaistus.Valaistustieto usealle linkille polygonilla    6892730, 417555


Usean valaistuslinkin klikkausvalinta
    [Tags]    Valaistus
    [Documentation]    Valaistustiedon lisääminen usealle linkille ctrl-napin avulla

    KW_Valaistus.Usean valaistuslinkin klikkausvalinta    6711673, 239889


Valaistuksen katkaisu
    [Tags]    Valaistus
    [Documentation]    Valaistuksen katkaisu

    KW_Valaistus.Valaistuksen katkaisu                   6898855, 433267