# Matti Telenius        Sitowise Oy     2019

*** Settings ***
Documentation       Regression testcases for Digiroad
Resource            common_keywords.robot
Suite Setup         Login To DigiRoad
Suite Teardown      Close Browser
Test Setup          Testin Aloitus


*** Test Cases ***
Opastustaulu 1
    [Tags]             Opastustaulu
    [Documentation]    Opastustaulu, selain: ${BROWSER}
    ...                - Kartalla näkyvät  Opastustaulu kun mittakaava on 1:20000 tai tarkempi.
    KW_Opastustaulu.Opastustaulu_1    6738107,251253


#Opastustaulu 2
    #11.2.25 TARPEETTOMAKSI KÄYNYT TESTI
    #[Tags]              Opastustaulu
    #[Documentation]      Opastustaulu, selain: ${BROWSER}
    #...  - Geometrian Ulkopuolelle jääneet opastaulut.
    #KW_Opastustaulu.Opastustaulu_2  6738106,251254


Opastustaulu 3
    [Tags]               Opastustaulu
    [Documentation]      Opastustaulu, selain: ${BROWSER}
    ...                  -  Opastustaulu muokkaus.
    KW_Opastustaulu.Opastustaulu_3    6738106,251254


Opastustaulu 4
    [Tags]               Opastustaulu  AWS
    [Documentation]      Opastustaulu, selain: ${BROWSER}
    ...                  - Luodaan uusi kunnan ylläpitämä  Opastustaulu ja tarkistetaan formin validoinnit, sekä tietojen tallentuminen.
    KW_Opastustaulu.Opastustaulu_4    7537607, 583699

