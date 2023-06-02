
*** Settings ***
Documentation       Pageobject for obstacles (Suojatie)

*** Variables ***
${LocatorForDDM}                                css=#feature-attributes .form-group.editable select:first-of-type
${LocatorForDDM_Selection}                      css=select > option:nth-child(2)

${Suojatien_poisto}                        Haluatko varmasti poistaa Suojatien?

##### Suojatiet ####
${FA_Suojatie_Poista_chkbx}                          id=removebox




*** Keywords ***

Suojatie_1  [arguments]  ${testipaikka}
    Log  Zoomataan testipaikkaan, tarkistetaan että kohteessa on jotain tietoa
    Vaihda Tietolaji                    ${TL_Suojatie_RB}
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

Suojatie_2  [arguments]  ${Lista}
    Log  Arvotaan Geometrian ulkopuolelle jääneet opastustaulut tai Laatuvirhe Listalta kohde ja tarkistetaan, että ID Täsmää.
    Vaihda Tietolaji                            ${TL_Suojatie_RB}

    Run Keyword If  '${Lista}'=='Geometrian'    Click Button  Geometrian ulkopuolelle jääneet suojatiet
    Run Keyword If  '${Lista}'=='Laatuvirhe'    Click Button  Laatuvirhelista

    wait until element is visible               css=.content-box>header  20
    page should contain                         Kunnan omistama
    page should contain                         Yksityisen omistama
    page should contain                         Valtion omistama
    Arvo linkki korjattavien listalta
    wait until element is visible               ${tmp_ListLocator}
    ${tmp_linkID}=  Seleniumlibrary.get text    ${tmp_ListLocator}

    ${tmp_linkID}=  Run Keyword If  '${Lista}'=='Geometrian'  remove string  ${tmp_linkID}  \#pedestrianCrossings/
    #...             ELSE IF         '${Lista}'=='Laatuvirhe'  remove string  ${tmp_linkID}  \#pedestrianCrossingsErrors/

    click element                               ${tmp_ListLocator}
    Odota sivun latautuminen
    Valitse Kohde
    Log  varmistetaan että kartalta klikattu linkin ID täsmää listalta otettuun.
    element should contain                      ${FA_otsikko}  ${tmp_linkID}

Suojatie_3  [arguments]  ${testipaikka}
    Log  Valitaan Suojatie ja siirretään sitä, siirtoa ei talleteta.
    Siirry Testipaikkaan                        ${TL_Suojatie_RB}  ${testipaikka}
    Odota sivun latautuminen
    Click Element At Coordinates                ${Kartta}  0  20
    Wait Until Element Is Visible               ${FA_otsikko}
    Siirry muokkaustilaan
    Siirrä Kohde                         40   5
    Click element at coordinates                ${Kartta}  100  100
    Wait Until Element Is Visible               ${MuokkausVaroitus}
    Click Button                                Sulje
    click element                               ${FA_footer_Peruuta}

Suojatie_4  [arguments]  ${testipaikka}
    ${date}=  Get Current Date                  result_format=%d.%m.%Y
    Siirry Testipaikkaan                        ${TL_Suojatie_RB}  ${testipaikka}
    Odota sivun latautuminen

    Alusta Testipaikka
    Log  Luodaan uusi suojatie, tarkistetaan Datetimen avulla luontipäivä.


    Luo Suojatie                                tyyppi
    Siirry Katselutilaan
    Click Element At Coordinates                ${Kartta}  0  20
    Wait Until Element Is Visible               ${FA_Lisätty_Järjestelmään}
    Element Should Contain                      ${FA_Lisätty_Järjestelmään}  ${date}
    Poista Kohde

#######################
## Sisäiset keywordit #
#######################

Siirrä Suojatie  [Arguments]  ${xKoord}  ${yKoord}
# Siirtää valittua Suojatie annetun offsetin verran, arvot positiivisia keskipisteestä oikealle ja alas
    Seleniumlibrary.mouse down                      css=[class='crosshair crosshair-center']
    Seleniumlibrary.drag and drop by offset         css=[class='crosshair crosshair-center']  ${xKoord}  ${yKoord}
    Seleniumlibrary.mouse up                        css=[class='crosshair crosshair-center']

Tarkista Suojatien olemassaolo
# Käytetään uutta Suojatietä luotaessa - Tarkistaa jos Suojatie on jo olemassa ja poistaa sen.
    click element at coordinates                ${kartta}  20  -30
    ${passed}=  Run Keyword And Return Status   wait until element is visible    ${FA_otsikko}  timeout=3
    run keyword if  ${passed}  Poista Suojatie

Poista Suojatie
    click element                               ${FA_Suojatie_Poista_chkbx}
    click element                               ${FA_footer_Tallenna}
    wait until element is visible               ${MuokkausVaroitus}
    SeleniumLibrary.Element Text Should Be                      ${MuokkausVaroitus}     ${Suojatien_poisto}
    click element                               ${muokkausvaroitus_kyllä_btn}


Luo Suojatie  [arguments]  ${tyyppi}
    Log  Vaihtaa muokkaustilaan ja luo uuden Suojatien kartan osoittamaan kohtaan.
    Siirry muokkaustilaan
    Odota sivun latautuminen
    Tarkista Suojatien olemassaolo
    click element                               ${Muokkaustila_AddTool}
    click element at coordinates                ${kartta}  0    20
    wait until element is visible               ${FA_otsikko}
    Click Element                               ${FA_footer_Tallenna}
    Wait Until Element Is Not Visible           ${Spinner_Overlay}
    Odota sivun latautuminen