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
@{Huoltotie_käyttöoikeus_numerot}    1    2    3    4    6    9    99
@{Huoltotie_huoltovastuu_numerot}    1    2    99


#responsibility/rightofuse korjattava takaisin kun testit toimii 19.9
*** Test Cases ***
Rautateiden huoltotien tarkastelu
    [Tags]  Rautateiden_huoltotiet    BROKEN
    [Documentation]  Huoltoteiden tarkastelu katselumoodissa.
    Log    RIKKI Rautatien huoltotien tarkastelu
    #FOR    ${i}    IN    @{rautatien_huoltotiet_radionappi}
    #    IF    $rautatien_huoltotiet_radionappi == "responsibility"
    #        Log    Testataan huoltoteiden tarkastelu käyttöoikeudella
    #    #KW_Rautatien_huoltotie.Rautateiden huoltotien tarkastelu käyttöoikeus    6747441, 481740    ${rautatien_huoltotiet_radionappi}[0]
    #    ELSE
    #        Log    Testataan huoltoteiden tarkastelu huoltovastuulla
    #        #KW_Rautatien_huoltotie.Rautateiden huoltotien tarkastelu huoltovastuu    6747441, 481740    ${rautatien_huoltotiet_radionappi}[1]
    #    END
    #END


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
    FOR    ${k}    IN    @{Huoltotie_käyttöoikeus_kohteet}
        Log    ${k}
        KW_Rautatien_huoltotie.Rautateiden huoltotien muokkaus ketjun osalle    6747441, 481740    ${k}
    END


Rautateiden huoltotien lisääminen usealle laatikolla
    [Tags]    Rautateiden_huoltotiet
    [Documentation]    Huoltoteiden lisääminen laatikkovalinnalla
    Log    RIKKI Testataan usean linkin lisääminen laatikkovalinnalla
    FOR    ${l}        IN    @{Huoltotie_käyttöoikeus_numerot}
        FOR    ${m}    IN    @{Huoltotie_huoltovastuu_numerot}
            Log    ${l}
            Log    ${m}
            #KW_Rautatien_huoltotie.Rautateiden huoltotien lisääminen usealle laatikolla    6747441, 481740    ${l}    ${m}
        END
    END


Rautateiden huoltotien lisääminen usealle polygonilla
    [Tags]    Rautateiden_huoltotiet
    [Documentation]    Huoltoteiden lisääminen polygonilla
    Log    RIKKI Testataan usean linkin lisääminen polygonilla
    FOR    ${n}        IN    @{Huoltotie_käyttöoikeus_numerot}
        FOR    ${o}    IN    @{Huoltotie_huoltovastuu_numerot}
            Log    ${n}
            Log    ${o}
            #KW_Rautatien_huoltotie.Rautateiden huoltotien lisääminen usealle polygonilla    6747441, 481740    ${n}    ${o}
        END
    END


Rautateiden huoltotien lisääminen usealle ctrl
    [Tags]    Rautateiden_huoltotiet
    [Documentation]    Huoltoteiden lisääminen ctrl
    Log    RIKKI Testataan usean linkin lisääminen ctrl
    FOR    ${p}        IN    @{Huoltotie_käyttöoikeus_numerot}
        FOR    ${q}    IN    @{Huoltotie_huoltovastuu_numerot}
            Log    ${p}
            Log    ${q}
            #KW_Rautatien_huoltotie.Rautateiden huoltotien lisääminen usealle ctrl    6676576, 384823    ${p}    ${q}
        END
    END


Rautateiden huoltotien katkaisu
    [Tags]    Rautateiden_huoltotiet
    [Documentation]    Huoltoteiden katkaisu
    Log    Testataan rautateiden huoltotien katkaisu
    FOR    ${r}        IN    @{Huoltotie_käyttöoikeus_numerot}
        FOR    ${s}    IN    @{Huoltotie_huoltovastuu_numerot}
            Log    ${r}
            Log    ${s}
            KW_Rautatien_huoltotie.Rautateiden huoltotien katkaisu    6676576, 384823    ${r}    ${s}
        END
    END