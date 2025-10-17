
*** Settings ***
Documentation       Pageobject for obstacles (Opastustaulu)
Resource    common_keywords.robot

*** Variables ***
${LocatorForDDM}                                css=#feature-attributes .form-group.editable select:first-of-type
${LocatorForDDM_Selection}                      css=select > option:nth-child(2)
${Opastustaulun_poisto}                         Haluatko varmasti poistaa Opastustaulun?
##### Opastustaulu ####
${FA_Opastustaulu_Poista_chkbx}                          id=removebox


*** Keywords ***
Opastustaulu_1    [Arguments]    ${testipaikka}
    Log    Zoomataan testipaikkaan, tarkistetaan että kohteessa on jotain tietoa
    Siirry Testipaikkaan    ${TL_Opastustaulu_RB}    ${testipaikka}
    Click Center Of The Map And Wait For Locator    ${FA_otsikko}
    Click Element At Coordinates    ${Kartta}  0  -100
    Wait Until Element Is Not Visible    ${FA_otsikko}
    Log  zoomataan kauemmas ja varmistetaan, ettei Opastustaulua ole enää näkyvissä
    Set Selenium Speed    0.3
    Repeat Keyword    4 times    Click Element    ${zoombar_minus}
    Set Selenium Speed    ${DELAY}
    Odota Sivun Latautuminen
    Click Element At Coordinates    ${Kartta}  0  20
    Repeat Keyword    10 s    Element Should Not Be Visible    ${FA_otsikko}


Opastustaulu_2    [Arguments]    ${testipaikka}
    Log    Arvotaan Geometrian ulkopuolelle jääneet opastustaulut Listalta kohde ja tarkistetaan, että ID Täsmää.
    Vaihda Tietolaji    ${TL_Opastustaulu_RB}
    Click Button    Geometrian ulkopuolelle jääneet opastustaulut
    Wait Until Element Is Visible    css=.content-box>header  20
    Page Should Contain    Kunnan omistama
    Page Should Contain    Yksityisen omistama
    Page Should Contain    Valtion omistama
    Arvo Linkki Korjattavien Listalta
    Wait Until Element Is Visible    ${tmp_ListLocator}
    ${tmp_linkID} =    Seleniumlibrary.get text    ${tmp_ListLocator}
    ${tmp_linkID} =  Remove String    ${tmp_linkID}    \#directionalTrafficSigns/
    Click Element    ${tmp_ListLocator}
    Sleep    1 s
    Odota Sivun Latautuminen
    Valitse Kohde
    Log    varmistetaan että kartalta klikattu linkin ID täsmää listalta otettuun.
    Element Should Contain    ${FA_otsikko}    ${tmp_linkID}


Opastustaulu_3    [Arguments]    ${testipaikka}
    Log    Valitaan opastustaulu ja muutetaan sen vaikutussuuntaa. Tietoja ei talleteta.
    Siirry Testipaikkaan    ${TL_Opastustaulu_RB}    ${testipaikka}
    Click Center Of The Map And Wait For Locator    ${FA_otsikko}
    Odota Sivun Latautuminen
    Siirry Muokkaustilaan
    #click element at coordinates                ${kartta}   0   20
    Wait Until Element Is Visible    ${FA_otsikko}
    Click Element    css=#change-validity-direction
    Element Should Be Enabled    ${FA_footer_Tallenna}
    Click Button    ${FA_footer_Peruuta}
    Odota Sivun Latautuminen
    Log    Siirretään Opastustaulua
    #Click Element At Coordinates                ${Kartta}  100  100
    Siirrä Kohde    40   5
    Click Element At Coordinates    ${Kartta}    100    100
    Wait Until Element Is Visible    ${MuokkausVaroitus}
    Click Button    Sulje
    Click Element    ${FA_footer_Peruuta}


Opastustaulu_4    [Arguments]    ${testipaikka}
    ${date} =    Get Current Date    result_format=%d.%m.%Y
    Siirry Testipaikkaan    ${TL_Opastustaulu_RB}    ${testipaikka}
    Odota Sivun Latautuminen
    Alusta Testipaikka
    Log  Luodaan uusi Opastustaulu, tarkistetaan Datetimen avulla luontipäivä.
    Luo Opastustaulu    tyyppi
    Siirry Katselutilaan
    Click Center Of The Map And Wait For Locator    ${FA_Lisätty_Järjestelmään}
    Element Should Contain    ${FA_Lisätty_Järjestelmään}    ${date}
    Poista Kohde


#######################
## Sisäiset keywordit #
#######################

Tarkista Opastustaulun olemassaolo
    # Käytetään uutta Opastustaulutä luotaessa - Tarkistaa jos Opastustaulu on jo olemassa ja poistaa sen.
    Click Element At Coordinates    ${kartta}  20  -30
    ${passed} =    Run Keyword And Return Status
    ...    Wait Until Element Is Visible    ${FA_otsikko}    timeout=3
    Run Keyword If    ${passed}    Poista Opastustaulu


Poista Opastustaulu
    Click Element    ${FA_Opastustaulu_Poista_chkbx}
    Click Element    ${FA_footer_Tallenna}
    Wait Until Element Is Visible    ${MuokkausVaroitus}
    SeleniumLibrary.Element Text Should Be    ${MuokkausVaroitus}    ${Opastustaulun_poisto}
    Click Element    ${muokkausvaroitus_kyllä_btn}


Luo Opastustaulu    [Arguments]    ${tyyppi}
    Log    Vaihtaa muokkaustilaan ja luo uuden Opastustaulun kartan osoittamaan kohtaan.
    Siirry Muokkaustilaan
    Odota Sivun Latautuminen
    Tarkista Opastustaulun Olemassaolo
    Click Element    ${Muokkaustila_AddTool}
    Click Center Of The Map And Wait For Locator    ${FA_otsikko}
    Täytetään Opastustaulun Kentät
    Tallenna Muutokset


Täytetään Opastustaulun kentät
    # Tarkistetaan validoinnit ja ilmoitustekstit, pakolliset kentät
    Click Element    css=#change-validity-direction
    Seleniumlibrary.Input Text    xpath=.//label[contains(text(), 'Teksti')]/../textarea    Testi
