
*** Settings ***
Documentation       Pageobject for Buststops (JoukkoLiikenteenPysäkki)
Resource    common_keywords.robot

*** Variables ***

${Pysakin_siirto_yli50m_popup}                  Pysäkkiä siirretty yli 50 metriä. Haluatko siirtää pysäkin uuteen sijaintiin?
${ELY_Pysakin_siirto_yli50m_popup}              Pysäkkiä siirretty yli 50 metriä. Siirron yhteydessä vanha pysäkki lakkautetaan ja luodaan uusi pysäkki.
${Pysäkin_poisto}                               Haluatko varmasti poistaa pysäkin?

####### Joukkoliikenteen pysäkki ###




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

#Kuvat
${kaukoliikennepysakki}                         kaukoliikennepysakki.png
${kaukoliikennepysakki_valittu}                 kaukoliikennepysakki_valittu.png
${pysakkipallura1}                               pysakki_pallura1.png
${pysakkipallura2}                               pysakki_pallura2.png

${kalenterin_nappi_eitietoa}                    kalenteri_eitietoa.png

*** Keywords ***

JLP_1  [arguments]  ${testipaikka}
    Log  Zoomataan testipaikkaan, tarkistetaan että kohteessa on jotain tietoa
    Siirry Testipaikkaan                        ${TL_Joukkoliikenteen_pysäkki_RB}  ${testipaikka}
    Odota sivun latautuminen
    Click Element At Coordinates                ${Kartta}  0  20
    Wait Until Element Is Visible               ${FA_otsikko}

    Log  zoomataan kauemmas ja varmistetaan, ettei Pysäkkiä ole enää näkyvissä
    set selenium speed                          0.3
    Repeat Keyword  4 times                     click element  ${zoombar_minus}
    Set Selenium Speed                          ${DELAY}
    Odota sivun latautuminen
    Click Element At Coordinates                ${Kartta}  0  20
    Repeat Keyword  10 s                        Page Should Not Contain   ${FA_otsikko}

JLP_2  [arguments]  ${testipaikka}
    Log  Avataan Terminaali Pysäkki, Tarkistetaan liitetyt pysäkit
    Siirry Testipaikkaan                        ${TL_Joukkoliikenteen_pysäkki_RB}  ${testipaikka}
    Zoomaa kartta                               5  5 m
    click element at coordinates                ${kartta}  0   20
    Wait Until Element Is Visible               ${FA_otsikko}
    Element should contain                      ${FA_otsikko}           Valtakunnallinen ID: 317801
    Element should contain                      ${FA_JLP_Liitetytpysäkit}  182055 Kamppi



JLP_3  [arguments]  ${testipaikka}  ${ELY}
    Siirry Testipaikkaan                        ${TL_Joukkoliikenteen_pysäkki_RB}  ${testipaikka}
    Log  Siirrytään muokkaustilaan, valitaan pysäkki ja siirretään sitä.
    Odota sivun latautuminen
    Siirry muokkaustilaan
    click element at coordinates                ${kartta}  20  -5
    wait until element is visible               ${FA_otsikko}
    Odota sivun latautuminen
    wanha Siirrä Pysäkkiä                       -300  -100
    wait until element is visible               ${MuokkausVaroitus}
    run keyword if  '${ELY}' == 'kyllä'         SeleniumLibrary.Element Text Should Be   ${MuokkausVaroitus}    ${ELY_Pysakin_siirto_yli50m_popup}
    ...  ELSE                                   SeleniumLibrary.Element Text Should Be   ${MuokkausVaroitus}    ${Pysakin_siirto_yli50m_popup}
    click element                               ${muokkausvaroitus_ei_btn}
    click element                               ${FA_footer_Peruuta}


