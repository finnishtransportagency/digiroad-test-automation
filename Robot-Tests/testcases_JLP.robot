# Niko Lahtinen  Sitowise  2020

*** Variables ***


*** Settings ***
Documentation       Regression testcases for Digiroad
Resource            common_keywords.robot

Suite Setup         Login To DigiRoad
Suite Teardown      Close Browser

Test Setup          Testin Aloitus



*** Test Cases ***
Pysäkit 1
    [Tags]              JLP
    [Documentation]     Pysäkit, selain: ${BROWSER}
    ...  - Kartalla näkyvät pysäkit kun mittakaava on 1:20000 tai tarkempi.
    KW_JLP.JLP_1  6710928,255265

Pysäkit 2
    [Tags]              JLP
    [Documentation]     Pysäkit, selain: ${BROWSER}
    ...  - Luetaan terminaalipysäkin tiedot
    KW_JLP.JLP_2  6672034, 385242

Pysäkit 3
    [Tags]              JLP
    [Documentation]     Pysäkit, selain: ${BROWSER}
    ...   - Pysäkkien siirrosta yli 50m tulee popup, varmistetaan ELYn ja kuntalaisten viestit.
    KW_JLP.JLP_3  6710786, 241841  ei
    Testin Aloitus
    KW_JLP.JLP_3  6706716, 243306  kyllä

Pysäkit 4
    [Tags]              JLP  AWS
    [Documentation]     Pysäkit, selain: ${BROWSER}
    ...   - Luodaan uusi kunnan ylläpitämä pysäkki ja tarkistetaan formin validoinnit, sekä tietojen tallentuminen.
    KW_JLP.JLP_4  7537607, 583699  ELY
    KW_JLP.JLP_4  7413946, 573403  Kunta
