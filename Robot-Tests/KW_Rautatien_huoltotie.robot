#       Joni Laari        Sitowise        2024

*** Settings ***
Documentation       Keywords for railroad maintenance roads (Rautateiden huoltotiet)
Library             SeleniumLibrary
Resource            common_keywords.robot


*** Keywords ***
Rautateiden huoltotien tarkastelu    [arguments]    ${testipaikka}
    Log    Tarkastellaan rautateiden huoltotien ilmestyminen zoomatessa
    Vaihda Tietolaji    ${TL_Rautateiden_huoltotie_RB}
    Paikanna osoite    ${testipaikka}
    Zoomaa kartta    3    200
    Odota sivun latautuminen

    Click Element At Coordinates      ${Kartta}    0    20
    Wait Until Element Is Visible     ${FA_otsikko}
    Element Should Be Visible         ${FA_Lisätty_Järjestelmään}
    Element Should Be Visible         ${FA_Muokattu_viimeksi}

    Click Element At Coordinates      ${Kartta}    200    0
    Odota sivun latautuminen
    Tupla Klikkaa Kartan Keskelle
    Wait Until Element Is Visible     ${FA_otsikko}
    Element Should Be Visible         ${FA_Lisätty_Järjestelmään}
    Element Should Be Visible         ${FA_Muokattu_viimeksi}
    Click Element At Coordinates      ${Kartta}    200    0
    Odota sivun latautuminen