#    Joni Laari    Sitowise    2024

*** Settings ***
Documentation       Regression testcases for Digiroad
Resource            common_keywords.robot

Suite Setup         Login To DigiRoad
Suite Teardown      Close Browser

Test Setup          Testin Aloitus

*** Variables ***
@{rautatien_huoltotiet_radionappi}    responsibility    rightOfUse
@{Huoltotie_käyttöoikeus_kohteet}    Tieoikeus    Tiekunnan osakkuus    LiVin hallinnoimalla maa-alueella    Kävelyn ja pyöräilyn väylä    Muu sopimus    Potentiaalinen käyttöoikeus    Tuntematon


#responsibility/rightofuse korjattava takaisin kun testit toimii 19.9
*** Test Cases ***
Rautateiden huoltotien tarkastelu
    [Tags]  Rautateiden_huoltotiet
    [Documentation]  Huoltoteiden tarkastelu katselumoodissa.
    FOR    ${i}    IN    @{rautatien_huoltotiet_radionappi}
        IF    $rautatien_huoltotiet_radionappi == "responsibility"
            Log    Testataan huoltoteiden tarkastelu käyttöoikeudella
        KW_Rautatien_huoltotie.Rautateiden huoltotien tarkastelu käyttöoikeus    6747441, 481740    ${rautatien_huoltotiet_radionappi}[0]
        ELSE
            Log    Testataan huoltoteiden tarkastelu huoltovastuulla
            KW_Rautatien_huoltotie.Rautateiden huoltotien tarkastelu huoltovastuu    6747441, 481740    ${rautatien_huoltotiet_radionappi}[1]
        END
    END


Rautateiden huoltotien muokkaus koko ketjulle
    [Tags]  Rautateiden_huoltotiet
    [Documentation]  Huoltoteiden muokkaus koko ketjulle.
    Log    Testataan huoltoteiden muokkaus koko ketjulle
    FOR    ${j}    IN    @{Huoltotie_käyttöoikeus_kohteet}
        Log    ${j}
        KW_Rautatien_huoltotie.Rautateiden huoltotien muokkaus koko ketjulle    6747441, 481740    ${j}
    END


Rautateiden huoltotien muokkaus ketjun osalle
    [Tags]  Rautateiden_huoltotiet
    [Documentation]  Huoltoteiden muokkaus ketjun osalle
    Log    Testataan huoltoteiden muokkaus ketjun osalle
    FOR    ${j}    IN    @{Huoltotie_käyttöoikeus_kohteet}
        Log    ${j}
        KW_Rautatien_huoltotie.Rautateiden huoltotien muokkaus ketjun osalle    6747441, 481740    ${j}
    END


Rautateiden huoltotien lisääminen usealle laatikolla
    [Tags]    Rautateiden_huoltotiet
    [Documentation]    Huoltoteiden lisääminen laatikkovalinnalla
    Log    Testataan usean linkin lisääminen laatikkovalinnalla
    KW_Rautatien_huoltotie.Rautateiden huoltotien lisääminen usealle laatikolla    6747441, 481740


Rautateiden huoltotien lisääminen usealle polygonilla
    [Tags]    Rautateiden_huoltotiet
    [Documentation]    Huoltoteiden lisääminen polygonilla
    Log    Testataan usean linkin lisääminen polygonilla
    KW_Rautatien_huoltotie.Rautateiden huoltotien lisääminen usealle polygonilla    6747441, 481740