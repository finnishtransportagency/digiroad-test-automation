#    Joni Laari    Sitowise    2024

*** Settings ***
Documentation       Regression testcases for Digiroad
Resource            common_keywords.robot

Suite Setup         Login To DigiRoad
Suite Teardown      Close Browser

Test Setup          Testin Aloitus

*** Variables ***
@{Hoitoluokka_lista}=    paakadut-ja-vilkkaat-vaylat    kokoojakadut    tonttikadut    a-luokan-vaylat    b-luokan-vaylat    c-luokan-vaylat

@{Hoitoluokka_numero_lista}=    20    30    40    50    60    70

${hoitoluokka_dropdown_indeksi}    0

@{hoitoluokka_vuodenaika_lista}=    greenCare    winterCare


*** Test Cases ***
Hoitoluokan tarkastelu
    [Tags]  Hoitoluokat
    [Documentation]  Hoitoluokan tarkastelu katselumoodissa.
    Log    Testataan hoitoluokan tarkastelu
    KW_Hoitoluokat.Hoitoluokan tarkastelu    7057407, 480798


Hoitoluokan muokkaus koko ketjulle
    [Tags]    Hoitoluokat
    [Documentation]  Hoitoluokan muokkaus koko ketjulle.
    Log    Testataan hoitoluokan tarkastelu
    FOR    ${i}    IN    @{Hoitoluokka_lista}
        FOR    ${j}    IN    @{hoitoluokka_vuodenaika_lista}
            Log    ${j}
            Log    ${i}
            KW_Hoitoluokat.Hoitoluokan muokkaus koko ketjulle    6909992, 447701    ${i}    ${j}    ${hoitoluokka_dropdown_indeksi}
            ${hoitoluokka_dropdown_indeksi}=    Evaluate    ${hoitoluokka_dropdown_indeksi} + 1
        END
    END
    ${hoitoluokka_dropdown_indeksi}=    Evaluate    ${hoitoluokka_dropdown_indeksi} * 0


Hoitoluokan muokkaus ketjun osalle
    [Tags]    Hoitoluokat
    [Documentation]  Hoitoluokan muokkaus ketjun osalle.
    Log    Testataan hoitoluokan tarkastelu
    FOR    ${i}    IN    @{Hoitoluokka_lista}
        FOR    ${j}    IN    @{hoitoluokka_vuodenaika_lista}
            Log    ${j}
            Log    ${i}
            KW_Hoitoluokat.Hoitoluokan muokkaus ketjun osalle    6909992, 447701    ${i}    ${j}    ${hoitoluokka_dropdown_indeksi}
            ${hoitoluokka_dropdown_indeksi}=    Evaluate    ${hoitoluokka_dropdown_indeksi} + 1
        END
    END
    ${hoitoluokka_dropdown_indeksi}=    Evaluate    ${hoitoluokka_dropdown_indeksi} * 0