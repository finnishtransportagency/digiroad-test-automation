#     Joni Laari        Sitowise     2023

*** Variables ***
@{routivuuskertoimet_lista}=    40-erittain-routiva    50-valiarvo-50...60    60-routiva    70-valiarvo-60...80    80-routimaton    ei-tietoa

@{kevätkantavuus_virheelliset_lista}=    -500    eiolenumero    99.99

*** Settings ***
Documentation       Regression testcases for Digiroad
Resource            common_keywords.robot

Suite Setup         Login To DigiRoad
Suite Teardown      Close Browser

Test Setup          Testin Aloitus


*** Test Cases ***
Kevätkantavuus_lisäys
    [Tags]  Kantavuus
    [Documentation]  Kantavuuden tarkastelu katselumoodissa.
    Log    Testataan kantavuuden lisäys sekä virheellisen arvon syöttö
    FOR    ${routivuuskerroin}    IN    @{routivuuskertoimet_lista}
        KW_Kantavuus.Kevätkantavuus_lisäys    7311372, 478787    ${routivuuskerroin}
    END
    FOR    ${virheellinen}    IN    @{kevätkantavuus_virheelliset_lista}
        Log    ${virheellinen}
        KW_Kantavuus.Kantavuus_lisäys_virheellinen    7311372, 478787    ${virheellinen}
    END


Kantavuuden_lisääminen_laatikko
    [Tags]  Kantavuus
    [Documentation]  Kantavuuden tarkastelu katselumoodissa.
    Log    Testataan kantavuuden lisäys sekä virheellisen arvon syöttö
    KW_Kantavuus.Kantavuuden_lisääminen_laatikko    7311372, 478787    40-erittain-routiva


Kantavuuden_lisääminen_polygon
    [Tags]  Kantavuus
    [Documentation]  Kantavuuden tarkastelu katselumoodissa.
    Log    Testataan kantavuuden lisäys sekä virheellisen arvon syöttö
    KW_Kantavuus.Kantavuuden_lisääminen_polygon    7311372, 478787    40-erittain-routiva