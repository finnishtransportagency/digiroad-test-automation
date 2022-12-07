*** Settings ***
Documentation       Pageobject for User Interface testcases
# Resource            PO_MainPage.robot
Library    SeleniumLibrary

*** Variables ***
${LocatorForDDM}                                css=select.form-control
${LocatorForDDM_Selection}                      css=select.form-control > option:last-child
#${LocatorForDDM_Selection}                      css=div.form-group > select > option:last-child
${LocatorForCheckbox}                           css=#feature-attributes .checkbox:last-of-type input
${LocatorForCheckboxpp}                         xpath=.//label[text() = 'Poista']/input
${LocatorForButton}                             css=#feature-attributes .form-group.adjacent-link:last-of-type .new.btn.btn-new
${LocatorForRadiobuttons}                       css=#feature-attributes .radio [type="radio"]:not([checked=""])
${LocatorForEnabledButton}                      css=#feature-attributes .radio [value="enabled"]
${WidthInputLocator}                            css=.form-control.unit
#${string}

*** Keywords ***
UI_1
    Log     Skandinaaviset aakkoset näkyvät oikein
    wait until element is visible           ${Käyttöohje}
    element text should be                  ${Käyttöohje}           ${Käyttöohje_cont}

    Log     Tarkistetaan kartan spinner-taustakuva, joka näkyy karttaa ladatessa.
    ${temp}    Execute Javascript           return document.defaultView.getComputedStyle(document.getElementById("contentMap"),null)['background-image']
    Should Be Equal As Strings              ${temp}                 ${spinner_tausta}

UI_2
    Log     Käyttöohje aukeaa klikkaamalla Käyttöohje-nappulaa.
    wait until element is visible           ${Taustakartta}
    Click Element                           ${Käyttöohje}
    #    Get Window Titles
    Switch Window                           title=Käyttöohje
    wait until element is visible           id=md-title
    Title Should Be                         Käyttöohje
    Close Window
    Switch Window                           title=Digiroad
    Element should be visible               ${Käyttöohje}

UI_3
    Log    Syöttää XSSllä hakukenttään. Haku ei saa mennä siitä rikki.
    wait until element is visible           ${Hae_syotekentta}
    wait until element is not visible       ${Map_popup}
    Siirry muokkaustilaan
    wait until element is visible           ${Map_popup}
    wait until element is not visible       ${Map_popup}
    FOR  ${string}  IN  @{Haku_Muuttujat}
        SeleniumLibrary.Input Text              ${Hae_syotekentta}       ${string}
        Click Element                           ${Hae_btn}
        Wait until element is visible           ${Map_popup}
        Wait until keyword succeeds  5x  200ms  element text should be  ${Map_popup}  ${Hakuvirheilmoitus}
        Wait Until Element is not visible       ${Map_popup}
    END
    Siirry Katselutilaan
    


UI_4
    Log     Muokkaustilassa sovellus huomauttaa dialogilla käyttöoikeuksista kaikissa tietolajeissa.
    Log     Muokkaustilassa "Olet muokkaustilassa..."-teksti sovelluksen yläreunassa on korostettuna sinisellä.
    # For Looppi joka käy jokaisen tietolajin läpi, valitsee tietolajin ja painaa muokkaustilan päälle ja tarkistaa tekstin
    wait until element is visible           ${Taustakartta}
    wait until element is enabled           ${Taustakartta}
    Siirry muokkaustilaan
    element text should be                  ${Map_popup}                ${Muokkaustila_Popup_context}
    Log     Loopataan kaikki tietolajit läpi - klikataan aina kyseisen tietolajin muokkaustila päälle ja tarkistetaan ilmoitusteksti

    FOR    ${i}  IN  @{Tietolaji_radiobtns}
           vaihda tietolaji                    ${i}
           element text should be              ${Muokkaustila_ilmoitus}  ${Muokkaustila_ilmoitus_cont}
           wait until element is not visible   ${Map_popup}
    END

    #Taustavärin tarkistus tekemättä. ei osaa
    #    ${temp}    Execute Javascript           return window.getComputedStyle(document.getElementsByClassName("action-state"),null)['background-color']
    #    Should Be Equal As Strings              ${temp}             ${Muokkaustila_taustaväri}
    # getElementByClassName("action-state")  defaultView.


