# Matti Telenius        Sitowise Oy     2019

*** Variables ***


*** Settings ***
Documentation       Regression testcases for Digiroad
Resource            common_keywords.robot

Suite Setup         Login To DigiRoad
Suite Teardown      Close Browser

Test Setup          Testin Aloitus



*** Test Cases ***
Esterakennelma 1
    [Tags]              Este
    [Documentation]     Esterakennelma, selain: ${BROWSER}
    ...  - Kartalla näkyvät Esterakennelma kun mittakaava on 1:20000 tai tarkempi.
    KW_Esterakennelma.Este_1  6936240, 397200

Esterakennelma 2
    [Tags]              Este
    [Documentation]     Esterakennelma, selain: ${BROWSER}
    ...  - Tarkistetaan esterakenelmien tyyppi
    KW_Esterakennelma.Este_2  6711851,240709  Suljettu yhteys
    KW_Esterakennelma.Este_2  6820366,336639  Avattava puomi
    #KW_Esterakennelma.Este_2  6711833,239489  Geometrian ulkopuolella

Esterakennelma 3
    [Tags]              Este
    [Documentation]     Esterakennelma, selain: ${BROWSER}
    ...   - Esterakennelmaa voi siirtää, sekä tyyppiä muokata.
    KW_Esterakennelma.Este_3  6761072,212356  Suljettu yhteys

Esterakennelma 4
    [Tags]              Este  AWS
    [Documentation]     Esterakennelma, selain: ${BROWSER}
    ...   - Luodaan uusi kunnan esteraknnelma, tarkistetaan luontipäivä ja poistetaan este.
    KW_Esterakennelma.Este_4  7537607, 583699
