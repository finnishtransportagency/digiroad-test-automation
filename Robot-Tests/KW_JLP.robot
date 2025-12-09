
*** Settings ***
Documentation       Pageobject for Buststops (JoukkoLiikenteenPysäkki)
Resource    common_keywords.robot

*** Variables ***

${Pysakin_siirto_yli50m_popup}                  Pysäkkiä siirretty yli 50 metriä. Haluatko siirtää pysäkin uuteen sijaintiin?
${ELY_Pysakin_siirto_yli50m_popup}              Pysäkkiä siirretty yli 50 metriä. Siirron yhteydessä vanha pysäkki lakkautetaan ja luodaan uusi pysäkki.
${Pysäkin_poisto}                               Haluatko varmasti poistaa pysäkin?

##### Joukkoliikenteen pysäkit ####
${FA_JLP_Poista_chkbx}                          css=input#removebox
${FA_JLP_Nimi_fi}
${FA_JLP_Nimi_se}
${FA_JLP_Osoite_fi}
${FA_JLP_Osoite_se}
${FA_JLP_tietojen_ylläpitäjä}
${FA_JLP_tietojen_ylläpitäjän_tunnus}
${FA_JLP_Livi-Tunnus}
${FA_JLP_Matkustajatunnus}
${FA_JLP_MaastokoordinaattiX}
${FA_JLP_MaastokoordinaattiY}
${FA_JLP_MaastokoordinaattiZ}
${FA_JLP_Liikennöintisuunta}
${FA_JLP_Vaikutussuunta}
${FA_JLP_Liitetytpysäkit}                       css=.choice-terminal-group
${FA_viimeinen_voimassaolopvm}                  id=viimeinen_voimassaolopaiva
${FA_kalenterin_EI_tietoa_nappi}                xpath=.//*[@class="pika-single is-bound"] //*[@class="deselect-button"]

# Pysäkit - Geometrian ulkopuolelle jääneet pysäkit
${FA_Link_floating-stops}                        id=asset-work-list-link
${FA_Link_floating-stops_cont}                   Geometrian ulkopuolelle jääneet pysäkit

# Kuvat
${kaukoliikennepysakki}                         kaukoliikennepysakki.png
${kaukoliikennepysakki_valittu}                 kaukoliikennepysakki_valittu.png
${pysakkipallura1}                               pysakki_pallura1.png
${pysakkipallura2}                               pysakki_pallura2.png

${kalenterin_nappi_eitietoa}                    kalenteri_eitietoa.png

*** Keywords ***

JLP_1    [Arguments]    ${testipaikka}
    Log    Zoomataan testipaikkaan, tarkistetaan että kohteessa on jotain tietoa
    Siirry Testipaikkaan    ${TL_Joukkoliikenteen_pysäkki_RB}    ${testipaikka}
    Odota Sivun Latautuminen
    Click Element At Coordinates    ${Kartta}    0    20
    Wait Until Element Is Visible    ${FA_Lisätty_Järjestelmään}
    Log    zoomataan kauemmas ja varmistetaan, ettei Pysäkkiä ole enää näkyvissä
    Set Selenium Speed    0.3
    Repeat Keyword    4 times    Click Element    ${zoombar_minus}
    Set Selenium Speed    ${DELAY}
    Odota Sivun Latautuminen
    Click Element At Coordinates    ${Kartta}    0    20
    Repeat Keyword    10 s    Page Should Not Contain    ${FA_otsikko}


JLP_2    [Arguments]    ${testipaikka}
    Log    Avataan Terminaali Pysäkki, Tarkistetaan liitetyt pysäkit
    Siirry Testipaikkaan    ${TL_Joukkoliikenteen_pysäkki_RB}    ${testipaikka}
    Zoomaa kartta    5    5 m
    Click Element At Coordinates    ${kartta}    0    20
    Wait Until Element Is Visible    ${FA_otsikko}
    Element Should Contain    ${FA_otsikko}    Valtakunnallinen ID: 317801
    Element Should Contain    ${FA_JLP_Liitetytpysäkit}    182058 Kamppi


JLP_3    [Arguments]    ${testipaikka}    ${ELY}
    Siirry Testipaikkaan    ${TL_Joukkoliikenteen_pysäkki_RB}    ${testipaikka}
    Log    Siirrytään muokkaustilaan, valitaan pysäkki ja siirretään sitä.
    Odota Sivun Latautuminen
    Siirry Muokkaustilaan
    Click Element At Coordinates    ${kartta}    20    -5
    Wait Until Element Is Visible    ${FA_otsikko}
    Odota Sivun Latautuminen
    Wanha Siirrä Pysäkkiä    -300    -100
    Wait Until Element Is Visible    ${MuokkausVaroitus}
    Run Keyword If    '${ELY}' == 'kyllä'    SeleniumLibrary.Element Text Should Be     ${MuokkausVaroitus}    ${Pysakin_siirto_yli50m_popup}    #${ELY_Pysakin_siirto_yli50m_popup}
    ...  ELSE    SeleniumLibrary.Element Text Should Be     ${MuokkausVaroitus}    ${Pysakin_siirto_yli50m_popup}
    Click Element    ${muokkausvaroitus_ei_btn}
    Click Element    ${FA_footer_Peruuta}