UI_5_ddm
    Log  Muokkaa monta elementtiä samanaikaisesti aluevalintatyökalun avulla
    wait until element is visible           ${Taustakartta}
    Paikanna osoite                     Brahenkatu 10, Turku
    Zoomaa kartta   5   20 m
    FOR    ${TL}  IN  @{Tietolajit_ddm}
      set test variable  ${koe}  ${TL}
      wait until element is visible       ${valitse tietolaji}
      Vaihda Tietolaji                    ${TL}
      Siirry muokkaustilaan
      Zoomaa edestakaisin
      Odota sivun latautuminen
      
      #"css=.${TL} .polygon" käytetään jotta selenium osaa valita HTML kaaviosta oikean .polygon työkalun
      Click element  css=.${TL} .polygon
      click element at coordinates        ${kartta}   100  100
      click element at coordinates        ${kartta}   100  -100
      click element at coordinates        ${kartta}   -100  -100
      set selenium speed  0
      Repeat Keyword  2 times  click element at coordinates        ${kartta}   -100  100
      set selenium speed  0.5
      wait until element is visible       ${LocatorForDDM}
      Tarkista muokkaustila ddm               ${LocatorForDDM}  ${EMPTY}
      Siirry Katselutilaan
    END


UI_5_radio_non-unit  [Arguments]  @{Tietolaji_lista}
    Log  UI_5 Tietolajit jotka muokattavissa radiobuttonin kautta.
    wait until element is visible           ${Taustakartta}
    Paikanna osoite                         Brahenkatu 10, Turku
    Zoomaa kartta   5   20 m
    Siirry muokkaustilaan
    Wait Until Element Is Not Visible      ${Map_popup}
    set test variable  ${koe}  -
    FOR    ${TL}  IN  @{Tietolaji_lista}
      wait until element is visible        ${valitse tietolaji}
      Vaihda Tietolaji                     ${TL}
      Run Keyword IF  '${TL}'=='${TL_Käpy_tietolaji_RB}'  Siirry muokkaustilaan
      Zoomaa edestakaisin
      Odota sivun latautuminen
      click element at coordinates         ${kartta}   0   20
      wait until element is visible        ${LocatorForRadiobuttons}
      Tarkista muokkaustila radio non-unit  ${LocatorForRadiobuttons}  ${TL}
    END

UI_5_radio_unit  [Arguments]  @{Tietolaji_lista}
    #sama testi kuin yllä, eri FA_locator tiedon syötölle
    Log  UI_5 Tietolajit jotka muokattavissa radiobuttonin kautta
    wait until element is visible           ${Taustakartta}
    Paikanna osoite                         Brahenkatu 10, Turku
    Zoomaa kartta   5   20 m
    Siirry muokkaustilaan
    set test variable  ${koe}  -
    FOR    ${TL}  IN  @{Tietolajit_radio_unit}
      wait until element is visible        ${valitse tietolaji}
      Vaihda Tietolaji                     ${TL}
      Zoomaa edestakaisin
      Odota sivun latautuminen
      click element at coordinates         ${kartta}   0   20
      wait until element is visible        ${LocatorForRadiobuttons}
      Tarkista muokkaustila radio unit              ${LocatorForRadiobuttons}  ${TL}
    END


UI_5_chkbx  [Arguments]  ${TL}  ${testipaikka}
    Testin Aloitus
    Log  UI_5 Tietolajit jotka muokattavissa checkboxin kautta
    # wait until element is visible           ${Taustakartta}
    # wait until element is visible           ${valitse tietolaji}
    # Vaihda Tietolaji                        ${TL}
     set test variable  ${koe}  -
    # Paikanna osoite                         ${testipaikka}
    # Zoomaa kartta                           5   20 m
    #Zoomaa edestakaisin

    #Siirry Testipaikkaan  ${TL}  ${testipaikka}

    wait until element is visible       ${valitse tietolaji}
    vaihda tietolaji                    ${TL}
    Paikanna osoite                     ${testipaikka}
    Zoomaa kartta                       5  20 m
    Odota sivun latautuminen

    Siirry Muokkaustilaan
    Wait Until Element Is Not Visible       ${Map_popup}
    click element at coordinates            ${kartta}  0  20
    #Run Keyword If                          '${TL}' == '${TL_Suojatie_RB}'  Siirry muokkaustilaan
    #   Scrollataan formin loppuun, jotta checkbox tulee näkyviin.
    #    pause execution
    wait until element is visible              ${FA_otsikko}
    # ${c} =   get element count      css=[class='form-group']
    # Run Keyword If                          ${c} == 0   click element at coordinates     ${kartta}   1   0
    Run Keyword If                          '${TL}' == '${TL_Joukkoliikenteen_pysäkki_RB}'
    ...  Execute Javascript                 var element = document.getElementById("feature-attributes-form");
    ...                                     element.scrollIntoView({block: "end"});
    Run Keyword If     '${TL}' == '${TL_Joukkoliikenteen_pysäkki_RB}'    set focus to element    css=#removebox
    Run Keyword If     '${TL}' == '${TL_Joukkoliikenteen_pysäkki_RB}'    wait until element is visible           ${LocatorForCheckboxpp}
    ...  ELSE     wait until element is visible           ${LocatorForCheckbox}
    # pause execution
    Run Keyword If     '${TL}' == '${TL_Rautatien_tasoristeys_RB}'    Tarkista Muokkaustila radio non-unit  ${LocatorForCheckbox}  ${TL}
    ...  ELSE     Tarkista muokkaustila radio non-unit  ${LocatorForCheckbox}  EMPTY
    Siirry Katselutilaan

