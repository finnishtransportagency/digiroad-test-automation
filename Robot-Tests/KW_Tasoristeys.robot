
*** Settings ***
Documentation       Pageobject for obstacles (Tasoristeys)

*** Variables ***
${LocatorForDDM}                                css=#feature-attributes .form-group.editable select:first-of-type
${LocatorForDDM_Selection}                      css=select > option:nth-child(2)

${Tasoristeyksen_poisto}                        Haluatko varmasti poistaa tasoristeyksen?

##### Rautatien tasoristeykset ####
${FA_Tasoristeys_Poista_chkbx}                          id=removebox
${FA_Tasoristeys_turvavarustus}                         css=.form > div:nth-child(5) > p




*** Keywords ***

Tasoristeys_1  [arguments]  ${testipaikka}
    Log  Zoomataan testipaikkaan, tarkistetaan että kohteessa on jotain tietoa
    Vaihda Tietolaji                    ${TL_Rautatien_tasoristeys_RB}
    Paikanna osoite                     ${testipaikka}
    Odota sivun latautuminen

    Click Element At Coordinates        ${Kartta}  0  20
    Wait Until Element Is Visible       ${FA_otsikko}
    Click Element At Coordinates        ${Kartta}  0  -100
    Wait Until Element Is Not Visible   ${FA_otsikko}

    Log  zoomataan kauemmas ja varmistetaan, ettei esterakennelma ole enää näkyvissä
    Click Element                       ${zoombar_minus}
    Odota sivun latautuminen
    Wait Until Element Is Not Visible   ${Map_popup}
    Click Element At Coordinates        ${Kartta}  0  20
    Repeat Keyword  10 s                Element Should Not Be Visible   ${FA_otsikko}

Tasoristeys_2  #[arguments]  ${testipaikka}
    Log  Arvotaan Geometrian ulkopuolelle jääneet tasoristeykset listalta kohde ja tarkistetaan, että kohteen ID Täsmää.
    Vaihda Tietolaji                            ${TL_Rautatien_tasoristeys_RB}
    Click Button                                Geometrian ulkopuolelle jääneet tasoristeykset
    
    wait until element is visible               css=.content-box>header  20
    page should contain                         Kunnan omistama
    page should contain                         Yksityisen omistama
    page should contain                         Valtion omistama

    Arvo linkki korjattavien listalta
    wait until element is visible               ${tmp_ListLocator}
    ${tmp_linkID}=  Seleniumlibrary.get text    ${tmp_ListLocator}
    ${tmp_linkID}=  remove string  ${tmp_linkID}  \#railwayCrossings/

    click element                               ${tmp_ListLocator}
    Odota sivun latautuminen
    Valitse Kohde
    element should contain                      ${FA_otsikko}  ${tmp_linkID}

Tasoristeys_3  [arguments]  ${testipaikka}  ${Turvavarustus}
    Log  Siirrytään muokkaustilaan, valitaan esterakennelma ja muokataan sitä.
    wait until element is visible               ${valitse tietolaji}
    Siirry Testipaikkaan                        ${TL_Rautatien_tasoristeys_RB}  ${testipaikka}
    Valitse Esterakennelma
    Page Should Contain                         ${Turvavarustus}

    Log  Siirretään setettä ja tarkistetaan, että siirron jälkeen tulee muokkausvaroitus.
    Siirry muokkaustilaan
    Siirrä Kohde                                -10  -100
    Click element at coordinates                ${Kartta}  100  100
    Wait Until Element Is Visible               ${Muokkausvaroitus}
    Click Button                                ${Muokkausvaroitus_Sulje_btn}
    click element                               ${FA_footer_Peruuta}
    #Sleep  5 s

    Log  Tarkistetaan, että ominaisuustietojen muokkauksesta tulee muokkausvaroitus.
    #click element at coordinates                ${kartta}   0   20
    #wait until element is visible               ${FA_otsikko}
    #Otettu pois koska ei toimi luotettavasti CI ympäristössä
    #DDM_tietolajit
    #Click element at coordinates                ${Kartta}  100  100
    #Wait Until Element Is Visible               ${Muokkausvaroitus}
    #Click Button                                ${Muokkausvaroitus_Sulje_btn}
    #click element                               ${FA_footer_Peruuta}

Tasoristeys_4  [arguments]  ${testipaikka}
    ${date}=  Get Current Date                  result_format=%d.%m.%Y
    Siirry Testipaikkaan                        ${TL_Rautatien_tasoristeys_RB}  ${testipaikka}
    Odota sivun latautuminen

    Alusta Testipaikka
    Log  Luodaan uusi este, tarkistetaan Datetimen avulla luontipäivä.


    Luo tasoristeys                             tyyppi
    Siirry Katselutilaan
    Click Element At Coordinates                ${Kartta}  0  20
    Wait Until Element Is Visible               ${FA_Lisätty_Järjestelmään}
    Element Should Contain                      ${FA_Lisätty_Järjestelmään}  ${date}
    Poista Kohde


#######################
## Sisäiset keywordit #
#######################

Siirrä tasoristeys  [Arguments]  ${xKoord}  ${yKoord}
    #Siirtää valittua tasoristeys annetun offsetin verran, arvot positiivisia keskipisteestä oikealle ja alas
    Seleniumlibrary.mouse down                      css=[class='crosshair crosshair-center']
    Seleniumlibrary.drag and drop by offset         css=[class='crosshair crosshair-center']  ${xKoord}  ${yKoord}
    Seleniumlibrary.mouse up                        css=[class='crosshair crosshair-center']

Tarkista tasoristeyksen olemassaolo
    #Käytetään uutta tasoristeystä luotaessa - Tarkistaa jos tasoristeys on jo olemassa ja poistaa sen.
    click element at coordinates                ${kartta}  20  -30
    ${passed}=  Run Keyword And Return Status   wait until element is visible    ${FA_otsikko}  timeout=3
    run keyword if  ${passed}  Poista tasoristeys

Poista tasoristeys
    click element                               ${FA_Tasoristeys_Poista_chkbx}
    click element                               ${FA_footer_Tallenna}
    wait until element is visible               ${MuokkausVaroitus}
    element text should be                      ${MuokkausVaroitus}     ${tasoristeyksen_poisto}
    click element                               ${muokkausvaroitus_kyllä_btn}


Luo tasoristeys  [arguments]  ${tyyppi}
    Log  Vaihtaa muokkaustilaan ja luo uuden tasoristeyksen kartan osoittamaan kohtaan.
    Siirry muokkaustilaan
    Odota sivun latautuminen
    Tarkista tasoristeyksen olemassaolo
    click element                               ${Muokkaustila_AddTool}
    click element at coordinates                ${kartta}  0  20
    wait until element is visible               ${FA_otsikko}
    Täytetään tasoristeyksen kentät
    Click Element                               ${FA_footer_Tallenna}
    Wait Until Element Is Not Visible           ${Spinner_Overlay}

Täytetään tasoristeyksen kentät
    #Tarkistetaan validoinnit ja ilmoitustekstit, pakolliset kentät
    select from list by value                xpath=.//label[contains(text(), 'Turvavarustus')]/../select   2
    Seleniumlibrary.input text              xpath=.//label[contains(text(), 'Nimi')]/../input    Testi