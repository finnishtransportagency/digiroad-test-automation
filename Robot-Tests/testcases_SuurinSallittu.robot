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
    KW_SuurinSallittu.Massa_1  ${TL_suurin_sallittu_massa_RB}  7391739, 424820  32000 Kg    on
    KW_SuurinSallittu.Massa_1  ${TL_Yhdistelmän_suurin_sallittu_massa_RB}  7391739, 424820  60000 Kg    on
    KW_SuurinSallittu.Massa_1  ${TL_suurin_sallittu_akselimassa_RB}  6703234, 496282  8000 Kg    on
    KW_SuurinSallittu.Massa_1  ${TL_suurin_sallittu_telimassa_RB}  6772341, 329783  18000 Kg    on
    KW_SuurinSallittu.Massa_1  ${TL_suurin_sallittu_korkeus_RB}  6700690, 288675  260 cm    on
    KW_SuurinSallittu.Massa_1  ${TL_suurin_sallittu_pituus_RB}  6677101, 387259  1200 cm    on
    KW_SuurinSallittu.Massa_1  ${TL_suurin_sallittu_leveys_RB}  6770627, 427967  550 cm    on

Suurin Sallittu 2
    [Tags]              Massa
    [Documentation]     Suurin Sallittu Massa, selain: ${BROWSER}
    ...  - Asetetaan linkille kaikki mahdolliset "Suurin Sallittu" tietolajit.
    KW_SuurinSallittu.Massa_2  ${TL_suurin_sallittu_massa_RB}  6891584, 397028  123
    KW_SuurinSallittu.Massa_2  ${TL_Yhdistelmän_suurin_sallittu_massa_RB}  6891584, 397028  123
    KW_SuurinSallittu.Massa_2  ${TL_suurin_sallittu_akselimassa_RB}  6891584, 397028  123
    KW_SuurinSallittu.Massa_2  ${TL_suurin_sallittu_telimassa_RB}  6891584, 397028  123
    KW_SuurinSallittu.Massa_2  ${TL_suurin_sallittu_korkeus_RB}  6891584, 397028  123
    KW_SuurinSallittu.Massa_2  ${TL_suurin_sallittu_pituus_RB}  6891584, 397028  123
    KW_SuurinSallittu.Massa_2  ${TL_suurin_sallittu_leveys_RB}  6891584, 397028  123