UI_5_liikennevalo  [Arguments]  ${TL}  ${testipaikka}
    #Siirry Testipaikkaan  ${TL}  ${testipaikka}

    wait until element is visible       ${valitse tietolaji}
    Paikanna osoite                     ${testipaikka}
    Zoomaa kartta                       5  20 m
    Odota sivun latautuminen
    vaihda tietolaji                    ${TL}
    Odota sivun latautuminen

    click element at coordinates            ${kartta}   0   20
    Wait until element is visible           ${FA_otsikko}
    Siirry Muokkaustilaan
    Tarkista footer disabled
    Click Button                            Siirry muokkaamaan liikennevaloa
    Tarkista footer enabled
    SeleniumLibrary.Input Text              trafficLight_info-1  testi
    Click element                           ${FA_footer_Peruuta}
    Siirry Katselutilaan
 


UI_5_Button  [Arguments]  ${TL}  ${testipaikka}
    Log  UI_5 Tietolajit jotka muokattavissa napin kautta (kääntymisrajoitus)
    wait until element is visible           ${Taustakartta}
    set test variable  ${koe}  -
    wait until element is visible           ${valitse tietolaji}
    Vaihda Tietolaji                        ${TL}
    Paikanna osoite                         ${testipaikka}
    Zoomaa kartta                           5   20 m
    Odota sivun latautuminen
    click element at coordinates            ${kartta}   25   60
    Odota sivun latautuminen
    Siirry muokkaustilaan
    SeleniumLibrary.Wait Until Element Contains  ${FA_otsikko}  Linkin LINK ID  timeout=30 s

UI_6
    Log     Valitaan kerralla 2 kohdetta muokkaukseen
    wait until element is visible           ${Taustakartta}
    Vaihda Tietolaji                        ${TL_Suurin sallittu massa_RB}
    Paikanna osoite                         6711927, 240595
    Zoomaa kartta                           5   20 m
    Siirry muokkaustilaan
    click element at coordinates            ${kartta}   0   20
    Paikanna osoite                         6711929, 240618
    click_element_and_press_control_at_coordinates   ${kartta}   0   20
    wait until element is visible           ${mass_update_modal_otsikko}
    click element                           ${mass_update_modal_peruuta}


#######################
## Sisäiset keywordit #
#######################

Tarkista header disabled
    odota sivun latautuminen
    element should be disabled          ${FA_header_Tallenna}
    

Tarkista header enabled
    Odota sivun latautuminen
    element should be enabled           ${FA_header_Tallenna}
    element should be enabled           ${FA_header_Peruuta}

Tarkista footer disabled
    Odota sivun latautuminen
    element should be disabled          ${FA_footer_Tallenna}

Tarkista footer enabled
    odota sivun latautuminen
    element should be enabled           ${FA_footer_Tallenna}
    element should be enabled           ${FA_footer_Peruuta}

Tarkista muokkaustila radio non-unit  [Arguments]      ${locator_TBchanged}  ${TL}
    Log     Muokkaustilan muutosten ilmoituslaatikon tarkistus kaikille tietolajeille.
    Log     Tarkistetaan, että tallennusnapit ovat disabloidut ensin, tehdään muutos ja tarkistetaan, että kaikki napit ovat enabloitu ja verifioidaan varoitusikkuna

    Tarkista footer disabled

    #Run Keyword If                      '${locator_TBchanged}' == '${LocatorForDDM}'              DDM_tietolajit
    Run Keyword If                      '${locator_TBchanged}' in '${LocatorForCheckbox} ${LocatorForRadiobuttons} ${LocatorForButton}'      click element   ${locator_TBchanged}
    #Run Keyword If                      '${TL}' == '${TL_Liikennemäärä_RB}'                       SeleniumLibrary.Input text        ${FA_Liikennemäärä_Rajoitus}      12


    ${visible}=  Run Keyword And Return Status  SeleniumLibrary.Element Should Be Visible  ${FA_locator_textinput}
    Run Keyword If  '${Visible}'=='True'  SeleniumLibrary.Input text        ${FA_locator_textinput}  12
    Run Keyword If  '${TL}'=='${TL_Leveys_RB}'  SeleniumLibrary.Input text  ${WidthInputLocator}  100
    Run Keyword If  '${TL}'=='${TL_Tietyöt_RB}'  Aseta Päivämäärä

    
    Tarkista footer enabled
    wait until element is not visible   ${Map_popup}
    log  ${koe}
    run keyword if   '${koe}' == '${TL_Tielinkki_RB}'  select radio button  ${Tielinkin_RB_ryhmä}  ${TL_Hallinnollinen luokka_RB}
    click element                       ${FA_footer_Peruuta}
    run keyword if   '${koe}' == '${TL_Tielinkki_RB}'  select radio button                 ${Tielinkin_RB_ryhmä}           ${TL_Toiminnallinen luokka_RB}

