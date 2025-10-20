
*** Settings ***
Documentation       Pageobject for obstacles (Tasoristeys)
Resource            common_keywords.robot

*** Variables ***
${LocatorForDDM}
...                                css=#feature-attributes .form-group.editable select:first-of-type
${LocatorForDDM_Selection}         css=select > option:nth-child(2)
${Tasoristeyksen_poisto}           Haluatko varmasti poistaa tasoristeyksen?
##### Rautatien tasoristeykset ####
${FA_Tasoristeys_Poista_chkbx}     id=removebox
${FA_Tasoristeys_turvavarustus}    css=.form > div:nth-child(5) > p


*** Keywords ***
Tasoristeys_1    [Arguments]    ${testipaikka}
    Log    Zoomataan testipaikkaan, tarkistetaan että kohteessa on jotain tietoa
    Vaihda Tietolaji    ${TL_Rautatien_tasoristeys_RB}
    Paikanna Osoite     ${testipaikka}
    Odota Sivun Latautuminen
    Click Center Of The Map And Wait For Locator    ${FA_otsikko}
    Click Element At Coordinates    ${Kartta}    0    -100
    Wait Until Element Is Not Visible    ${FA_otsikko}
    Log    zoomataan kauemmas ja varmistetaan, ettei esterakennelma ole enää näkyvissä
    Click Element    ${zoombar_minus}
    Odota Sivun Latautuminen
    Wait Until Element Is Not Visible    ${Map_popup}
    Click Element At Coordinates    ${Kartta}  0  20
    Repeat Keyword    10 s    Element Should Not Be Visible   ${FA_otsikko}


Tasoristeys_2    #[arguments]  ${testipaikka}
    Log    Arvotaan Geometrian ulkopuolelle jääneet tasoristeykset listalta kohde ja tarkistetaan, että kohteen ID Täsmää.
    Vaihda Tietolaji    ${TL_Rautatien_tasoristeys_RB}
    Click Button    Geometrian ulkopuolelle jääneet tasoristeykset
    Wait Until Element Is Visible    css=.content-box>header  20
    Page Should Contain    Kunnan omistama
    Page Should Contain    Yksityisen omistama
    Page Should Contain    Valtion omistama
    Arvo Linkki Korjattavien Listalta
    Wait Until Element Is Visible    ${tmp_ListLocator}
    ${tmp_linkID} =    Seleniumlibrary.Get Text    ${tmp_ListLocator}
    ${tmp_linkID} =    Remove String    ${tmp_linkID}    \#railwayCrossings/
    Click Element    ${tmp_ListLocator}
    Odota Sivun Latautuminen
    Valitse Kohde
    Element Should Contain    ${FA_otsikko}    ${tmp_linkID}


Tasoristeys_3    [Arguments]    ${testipaikka}    ${Turvavarustus}
    Log    Siirrytään muokkaustilaan, valitaan esterakennelma ja muokataan sitä.
    Wait Until Element Is Visible    ${valitse tietolaji}
    Siirry Testipaikkaan    ${TL_Rautatien_tasoristeys_RB}    ${testipaikka}
    Valitse Esterakennelma
    Page Should Contain    ${Turvavarustus}
    Log    Siirretään setettä ja tarkistetaan, että siirron jälkeen tulee muokkausvaroitus.
    Siirry Muokkaustilaan
    Siirrä Kohde    -10    -100
    Click Element At Coordinates    ${Kartta}  100  100
    Wait Until Element Is Visible    ${Muokkausvaroitus}
    Click Button    ${Muokkausvaroitus_Sulje_btn}
    Click Element    ${FA_footer_Peruuta}
    # Sleep  5 s
    Log    Tarkistetaan, että ominaisuustietojen muokkauksesta tulee muokkausvaroitus.
    #click element at coordinates                ${kartta}   0   20
    #wait until element is visible               ${FA_otsikko}
    #Otettu pois koska ei toimi luotettavasti CI ympäristössä
    #DDM_tietolajit
    #Click element at coordinates                ${Kartta}  100  100
    #Wait Until Element Is Visible               ${Muokkausvaroitus}
    #Click Button                                ${Muokkausvaroitus_Sulje_btn}
    #click element                               ${FA_footer_Peruuta}


Tasoristeys_4    [Arguments]    ${testipaikka}
    ${date} =    Get Current Date    result_format=%d.%m.%Y
    Siirry Testipaikkaan    ${TL_Rautatien_tasoristeys_RB}    ${testipaikka}
    Odota Sivun Latautuminen
    Alusta Testipaikka
    Log    Luodaan uusi este, tarkistetaan Datetimen avulla luontipäivä.
    Luo Tasoristeys    tyyppi
    Siirry Katselutilaan
    Click Center Of The Map And Wait For Locator    ${FA_Lisätty_Järjestelmään}
    Element Should Contain    ${FA_Lisätty_Järjestelmään}    ${date}
    Poista Kohde


#######################
## Sisäiset keywordit #
#######################

Siirrä Tasoristeys    [Arguments]    ${xKoord}    ${yKoord}
    # Siirtää valittua tasoristeys annetun offsetin verran,
    # arvot positiivisia keskipisteestä oikealle ja alas
    Seleniumlibrary.Mouse Down    css=[class='crosshair crosshair-center']
    Seleniumlibrary.Drag And Drop By Offset
    ...    css=[class='crosshair crosshair-center']  ${xKoord}  ${yKoord}
    Seleniumlibrary.Mouse Up    css=[class='crosshair crosshair-center']


Tarkista Tasoristeyksen Olemassaolo
    # Käytetään uutta tasoristeystä luotaessa - Tarkistaa
    # jos tasoristeys on jo olemassa ja poistaa sen.
    Click Element At Coordinates    ${kartta}    20    -30
    ${passed} =    Run Keyword And Return Status
    ...    Wait Until Element Is Visible    ${FA_otsikko}    timeout=3
    Run Keyword If    ${passed}    Poista tasoristeys


Poista Tasoristeys
    Click Element    ${FA_Tasoristeys_Poista_chkbx}
    Click Element    ${FA_footer_Tallenna}
    Wait Until Element Is Visible    ${MuokkausVaroitus}
    SeleniumLibrary.Element Text Should Be    ${MuokkausVaroitus}     ${tasoristeyksen_poisto}
    Click Element    ${muokkausvaroitus_kyllä_btn}


Luo Tasoristeys    [arguments]    ${tyyppi}
    Log    Vaihtaa muokkaustilaan ja luo uuden tasoristeyksen kartan osoittamaan kohtaan.
    Siirry Muokkaustilaan
    Odota Sivun Latautuminen
    Tarkista Tasoristeyksen Olemassaolo
    Click Element    ${Muokkaustila_AddTool}
    Click Center Of The Map And Wait For Locator    ${FA_otsikko}
    Täytetään Tasoristeyksen Kentät
    Tallenna Muutokset


Täytetään Tasoristeyksen Kentät
    # Tarkistetaan validoinnit ja ilmoitustekstit, pakolliset kentät
    Select From List By Value
    ...    xpath=.//label[contains(text(), 'Turvavarustus')]/../select
    ...    2
    Seleniumlibrary.Input Text
    ...    xpath=.//label[contains(text(), 'Nimi')]/../input
    ...    Testi
