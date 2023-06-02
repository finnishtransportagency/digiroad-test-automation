
*** Settings ***
Documentation       Pageobject for obstacles (Opastustaulu)

*** Variables ***
${LocatorForDDM}                                css=#feature-attributes .form-group.editable select:first-of-type
${LocatorForDDM_Selection}                      css=select > option:nth-child(2)

${Opastustaulun_poisto}                        Haluatko varmasti poistaa Opastustaulun?

##### Opastustaulu ####
${FA_Opastustaulu_Poista_chkbx}                          id=removebox




*** Keywords ***

Opastustaulu_1  [arguments]  ${testipaikka}
    Log  Zoomataan testipaikkaan, tarkistetaan että kohteessa on jotain tietoa
    Siirry Testipaikkaan                        ${TL_Opastustaulu_RB}  ${testipaikka}
    Click Element At Coordinates                ${Kartta}  0  20
    Wait Until Element Is Visible               ${FA_otsikko}
    Click Element At Coordinates                ${Kartta}  0  -100
    Wait Until Element Is Not Visible           ${FA_otsikko}

    Log  zoomataan kauemmas ja varmistetaan, ettei Opastustaulua ole enää näkyvissä
    set selenium speed                          0.3
    Repeat Keyword  4 times                     click element  ${zoombar_minus}
    Set Selenium Speed                          ${DELAY}
    Odota sivun latautuminen
    Click Element At Coordinates                ${Kartta}  0  20
    Repeat Keyword  10 s                        Element Should Not Be Visible   ${FA_otsikko}

Opastustaulu_2  [arguments]  ${testipaikka}
    Log  Arvotaan Geometrian ulkopuolelle jääneet opastustaulut Listalta kohde ja tarkistetaan, että ID Täsmää.
    Vaihda Tietolaji                            ${TL_Opastustaulu_RB}
    Click Button                                Geometrian ulkopuolelle jääneet opastustaulut
    wait until element is visible               css=.content-box>header  20
    page should contain                         Kunnan omistama
    page should contain                         Yksityisen omistama
    page should contain                         Valtion omistama
    Arvo linkki korjattavien listalta
    wait until element is visible               ${tmp_ListLocator}
    ${tmp_linkID}=  Seleniumlibrary.get text                    ${tmp_ListLocator}
    ${tmp_linkID}=  remove string               ${tmp_linkID}   \#directionalTrafficSigns/
    click element                               ${tmp_ListLocator}
    Sleep  1 s
    Odota sivun latautuminen
    Valitse Kohde
    Log  varmistetaan että kartalta klikattu linkin ID täsmää listalta otettuun.
    element should contain                      ${FA_otsikko}  ${tmp_linkID}

Opastustaulu_3  [arguments]  ${testipaikka}
    Log  Valitaan opastustaulu ja muutetaan sen vaikutussuuntaa. Tietoja ei talleteta.
    Siirry Testipaikkaan                        ${TL_Opastustaulu_RB}  ${testipaikka}
    Click Element At Coordinates                ${Kartta}  0  20
    Wait Until Element Is Visible               ${FA_otsikko}
    Odota sivun latautuminen
    Siirry muokkaustilaan
    #click element at coordinates                ${kartta}   0   20
    wait until element is visible               ${FA_otsikko}
    click element                               css=#change-validity-direction
    Element should be enabled                   ${FA_footer_Tallenna}
    Click Button                                ${FA_footer_Peruuta}
    Odota sivun latautuminen

    Log  Siirretään Opastustaulua
    #Click Element At Coordinates                ${Kartta}  100  100
    Siirrä Kohde                                40   5
    Click element at coordinates                ${Kartta}  100  100
    Wait Until Element Is Visible               ${MuokkausVaroitus}
    Click Button                                Sulje
    click element                               ${FA_footer_Peruuta}

Opastustaulu_4  [arguments]  ${testipaikka}
    ${date}=  Get Current Date                  result_format=%d.%m.%Y
    Siirry Testipaikkaan                        ${TL_Opastustaulu_RB}  ${testipaikka}
    Odota sivun latautuminen

    Alusta Testipaikka
    Log  Luodaan uusi Opastustaulu, tarkistetaan Datetimen avulla luontipäivä.


    Luo Opastustaulu                            tyyppi
    Siirry Katselutilaan
    Click Element At Coordinates                ${Kartta}  0  20
    Wait Until Element Is Visible               ${FA_Lisätty_Järjestelmään}
    Element Should Contain                      ${FA_Lisätty_Järjestelmään}  ${date}
    Poista Kohde


#######################
## Sisäiset keywordit #
#######################

Tarkista Opastustaulun olemassaolo
# Käytetään uutta Opastustaulutä luotaessa - Tarkistaa jos Opastustaulu on jo olemassa ja poistaa sen.
    click element at coordinates                ${kartta}  20  -30
    ${passed}=  Run Keyword And Return Status   wait until element is visible    ${FA_otsikko}  timeout=3
    run keyword if  ${passed}  Poista Opastustaulu

Poista Opastustaulu
    click element                               ${FA_Opastustaulu_Poista_chkbx}
    click element                               ${FA_footer_Tallenna}
    wait until element is visible               ${MuokkausVaroitus}
    SeleniumLibrary.Element Text Should Be                      ${MuokkausVaroitus}     ${Opastustaulun_poisto}
    click element                               ${muokkausvaroitus_kyllä_btn}


Luo Opastustaulu  [arguments]  ${tyyppi}
    Log  Vaihtaa muokkaustilaan ja luo uuden Opastustaulun kartan osoittamaan kohtaan.
    Siirry muokkaustilaan
    Odota sivun latautuminen
    Tarkista Opastustaulun olemassaolo
    click element                               ${Muokkaustila_AddTool}
    click element at coordinates                ${kartta}  0  20
    wait until element is visible               ${FA_otsikko}
    Täytetään Opastustaulun kentät
    Click Element                               ${FA_footer_Tallenna}
    Wait Until Element Is Not Visible           ${Spinner_Overlay}

Täytetään Opastustaulun kentät
    # Tarkistetaan validoinnit ja ilmoitustekstit, pakolliset kentät
    click element                            css=#change-validity-direction
    Seleniumlibrary.input text              xpath=.//label[contains(text(), 'Teksti')]/../textarea    Testi