Tarkista muokkaustila radio unit  [Arguments]      ${locator_TBchanged}  ${TL}
    Log     Muokkaustilan muutosten ilmoituslaatikon tarkistus kaikille tietolajeille.
    Log     Tarkistetaan, että tallennusnapit ovat disabloidut ensin, tehdään muutos ja tarkistetaan, että kaikki napit ovat enabloitu ja verifioidaan varoitusikkuna
    Tarkista footer disabled

    #Run Keyword If                      '${locator_TBchanged}' == '${LocatorForDDM}'              DDM_tietolajit
    Run Keyword If                      '${locator_TBchanged}' in '${LocatorForCheckbox} ${LocatorForRadiobuttons} ${LocatorForButton}'      click element   ${locator_TBchanged}
    #Run Keyword If                      '${TL}' == '${TL_Liikennemäärä_RB}'                       SeleniumLibrary.Input text        ${FA_Liikennemäärä_Rajoitus}      12

    ${visible}=  Run Keyword And Return Status  SeleniumLibrary.Element Should Be Visible  ${FA_locator_unitinput}
    Run Keyword If  '${Visible}'=='True' and '${TL}'!='${TL_suurin_sallittu_pituus_RB}'  SeleniumLibrary.Input text        ${FA_locator_unitinput}  12
    Run Keyword If  '${TL}'=='${TL_suurin_sallittu_pituus_RB}'  Click Element   ${LocatorForEnabledButton}
    Run Keyword If  '${TL}'=='${TL_suurin_sallittu_pituus_RB}'  SeleniumLibrary.Input text  ${WidthInputLocator}  100
    #Run Keyword If  '${TL}'=='${TL_Tietyöt_RB}'  Aseta Päivämäärä    
    
    Tarkista footer enabled
    wait until element is not visible   ${Map_popup}
    log  ${koe}
    run keyword if   '${koe}' == '${TL_Tielinkki_RB}'  select radio button  ${Tielinkin_RB_ryhmä}  ${TL_Hallinnollinen luokka_RB}
    click element                       ${FA_footer_Peruuta}
    run keyword if   '${koe}' == '${TL_Tielinkki_RB}'  select radio button                 ${Tielinkin_RB_ryhmä}           ${TL_Toiminnallinen luokka_RB}

Tarkista muokkaustila ddm  [Arguments]      ${locator_TBchanged}  ${TL}
    Log     Muokkaustilan muutosten ilmoituslaatikon tarkistus kaikille tietolajeille.
    Log     Tarkistetaan, että tallennusnapit ovat disabloidut ensin, tehdään muutos ja tarkistetaan, että kaikki napit ovat enabloitu ja verifioidaan varoitusikkuna

    Run Keyword If  '${TL}'=='${TL_Nopeusrajoitus_RB}'  Tarkista header disabled

    Run Keyword If                      '${locator_TBchanged}' == '${LocatorForDDM}'              DDM_tietolajit
    Run Keyword If                      '${locator_TBchanged}' in '${LocatorForCheckbox} ${LocatorForRadiobuttons} ${LocatorForButton}'      click element   ${locator_TBchanged} 

    Tarkista header enabled
    wait until element is not visible   ${Map_popup}
    log  ${koe}
    run keyword if   '${koe}' == '${TL_Tielinkki_RB}'  select radio button  ${Tielinkin_RB_ryhmä}  ${TL_Hallinnollinen luokka_RB}
    click element                       ${FA_header_Peruuta}
    run keyword if   '${koe}' == '${TL_Tielinkki_RB}'  select radio button                 ${Tielinkin_RB_ryhmä}           ${TL_Toiminnallinen luokka_RB}



DDM_tietolajit
    #klikataan lista auki
    click element                       ${LocatorForDDM}
    #valitaan listalta vaihtoehto, jota ei ole valittu
    click element                       ${LocatorForDDM_Selection}

Aseta Päivämäärä
    SeleniumLibrary.Input Text  ${FA_locator_PVM_start}  1.1.2030
    SeleniumLibrary.Input Text  ${FA_locator_PVM_end}  2.1.2030
    SeleniumLibrary.Input Text  ${FA_locator_PVM_start}  1.1.2030