JLP_4  [arguments]  ${testipaikka}  ${ylläpitäjä}
    ${date}=  Get Current Date                  result_format=%d.%m.%Y
    Siirry Testipaikkaan                        ${TL_Joukkoliikenteen_pysäkki_RB}  ${testipaikka}
    Odota sivun latautuminen

    Tarkista pysäkin olemassaolo
    Log  Luodaan uusi JLP, tarkistetaan Datetimen avulla luontipäivä.
    Vaihda Tietolaji                            ${TL_Esterakennelma_RB}
    Vaihda Tietolaji                            ${TL_Joukkoliikenteen_pysäkki_RB}
    Odota sivun latautuminen

    Luo pysäkki                                 ${ylläpitäjä}
    Odota sivun latautuminen
    Siirry Katselutilaan
    Vaihda Tietolaji                            ${TL_Esterakennelma_RB}
    Vaihda Tietolaji                            ${TL_Joukkoliikenteen_pysäkki_RB}
    Odota sivun latautuminen
    Click Element At Coordinates                ${Kartta}  0  20
    Wait Until Element Is Visible               ${FA_Lisätty_Järjestelmään}
    Element Should Contain                      ${FA_Lisätty_Järjestelmään}  ${date}
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

Siirrä Pysäkkiä  [Arguments]  ${xKoord}  ${yKoord}

    SikuliLibrary.Drag And Drop By Offset        ${pysakkipallura}  ${xKoord}  ${yKoord}


Wanha_Siirrä Pysäkkiä  [Arguments]  ${xKoord}  ${yKoord}
    #Siirtää valittua bussipysäkkiä annetun offsetin verran, arvot positiivisia keskipisteestä oikealle ja alas
    Seleniumlibrary.mouse down                      css=[class='crosshair crosshair-center']
    Seleniumlibrary.drag and drop by offset         css=[class='crosshair crosshair-center']  ${xKoord}  ${yKoord}
    Seleniumlibrary.mouse up                        css=[class='crosshair crosshair-center']

Tarkista pysäkin olemassaolo
# Käytetään uutta pysäkkiä luotaessa - Tarkistaa jos pysäkki on jo olemassa ja poistaa sen.
    click element at coordinates                ${kartta}  0  20
    ${passed}=  Run Keyword And Return Status   wait until element is visible    ${FA_otsikko}  timeout=3
    run keyword if  ${passed}  Poista Pysäkki

Poista Pysäkki
    #Pause Execution  Muokkaustila
    Siirry Muokkaustilaan
    Wait Until Element Is Visible               ${FA_JLP_Poista_chkbx}
    click element                               ${FA_JLP_Poista_chkbx}
    click element                               ${FA_footer_Tallenna}
    wait until element is visible               ${MuokkausVaroitus}
    SeleniumLibrary.Element Text Should Be                      ${MuokkausVaroitus}     ${Pysäkin_poisto}
    Wait until element is not visible           ${Map_popup}
    click element                               ${muokkausvaroitus_kyllä_btn}
    sleep                                       2 s
    Siirry Katselutilaan


Luo pysäkki  [arguments]  ${ylläpitäjä}
    Log  Vaihtaa muokkaustilaan ja luo uuden bussipysäkin kartan osoittamaan kohtaan.
    Siirry muokkaustilaan
    Odota sivun latautuminen
    #Tarkista pysäkin olemassaolo
    click element                               ${Muokkaustila_AddTool}
    click element at coordinates                ${kartta}  0   20
    wait until element is visible               ${FA_otsikko}
    Täytetään pysäkin kentät                    ${ylläpitäjä}
    Click Element                               ${FA_footer_Tallenna}
    Repeat Keyword  5 sec                       Wait Until Element Is Not Visible  ${Spinner_Overlay}
    #Click Button                                Kyllä



Täytetään pysäkin kentät  [arguments]  ${ylläpitäjä}
    # Tarkistetaan validoinnit ja ilmoitustekstit, pakolliset kentät: virtuaalipysäkki, pikavuoro yksinään
    Seleniumlibrary.Input text               css=#nimi_suomeksi    Testi
    click element                            xpath=.//label[contains(text(), 'Virtuaalipysäkki')]
    Run Keyword If  '${ylläpitäjä}'=='ELY'  select from list by value  xpath=.//label[contains(text(), 'Tietojen ylläpitäjä')]/../select  2
    Run Keyword If  '${ylläpitäjä}'=='Kunta'  select from list by value  xpath=.//label[contains(text(), 'Tietojen ylläpitäjä')]/../select  1