*** Settings ***
Documentation       Regression testcases for Digiroad
Resource            common_keywords.robot

Suite Setup         Login To DigiRoad
Suite Teardown      Close Browser

Test Setup          Testin Aloitus


*** Test Cases ***
Kääntymisrajoitus 1
    [Tags]  
    [Documentation]  Takistetaan tielinkki, jolla on yksi kääntymirajoitus.
    KW_Kaantymisrajoitus.KR_1  6671992, 385433

# Testin kohdetta ei Pilvi QA puolella
# Kääntymisrajoitus 2
#     [Tags]  
#     [Documentation]  Tarkistetaan tielinkki, jossa on useita kääntymisrajoituksia.
#     KW_Kaantymisrajoitus.KR_2  6711114, 238672

Kääntymisrajoitus 3
    [Tags]  AWS
    [Documentation]  Luodaan uusi kääntymisrajoitus, tarkistetaan tallennetut tiedot.
    KW_Kaantymisrajoitus.KR_3  6750859, 480701

#Kääntymisrajoitus 4
    #[Documentation]  Luodaan uusi kääntymisrajoitus usealle tielinkille. Muokataan tallennusta ja tarkistetaan tiedot.
    #...  Käyttäjätarina: DROTH-177
    #KW_Kaantymisrajoitus.KR_4  6750917, 480775