JLP_4    [arguments]    ${testipaikka}    ${ylläpitäjä}
    ${date} =    Get Current Date    result_format=%d.%m.%Y
    Siirry Testipaikkaan    ${TL_Joukkoliikenteen_pysäkki_RB}    ${testipaikka}
    Odota Sivun Latautuminen
    Tarkista Pysäkin Olemassaolo
    Log    Luodaan uusi JLP, tarkistetaan Datetimen avulla luontipäivä.
    Vaihda Tietolaji    ${TL_Esterakennelma_RB}
    Vaihda Tietolaji    ${TL_Joukkoliikenteen_pysäkki_RB}
    Odota Sivun Latautuminen
    Luo Pysäkki    ${ylläpitäjä}
    Odota sivun latautuminen
    Siirry Katselutilaan
    Vaihda Tietolaji    ${TL_Esterakennelma_RB}
    Vaihda Tietolaji    ${TL_Joukkoliikenteen_pysäkki_RB}
    Odota Sivun Latautuminen
    Click Element At Coordinates    ${Kartta}  0  20
    Wait Until Element Is Visible    ${FA_Lisätty_Järjestelmään}
    Element Should Contain    ${FA_Lisätty_Järjestelmään}  ${date}
    Poista Pysäkki
    
    #FOR  ${var}  IN RANGE  10
        #For loopilla varmistetaan elementin avaaminen, 
    #    Click Element At Coordinates                ${Kartta}  0  20
    #    ${status}=  Run Keyword And Return Status  Wait Until Element Is Visible  ${FA_otsikko}  3 s
    #    Exit For Loop If  ${status}
    #    Run Keyword If  ${var} == 9  Fail  Ei Voitu Avata Kohteen Tietoja
    #END
    #Element Should Contain                      ${FA_Lisätty_Järjestelmään}  ${date}
    #Poista Pysäkki


#######################
## Sisäiset keywordit #
#######################

Siirrä Pysäkkiä  [Arguments]    ${pysakkipallura}    ${xKoord}    ${yKoord}
    SeleniumLibrary.Drag And Drop By Offset    ${pysakkipallura}    ${xKoord}    ${yKoord}


Wanha_Siirrä Pysäkkiä  [Arguments]    ${xKoord}    ${yKoord}
    # Siirtää valittua bussipysäkkiä annetun offsetin verran, arvot positiivisia keskipisteestä oikealle ja alas
    Seleniumlibrary.Mouse Down    css=[class='crosshair crosshair-center']
    Seleniumlibrary.Drag And Drop By Offset    css=[class='crosshair crosshair-center']    ${xKoord}    ${yKoord}
    Seleniumlibrary.Mouse Up    css=[class='crosshair crosshair-center']


Tarkista Pysäkin Olemassaolo
    # Käytetään uutta pysäkkiä luotaessa - Tarkistaa jos pysäkki on jo olemassa ja poistaa sen.
    Click Element At Coordinates     ${kartta}    0    20
    ${passed} =    Run Keyword And Return Status    Wait Until Element Is Visible    ${FA_otsikko}    timeout=3
    Run Keyword If    ${passed}    Poista Pysäkki


Poista Pysäkki
    # Pause Execution  Muokkaustila
    Siirry Muokkaustilaan
    Wait Until Element Is Visible    ${FA_JLP_Poista_chkbx}
    Click Element    ${FA_JLP_Poista_chkbx}
    Click Element    ${FA_footer_Tallenna}
    Wait Until Element Is Visible    ${MuokkausVaroitus}
    SeleniumLibrary.Element Text Should Be    ${MuokkausVaroitus}    ${Pysäkin_poisto}
    Wait Until Element Is Not Visible    ${Map_popup}
    Click Element    ${muokkausvaroitus_kyllä_btn}
    Sleep    2 s
    Siirry Katselutilaan


Luo Pysäkki    [Arguments]    ${ylläpitäjä}
    Log    Vaihtaa muokkaustilaan ja luo uuden bussipysäkin kartan osoittamaan kohtaan.
    Siirry Muokkaustilaan
    Odota Sivun Latautuminen
    # Tarkista pysäkin olemassaolo
    Click Element    ${Muokkaustila_AddTool}
    Click Center Of The Map And Wait For Locator    ${FA_otsikko}
    Täytetään Pysäkin Kentät    ${ylläpitäjä}
    Click Element    ${FA_footer_Tallenna}
    Repeat Keyword    5 sec    Wait Until Element Is Not Visible  ${Spinner_Overlay}
    #Click Button                                Kyllä


Täytetään Pysäkin Kentät    [Arguments]    ${ylläpitäjä}
    # Tarkistetaan validoinnit ja ilmoitustekstit, pakolliset kentät: virtuaalipysäkki, pikavuoro yksinään
    Seleniumlibrary.Input text    css=#nimi_suomeksi    Testi
    Click Element    xpath=.//label[contains(text(), 'Virtuaalipysäkki')]
    Run Keyword If    '${ylläpitäjä}'=='ELY'    Select From List By Value
    ...    xpath=.//label[contains(text(), 'Tietojen ylläpitäjä')]/../select    2
    Run Keyword If    '${ylläpitäjä}'=='Kunta'    Select From List By Value
    ...    xpath=.//label[contains(text(), 'Tietojen ylläpitäjä')]/../select    1
