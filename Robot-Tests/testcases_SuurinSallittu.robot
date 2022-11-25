*** Settings ***
Documentation       Testit nimetty "Suurin Sallittu ***"
Resource            common_keywords.robot

Suite Setup         Login To DigiRoad
Suite Teardown      Close Browser

Test Setup          Testin Aloitus



*** Test Cases ***
Suurin Sallittu 1
    [Tags]              Massa
    [Documentation]     Suurin Sallittu Massa, selain: ${BROWSER}
    ...  - Tarkistetaan, että tietokannasta löytyy "Suurin Sallittu" tietolajit.
    KW_SuurinSallittu.Massa_1  ${TL_suurin_sallittu_massa_RB}  7391739, 424820  32000 Kg
    KW_SuurinSallittu.Massa_1  ${TL_Yhdistelmän_suurin_sallittu_massa_RB}  6729702, 476907  32000 Kg
    KW_SuurinSallittu.Massa_1  ${TL_suurin_sallittu_akselimassa_RB}  6895368, 614738  8000 Kg
    KW_SuurinSallittu.Massa_1  ${TL_suurin_sallittu_telimassa_RB}  6673272, 389468  10000 Kg
    KW_SuurinSallittu.Massa_1  ${TL_suurin_sallittu_korkeus_RB}  6700679, 288627  260 cm
    KW_SuurinSallittu.Massa_1  ${TL_suurin_sallittu_pituus_RB}  6677101, 387259  1200 cm
    KW_SuurinSallittu.Massa_1  ${TL_suurin_sallittu_leveys_RB}  6770627, 427967  550 cm

Suurin Sallittu 2
    [Documentation]     Suurin Sallittu Massa, selain: ${BROWSER}
    ...  - Asetetaan linkille kaikki mahdolliset "Suurin Sallittu" tietolajit.
    KW_SuurinSallittu.Massa_2  ${TL_suurin_sallittu_massa_RB}  6891502, 397049  123
    KW_SuurinSallittu.Massa_2  ${TL_Yhdistelmän_suurin_sallittu_massa_RB}  6891502, 397049  123
    KW_SuurinSallittu.Massa_2  ${TL_suurin_sallittu_akselimassa_RB}  6891502, 397049  123
    KW_SuurinSallittu.Massa_2  ${TL_suurin_sallittu_telimassa_RB}  6891502, 397049  123
    KW_SuurinSallittu.Massa_2  ${TL_suurin_sallittu_korkeus_RB}  6891502, 397049  123
    KW_SuurinSallittu.Massa_2  ${TL_suurin_sallittu_pituus_RB}  6891502, 397049  123
    KW_SuurinSallittu.Massa_2  ${TL_suurin_sallittu_leveys_RB}  6891502, 397049  123
