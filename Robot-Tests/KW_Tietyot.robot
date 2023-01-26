#       Joni Laari      Sitowise     2023

*** Settings ***
Documentation       Keywords for roadworks (Tietyöt)
Library    SeleniumLibrary
Resource    common_keywords.robot

*** Keywords ***
Tietyön_tarkastelu   [arguments]            ${testipaikka}
    Log     Tietyön tarkastelu katselutilassa.
    #testataan valinnan toimivuus
    Vaihda Tietolaji                            ${TL_Tietyöt_RB}
    Paikanna osoite                             ${testipaikka}
    Zoomaa kartta                               5   20 m
    Odota sivun latautuminen

*** Variables ***
