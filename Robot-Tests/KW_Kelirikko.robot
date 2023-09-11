#       Joni Laari        Sitowise        2023

*** Settings ***
Documentation       Keywords for thaw damage (Kelirikko)
Library             SeleniumLibrary
Resource            common_keywords.robot


*** Keywords ***
Kelirikkotiedon tarkastelu    [arguments]    ${testipaikka}
    #testitapaus 1, 2, 3
    Testin Aloitus
    Log                                         Tarkistetaan kelirikon lisäys
    Vaihda Tietolaji                            ${TL_Kelirikko_RB}
    Paikanna osoite                             ${testipaikka}
    Zoomaa kartta                               5    200
    Odota sivun latautuminen

    