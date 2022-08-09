# Matti Telenius        Sitowise Oy     2019

*** Variables ***


*** Settings ***
Documentation       Regression testcases for Digiroad
Resource            common_keywords.robot

Suite Setup         Login To DigiRoad
Suite Teardown      Close Browser

Test Setup          Testin Aloitus



*** Test Cases ***
Tasoristeys 1
    [Tags]              Tasoristeys
    [Documentation]     Rautatien tasoristeys, selain: ${BROWSER}
    ...  - Kartalla näkyvät Rautatien tasoristeys kun mittakaava on 1:20000 tai tarkempi.
    KW_Tasoristeys.Tasoristeys_1  6751566, 199829

# Poistettu käytöstä, ei ole geometrian ulkopuolisia tasoristeyksiä
# Tasoristeys 2
#     [Tags]              Tasoristeys
#     [Documentation]     Rautatien tasoristeys, selain: ${BROWSER}
#     ...  - Tarkistetaan olemassa olevaa Rautatien tasoristeystä - Formin id
#     KW_Tasoristeys.Tasoristeys_2

Tasoristeys 3
    [Tags]              Tasoristeys
    [Documentation]     Rautatien tasoristeys, selain: ${BROWSER}
    ...   - Rautatien tasoristeys muokkaus.
    KW_Tasoristeys.Tasoristeys_3  6714850,229269  Puolipuomi

Tasoristeys 4
    [Tags]              Tasoristeys  AWS
    [Documentation]     Rautatien tasoristeys, selain: ${BROWSER}
    ...   - Luodaan uusi kunnan ylläpitämä Rautatien tasoristeys ja tarkistetaan formin validoinnit, sekä tietojen tallentuminen.
    KW_Tasoristeys.Tasoristeys_4  7537607, 583699
