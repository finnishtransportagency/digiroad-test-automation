#    Joni Laari    Sitowise    2024

*** Settings ***
Documentation       Keywords for vehicle-specific constraints (ajoneuvokohtainen rajoitus)
Library    SeleniumLibrary
Library    selenium_extensions.py
Library    Screenshot
Resource   common_keywords.robot

*** Keywords ***
Liikennemäärän tarkastelu zoomilla   [arguments]     ${testipaikka}
    Log     Liikennemäärän tarkastelu katselutilassa.
    #testataan valinnan toimivuus
    Vaihda Tietolaji                            ${TL_Liikennemäärä_RB}
    Paikanna osoite                             ${testipaikka}
    Zoomaa kartta                               5   200 m
    Odota sivun latautuminen
    Wait Until Element Is Visible               ${Kartta}
    Element Should Be Visible                   ${Kartta}
    #Linkkien visualisoitumisen tarkistus
    #Take Screenshot                             LOGDIR/liikennemäärä.jpg    #voidaan tarkistaa silmämääräisesti logista


Liikennemäärän tarkastelu klikkaamalla    [arguments]    ${testipaikka}
    Log    Liikennemäärän tarkastelu klikkaamalla
    Vaihda Tietolaji    ${TL_Liikennemäärä_RB}
    Paikanna osoite    ${testipaikka}
    Zoomaa kartta                               5   50 m
    Odota sivun latautuminen
    Click Element At Coordinates                ${Kartta}   0  20
    Wait Until Element Is Visible               ${FA_otsikko}
    Element Should Be Visible    ${FA_Lisätty_Järjestelmään}
    Element Should Be Visible    ${FA_Muokattu_viimeksi}
    Element Should Be Visible    ${FA_linkkien_lukumaara}
    Element Should Be Visible    ${FA_Liikennemäärä_lukema}
    Click Element At Coordinates                ${Kartta}  -100  -100
    Sleep    3

    #doubleclick
    Tupla Klikkaa Kartan Keskelle
    Wait Until Element Is Visible               ${FA_otsikko}
    Element Should Be Visible    ${FA_Lisätty_Järjestelmään}
    Element Should Be Visible    ${FA_Muokattu_viimeksi}
    Element Should Be Visible    ${FA_linkkien_lukumaara}
    Element Should Be Visible    ${FA_Liikennemäärä_lukema}
    Click Element At Coordinates                ${Kartta}  -100  -100


Liikennemäärän muokkaus koko ketjulle    [arguments]    ${testipaikka}
    Log    Liikennemäärän muokkaus koko ketjulle
    Vaihda Tietolaji    ${TL_Liikennemäärä_RB}
    Paikanna osoite                             ${testipaikka}
    Zoomaa kartta                               5   50 m
    Odota sivun latautuminen
    Siirry Muokkaustilaan
    Wait Until Element Is Not Visible           ${Map_popup}
    Click Element At Coordinates                ${Kartta}  0  20
    Wait Until Element Is Visible               ${FA_Lisätty_järjestelmään}


*** Variables ***
${FA_Liikennemäärä_lukema}    css=#feature-attributes-form > div > div > div.form-elements-container > div > p