# Matti Telenius        Sitowise Oy     2019

*** Variables ***


*** Settings ***
Documentation       Regression testcases for Digiroad
Resource            common_keywords.robot

Suite Setup         Login To DigiRoad
Suite Teardown      Close Browser

Test Setup          Testin Aloitus



*** Test Cases ***
Suojatie 1
    [Tags]              Suojatie
    [Documentation]     Suojatie, selain: ${BROWSER}
    ...  - Kartalla näkyvät Suojatie kun mittakaava on 1:20000 tai tarkempi.
    KW_Suojatie.Suojatie_1  6773658, 266918

#Suojatie 2
    #11.2.25 TARPEETTOMAKSI KÄYNYT TESTI
    #[Tags]              Suojatie
    #[Documentation]     Suojatie, selain: ${BROWSER}
    #...  - Tarkistetaan olemassa olevaa Suojatietä - Formin id
    #KW_Suojatie.Suojatie_2  Geometrian
    #Testin Aloitus
    #KW_Suojatie.Suojatie_2  Laatuvirhe


Suojatie 3
    [Tags]              Suojatie
    [Documentation]     Suojatie, selain: ${BROWSER}
    ...   - Suojatie muokkaus.
    KW_Suojatie.Suojatie_3  6818935,325475

Suojatie 4
    [Tags]              Suojatie  AWS
    [Documentation]     Suojatie, selain: ${BROWSER}
    ...   - Luodaan uusi kunnan ylläpitämä Suojatie ja tarkistetaan formin validoinnit, sekä tietojen tallentuminen.
    KW_Suojatie.Suojatie_4  6818971,325271
