
*** Settings ***
Documentation       Pageobject for roadlinks
Resource            common_keywords.robot


*** Variables ***
## Tielinkki ##
# FA= Feature Attributes
${FA_tielinkki_toiminnallinen_luokka}           css=.form-control.functional-class
${FA_tielinkki_valittu_toiminnallinenluokka}    css=.form-control.functional-class [selected=""]
#${FA_tielinkin_TL_1}                            css=.form-control.functional-class option[value='1']
#${FA_tielinkin_TL_2}                            css=.form-control.functional-class option[value='2']
#${FA_tielinkin_TL_3}                            css=.form-control.functional-class option[value='3']
#${FA_tielinkin_TL_4}                            css=.form-control.functional-class option[value='4']
#${FA_tielinkin_TL_5}                            css=.form-control.functional-class option[value='5']
${FA_tielinkki_hallinnollinen luokka}           css=.form > div:nth-child(4) > p:nth-child(2)
${FA_tielinkki_Toiminnallinen luokka}           css=.form > div:nth-child(4) > p:nth-child(5)
${FA_tielinkki_TL_lista}                        css=#feature-attributes .form-group.editable .form-control.functional-class
#${FA_tielinkki_TL_valinta1}                     xpath=.//*[@id='feature-attributes']/div/div/div[4]/select[1]/option[2]
#${FA_tielinkki_TL_valinta2}                     xpath=.//*[@id='feature-attributes']/div/div/div[4]/select[1]/option[3]
${FA_tielinkki_Liikennevirta}                   css=#feature-attributes .form-group.editable .form-control.functional-class+label+p
${FA_liikennevirta_MolempiinSuuntiin}           BothDirections
${FA_liikennevirta_Digit_vastaan}               AgainstDigitizing
${FA_liikennevirta_Digit_suuntaan}              TowardsDigitizing
${Digitointisuuntaa vastaan}                    Digitointisuuntaa vastaan
${Digitointisuuntaan}                           Digitointisuuntaan
${Molempiin suuntiin}                           Molempiin suuntiin
${FA_tielinkki_Liikennevirta_lista}             css=#feature-attributes .form-control.traffic-direction
#${FA_tielinkki_Liikennevirta_molempiin}         xpath=.//*[@id='feature-attributes']/div/div/div[4]/select[2]/option[2]
#${FA_tielinkki_Liikennevirta_dig_vastaan}       xpath=.//*[@id='feature-attributes']/div/div/div[4]/select[2]/option[3]
#${FA_tielinkki_Liikennevirta_dig_suuntaan}      xpath=.//*[@id='feature-attributes']/div/div/div[4]/select[2]/option[4]
${FA_tielinkki_tielinkintyyppi_lista}           css=#feature-attributes .form-control.link-types
${FA_tielinkki_tielinkintyyppi}                 css=#feature-attributes .form-group.editable .form-control.traffic-direction+label+p
${FA_tielinkki_valittu_tielinkintyyppi}         css=.form-control.link-types [selected=""]
${FA_tielinkki_tielinkintyyppi_lista}           xpath=.//*[@id='feature-attributes']/div/div/div[4]/select[3]
${FA_tielinkki_tielinkintyyppi_motari}          xpath=.//*[@id='feature-attributes']/div/div/div[4]/select[3]/option[2]
${FA_tielinkki_silta,alikulku tai tunneli}      css=.form > div:nth-child(5) > p
${FA_tielinkki_Kuntanumero}                     xpath=.//*[@id='feature-attributes']/div/div/div[6]/p
${FA_tielinkki_Tien_nimi_Suomi}                 xpath=.//*[@id='feature-attributes']/div/div/div[7]/p
${FA_tielinkki_Tien_nimi_Ruotsi}                xpath=.//*[@id='feature-attributes']/div/div/div[8]/p
${FA_tielinkki_Tien_nimi_Saame}                 xpath=.//*[@id='feature-attributes']/div/div/div[9]/p
${FA_tielinkki_Tien_numero}                     xpath=.//*[@id='feature-attributes']/div/div/div[10]/p
${FA_tielinkki_Tieosanumero}                    xpath=.//*[@id='feature-attributes']/div/div/div[11]/p
${FA_tielinkki_Osoitenumerot oikealla}          xpath=.//*[@id='feature-attributes']/div/div/div[12]/p
${FA_tielinkki_Osoitenumerot vasemmalla}        xpath=.//*[@id='feature-attributes']/div/div/div[13]/p
${FA_tielinkki_MML_ID}                          xpath=.//*[@id='feature-attributes']//*[@class='form-group'][last()-1]/p


${Tietolaji_otsikko}                            xpath=.//*[@id='map-tools']/div/div[3]/div[2]/div/header
#Radiobuttons
${TL_Toiminnallinen luokka_RB}                  functional-class
# css=.panel-section.panel-legend.road-link-legend>.radio [value="functional-class"]
${TL_Tielinkin tyyppi_RB}                       link-type
#css=.panel-section.panel-legend.road-link-legend>.radio [value="link-type"]
${TL_Hallinnollinen luokka_RB}                  administrative-class
#css=.panel-section.panel-legend.road-link-legend>.radio [value="administrative-class"]
${TL_Silta, alikulku tai tunneli_RB}            vertical-level
#css=.panel-section.panel-legend.road-link-legend>.radio [value="vertical-level"]
${Tielinkin_RB_ryhmä}                           dataset
#toimii kaikilla, paitsi hallinnollisella luokalla:
${Tielinkin_legenda_boksi}                      css=.panel-section.panel-legend.linear-asset-legend.functional-class-legend
#Toimii kaikilla tielinkin legendoilla:
${Tielinkin_legenda_boksi_kaikki}               css=.legend-container
# vanha:  .panel-section.panel-legend:last-of-type

#Legenda
${TL_Luokka 1}                                  symbol linear linear-asset-1
${TL_Luokka 2}                                  symbol linear linear-asset-2
${TL_Luokka 3}                                  symbol linear linear-asset-3
${TL_Luokka 4}                                  symbol linear linear-asset-4
${TL_Luokka 5}                                  symbol linear linear-asset-5
#Luokka 6: Muu yksityistie
${TL_Luokka 6}                                  symbol linear linear-asset-6
#Luokka 7: Ajopolku
${TL_Luokka 7}                                  symbol linear linear-asset-7
#Luokka 8: Kevyen liikenteen väylä
${TL_Luokka 8}                                  symbol linear linear-asset-8

# Tielinkin luokat:
# Luokka 1 - Punainen
# Luokka 2 - punainen ja katkoviiva
# Luokka 3 - pinkki
# Luokka 4 - pinkki ja katkoviiva
# Luokka 5 - sininen
# Luokka 6 - sininen ja katkoviiva
# Luokka 7 - harmaa
# Luokka 8 - harmaa ja katkoviiva

${KarttaPallurat}                               css=image[id^=OpenLayers_Geometry_Point_][stroke-opacity="1"][fill-opacity="1"]
${liikennevirran_suuntanuoli}                   css=image[id^=OpenLayers_Geometry_Point_][stroke-opacity="0.7"][fill-opacity="1"]
${liikennevirran_suuntanuoli_pun}               css=image[id^=OpenLayers_Geometry_Point_][stroke-opacity="0.7"][fill-opacity="1"][stroke="#f00"]


#Tielinkki - Korjattavien linkkien lista
${FA_Link_incomplete-links}                     id=incomplete-links-link
${FA_tielinkki_korjattavien_eka_linkki}         xpath=(.//*[@id='work-list']//*[@class='work-list-item'])[1]


# Tielinkin luokkien radiobuttonit (listasta puuttuu Toiminnallinen luokka, joka on oletuksena valittu)
@{Tielinkin_luokat_RB}  ${TL_Toiminnallinen luokka_RB}  ${TL_Tielinkin tyyppi_RB}  ${TL_Hallinnollinen luokka_RB}  ${TL_Silta, alikulku tai tunneli_RB}


${Tielinkin palluraaineistot}    ${TL_Palvelupiste_RB} ${TL_Opastustaulu_RB} ${TL_Esterakennelma_RB} ${TL_Rautatien tasoristeys_RB} ${TL_Liikennevalo_RB}
@{Tielinkin_RB_tekstit}     Toiminnallinen luokka  Tielinkin tyyppi  Hallinnollinen luokka  Silta, alikulku tai tunneli
@{tielinkin_formin_otsikot}  Linkin ID:  Hallinnollinen luokka   Toiminnallinen luokka   Liikennevirran suunta   Tielinkin tyyppi   Silta, alikulku tai tunneli
...  Kuntanumero   Tiennimi (Suomi)   Tiennimi (Ruotsi)   Tiennimi (Pohjoissaame)    Tiennimi (Inarinsaame)    Tiennimi (Koltansaame)   Tienumero   Tieosanumero   Osoitenumerot oikealla   Osoitenumerot vasemmalla   MML ID
#Linkin ID

## KUVAT
${tielinkkinakyma_turku}                    turku1_50000.png
#${tielinkki_img}                            tielinkki_sin.png

${korjattavien_tsekkaus}=    Run Keyword And Return Status    Page Should Contain    css=#work-list > div > div > div > div > div

*** Keywords ***
Tielinkit_1
    Log  Avataan selain, vaihdetaan tietolajiksi tielinkki
    wait until element is visible       ${valitse tietolaji}
    vaihda tietolaji                    ${TL_Tielinkki_RB}
    Log  varmistetaan että oletuksena toiminallinen luokka
    Radio Button Should Be Set To       ${Tielinkin_RB_ryhmä}       ${TL_Toiminnallinen luokka_RB}
    Log  vaihdetaan oletuksesta pois
    select radio button                 ${Tielinkin_RB_ryhmä}       ${TL_Hallinnollinen luokka_RB}
    Log  Käydään toisessa tietolajissa
    vaihda tietolaji                    ${TL_Eurooppatienumero_RB}
    wait until element is visible       ${kartta}
    Log  Palataan takaisin varmistamaan ominaisuuden säilyminen
    vaihda tietolaji                    ${TL_Tielinkki_RB}
    Radio Button Should Be Set To       ${Tielinkin_RB_ryhmä}       ${TL_Hallinnollinen luokka_RB}

Tielinkit_2
    Log  vaihdetaan tietolajiksi tielinkki ja zoomataan 1:20 000 skaalalle
    vaihda tietolaji                            ${TL_Tielinkki_RB}
    Paikanna osoite                             6711279, 239896
    Log  Zoomataan yksi steppi kauemmas (1:50 000) ja varmistetaan, että popup ilmestyy
    Click Element                               ${zoombar_minus}
    Wait Until Element Is Not Visible           ${Map_popup}
    Click Element                               ${zoombar_minus}
    wait until element is visible               ${Map_popup}
    SeleniumLibrary.Element Text Should Be                      ${Map_popup}             ${Zoom_popup_context}
    Wait Until Element Is Not Visible           ${Map_popup}
    set selenium speed                          0.6
    Repeat Keyword  3 times  Click Element   ${zoombar_plus}
    set selenium speed                          ${DELAY}
    Odota sivun latautuminen
    Log  klikataan tielinkkiä kartalta
    click element at coordinates                ${kartta}   0  20
    double click element at coordinates         ${kartta}   0  20

    Log  Varmistetaan, että ominaisuustiedot tulevat näkyviin
    wait until element is visible               ${FA_otsikko}
    ${tmp_linkid}=  Seleniumlibrary.get text   ${FA_otsikko}
    Should Start With                           ${tmp_linkid}  Linkin ID:
    Log  Varmistetaan, että valinta säilyy zoomatessa
    Click Element                               ${zoombar_plus}
    element should be visible                   ${FA_otsikko}
    Click Element                               ${zoombar_minus}
    element should be visible                   ${FA_otsikko}
    ${temp}=    Seleniumlibrary.Get Text       ${map_coordinates_I}
    Seleniumlibrary.mouse down        css=[class='crosshair crosshair-center']
    Seleniumlibrary.Drag And Drop By Offset           ${kartta}      30   30
    Seleniumlibrary.mouse up          css=[class='crosshair crosshair-center']
    #sikulilibrary.Drag And Drop By Offset       kartan_siirto_tl2.png           30  30
    Log  Varmistetaan, että kartan siirto onnistui
    Odota sivun latautuminen
    VerifyTextNOT                               ${map_coordinates_I}               ${temp}
    element should be visible                   ${FA_otsikko}

    Log  käydään läpi tielinkin luokat ja varmistetaan, että linkin valinta säilyy
    FOR   ${i}     IN                          @{Tielinkin_luokat_RB}
       select radio button                     ${Tielinkin_RB_ryhmä}  ${i}
       wait until element is visible           ${Tielinkin_legenda_boksi_kaikki}
       element should be visible               ${FA_otsikko}
    END

    Log  Varmistetaan, että valinta poistuu klikkaamalla muualle
    Paikanna osoite                             6711084, 239747
    click element at coordinates                ${kartta}   0  20
    Wait Until Element Is Not Visible           ${FA_otsikko}

Tielinkit_3  [Arguments]  ${Luokan_odotusarvo}  ${testipaikka}
    Log  Varmistetaan, että annetu tielinkki ja toiminnallinen luokka täsmäävät ja varmistetaan, että vektorin tyyli täsmää legendaan
    Run Keyword If                          '${Luokan_odotusarvo}' == '${1}'  vaihda tietolaji               ${TL_Tielinkki_RB}
    Paikanna osoite                         ${testipaikka}
    #pause execution
    Zoomaa kartta                           3  20 m
    Log  Vaihdetaan tietolaji vain ekalla kerralla
    Odota sivun latautuminen
    Log  Valitaan tielinkki kartalta
    Odota sivun latautuminen
    mouse over    ${valitse tietolaji}
    double click element at coordinates     ${kartta}   0  20
    mouse over             ${kartta}
    click element at coordinates     ${kartta}   0  20
    wait until element is visible           ${FA_otsikko}
    Log  Varmistetaan, että formin toiminnallinen luokkaa vastaa annettua odotusarvoa
    VerifyValue                             ${FA_tielinkki_valittu_toiminnallinenluokka}  ${Luokan_odotusarvo}
    Log  Varmistetaan, että valitun toiminnallisen luokan värinen vektori on näkyvissä
    #Run Keyword If                          '${Luokan_odotusarvo}' == '${1}'  Exists  TL3_punainenlinkki.png  5
    #Run Keyword If                          '${Luokan_odotusarvo}' == '${2}'  Exists  TL3_punainenkatkoviiva.png  5   #elements should be visible   ${Polyline_red}   ${Polyline_Katkoviiva}
    #Run Keyword If                          '${Luokan_odotusarvo}' == '${3}'  Exists  TL3_pinkkilinkki.png  5  #element should be visible    ${Polyline_pink}
    #Run Keyword If                          '${Luokan_odotusarvo}' == '${4}'  Exists  TL3_pinkkikatkoviiva.png  5   #elements should be visible   ${Polyline_pink}  ${Polyline_Katkoviiva}
    #Run Keyword If                          '${Luokan_odotusarvo}' == '${5}'  Exists  TL3_sininenlinkki.png  5  #element should be visible    ${Polyline_blue}
    #Run Keyword If                          '${Luokan_odotusarvo}' == '${6}'  Exists  TL3_sininenkatkoviiva.png  5  #elements should be visible   ${Polyline_blue}  ${Polyline_Katkoviiva}
    #Run Keyword If                          '${Luokan_odotusarvo}' == '${7}'  Exists  TL3_harmaalinkki.png  5  #element should be visible    ${Polyline_grey}
    #Run Keyword If                          '${Luokan_odotusarvo}' == '${8}'  Exists  TL3_harmaakatkoviiva.png  5  #elements should be visible   ${Polyline_grey}  ${Polyline_Katkoviiva_klv}
    Nollaa karttavalinta

Tielinkit_4  [Arguments]  ${Luokan_odotusarvo}  ${testipaikka}
    Log  Varmistetaan, että annetu tielinkki ja tielinkin tyyppi täsmäävät ja varmistetaan, että vektorin tyyli täsmää legendaan
    Paikanna osoite                         ${testipaikka}
    Zoomaa kartta                           3  20 m
    #Log  Vaihdetaan tietolaji vain ekalla kerralla, tieto säilyy refreshin yli
    Run Keyword If                          '${Luokan_odotusarvo}' == 'Moottoritie'  vaihda tietolaji             ${TL_Tielinkki_RB}
    #Zoomaa edestakaisin
    Vaihda Tielinkin visualisointi          ${TL_Tielinkin tyyppi_RB}
    Log  Valitaan tielinkki kartalta
    Odota sivun latautuminen
    double click element at coordinates     ${kartta}   0   20
    wait until element is visible           ${FA_otsikko}
    Log  Varmistetaan, että formin tielinkin tyyppi vastaa annettua odotusarvoa
    SeleniumLibrary.Element Text Should Be                  ${FA_tielinkki_tielinkintyyppi}  ${Luokan_odotusarvo}
    Log  Varmistetaan, että valitun tielinkin tyypin värinen vektori on näkyvissä

    #Run Keyword If                          '${Luokan_odotusarvo}' == 'Moottoritie'                 Screen Should Contain  TL4_punainenlinkki.png
    #Run Keyword If                          '${Luokan_odotusarvo}' == 'Moottoriliikennetie'         Screen Should Contain  TL3_punainenkatkoviiva.png

    #Run Keyword If                          '${Luokan_odotusarvo}' == 'Yksiajoratainen tie'         Screen Should Contain  TL3_sininenlinkki.png
    #Run Keyword If                          '${Luokan_odotusarvo}' == 'Moniajoratainen tie'         Screen Should Contain  TL3_sininenkatkoviiva.png
    
    #Run Keyword If                          '${Luokan_odotusarvo}' == 'Kiertoliittymä'              Screen Should Contain  TL_turkoosilinkki.png
    #Run Keyword If                          '${Luokan_odotusarvo}' == 'Ramppi'                      Screen Should Contain  TL_turkoosikatkoviiva.png

    #Run Keyword If                          '${Luokan_odotusarvo}' == 'Jalankulkualue'              Screen Should Contain  TL3_harmaalinkki.png
    #Run Keyword If                          '${Luokan_odotusarvo}' == 'Kevyen liikenteen väylä'     Screen Should Contain  TL3_harmaakatkoviiva.png

    #Run Keyword If                          '${Luokan_odotusarvo}' == 'Levähdysalue'                Screen Should Contain  TL_vihrealinkki.png
    #Run Keyword If                          '${Luokan_odotusarvo}' == 'Ajopolku'                    Screen Should Contain  TL_vihreakatkoviiva.png

    #Run Keyword If                          '${Luokan_odotusarvo}' == 'Huoltoaukko moottoritiellä'  Screen Should Contain  TL4_pinkkilinkki.png
    #Run Keyword If                          '${Luokan_odotusarvo}' == 'Lautta/lossi'                Screen Should Contain  TL4_pinkkikatkoviiva.png
    Nollaa karttavalinta

Tielinkit_5  [Arguments]  ${Luokan_odotusarvo}  ${testipaikka}
    Log  Varmistetaan, että annetu hallinnollinen luokka ja valitun tielinkin hallinnollinen luokka täsmäävät ja varmistetaan, että vektorin tyyli täsmää legendaan
    Paikanna osoite                         ${testipaikka}
    Zoomaa kartta                           3  20 m
    Log  Vaihdetaan tietolaji vain ekalla kerralla, tieto säilyy refreshin yli
    Run Keyword If                          '${Luokan_odotusarvo}' == 'Kunnan omistama'      vaihda tietolaji             ${TL_Tielinkki_RB}
    Vaihda Tielinkin visualisointi          ${TL_Hallinnollinen luokka_RB}
    #zoomaa edestakaisin
    Odota sivun latautuminen
    Log  Valitaan tielinkki kartalta
    double click element at coordinates     ${kartta}   0  20
    wait until element is visible           ${FA_otsikko}
    Log  Varmistetaan, että formin hallinnollinen luokka vastaa annettua odotusarvoa
    SeleniumLibrary.Element Text Should Be                  ${FA_tielinkki_hallinnollinen luokka}  ${Luokan_odotusarvo}
    #Log  Varmistetaan, että valitun tielinkin tyypin värinen vektori on näkyvissä
    #Run Keyword If                          '${Luokan_odotusarvo}' == 'Kunnan omistama'      Screen Should Contain   TL5_vihrealinkki.png
    #Run Keyword If                          '${Luokan_odotusarvo}' == 'Valtion omistama'     Screen Should Contain   TL5_punainenlinkki.png
    #Run Keyword If                          '${Luokan_odotusarvo}' == 'Yksityisen omistama'  Screen Should Contain   TL5_sininenlinkki.png
    #Run Keyword If                          '${Luokan_odotusarvo}' == 'Tuntematon'           Screen Should Contain   TL5_harmaalinkki.png
    Nollaa karttavalinta

Tielinkit_6  [Arguments]  ${Luokan_odotusarvo}  ${testipaikka}
    Log  Varmistetaan, että annetu ja valitun tielinkin hallinnollinen luokka täsmäävät ja varmistetaan, että vektorin tyyli täsmää legendaan
    Paikanna osoite                         ${testipaikka}
    Zoomaa kartta                           4  20 m
    Log  Vaihdetaan tietolaji vain ekalla kerralla, tieto säilyy refreshin yli
    Run Keyword If                          '${Luokan_odotusarvo}' == 'Silta, Taso 1'       vaihda tietolaji        ${TL_Tielinkki_RB}
    Vaihda Tielinkin visualisointi          ${TL_Silta, alikulku tai tunneli_RB}
    Odota sivun latautuminen
    #    click element                           ${zoombar_minus}
    #Run Keyword If                          '${Luokan_odotusarvo}' == 'Maan pinnalla'       Pause Execution   TL6_harmaalinkki.png
    #Run Keyword If                          '${Luokan_odotusarvo}' == 'Silta, Taso 1'       Screen Should Contain   TL6_vihrealinkki.png
    #Run Keyword If                          '${Luokan_odotusarvo}' == 'Alikulku'            Screen Should Contain   TL6_punainenlinkki.png
    #Run Keyword If                          '${Luokan_odotusarvo}' == 'Tunneli'             Screen Should Contain   TL6_sininenlinkki.png
    #Run Keyword If                          '${Luokan_odotusarvo}' == 'Maan pinnalla'       Screen Should Contain   TL6_harmaalinkki.png
    Log  Valitaan tielinkki kartalta
    Odota sivun latautuminen
    click element at coordinates            ${kartta}   -100   -100
    Tupla Klikkaa Kartan Keskelle
    wait until element is visible           ${FA_otsikko}
    Log  Varmistetaan, että formin hallinnollinen luokka vastaa annettua odotusarvoa
    SeleniumLibrary.Element Text Should Be                  ${FA_tielinkki_silta,alikulku tai tunneli}      ${Luokan_odotusarvo}
    Nollaa karttavalinta
    

Tielinkit_7   [Arguments]  ${testipaikka}  ${liikennesuunta}
    Log  Tarkistetaan tielinkin liikennevirran suunta yksisuuntaisilla teillä, valitaan tielinkki ja tarkistetaan, että nuolisymboli on näkyvissä
    Run Keyword If                          '${liikennesuunta}' == '${Digitointisuuntaa vastaan}'  vaihda tietolaji        ${TL_Tielinkki_RB}
    Paikanna osoite                         ${testipaikka}
    Zoomaa kartta                           5  20 m
    Log  Vaihdetaan tietolaji vain ekalla kerralla, tieto säilyy refreshin yli
    Odota sivun latautuminen
    Log  Valitaan tielinkki kartalta
    click element at coordinates            ${kartta}   -100  -100
    Odota sivun latautuminen
    double click element at coordinates     ${kartta}   0   20
    wait until element is visible           ${FA_otsikko}
    SeleniumLibrary.Element Text Should Be                  ${FA_tielinkki_Liikennevirta}   ${liikennesuunta}
    click element at coordinates            ${kartta}   0   -100
    Odota sivun latautuminen
    #Run Keyword If                          '${liikennesuunta}' == '${Molempiin suuntiin}'  Screen Should Contain  TL7_molempiinsuuntiin
    #...  ELSE IF   '${liikennesuunta}' == '${Digitointisuuntaa vastaan}'    Screen Should Contain   TL7_suuntanuolivastaan.png
    #...  ELSE IF   '${liikennesuunta}' == '${Digitointisuuntaan}'           Screen Should Contain   TL7_suuntanuoli.png

Tielinkit_8
    vaihda tietolaji                        ${TL_Tielinkki_RB}
    ${i}=   Set Variable  0
    Log  loopataan läpi listan ja varmistetaan, että tekstit löytyvät oikealta diviltä
    FOR  ${text}     IN                    @{Tielinkin_RB_tekstit}
      ${i}=  Evaluate                      ${i} + 1
      SeleniumLibrary.Element Text Should Be  css=div.panel-group.road-links > div > div.panel-section.road-link-legend > div:nth-child(${i})  ${text}
    END

Tielinkit_9
    Log  Tarkistetaan, että tielinkin formilta löytyvät kaikki otsikot
    vaihda tietolaji                        ${TL_Tielinkki_RB}
    Paikanna osoite                         6711093, 239956
    Zoomaa kartta                           4  20 m
    Odota sivun latautuminen
    Log  Valitaan tielinkki kartalta
    click element at coordinates            ${kartta}   -100  -100
    double click element at coordinates     ${kartta}   0   20
    wait until element is visible           ${FA_otsikko}
    FOR  ${text}     IN        @{tielinkin_formin_otsikot}
      Page Should Contain      ${text}
    END


Tielinkit_10  [arguments]  ${testipaikka}  ${EkaLinkId}  ${TokaLinkId}
    Log  Valitaan muokattavat tielinkit, muutetaan linkiltä Toiminnallista luokkaa, liikennevirran suuntaa ja tielinkin tyyppiä.
    Log  Varmistetaan, että muutokset visualisoituu oikein ja uudet tiedot näkyy formilla.
    Log  valitaan kerran klikkaamalla koko tielinkin ketju, tehdään muutokset ja varmistetaan molemmat tielinkit erikseen
    click element                               ${Siirry muokkaustilaan}
    vaihda tietolaji                            ${TL_Tielinkki_RB}
    Paikanna osoite                             ${testipaikka}
    Zoomaa kartta                               4  20 m
    Odota sivun latautuminen
    Log  Valitaan koko tielinkin ketju (klikataan vektoria kerran) ja muokataan sitä
    click element at coordinates                ${kartta}   0   20
    wait until element is visible               ${FA_tielinkki_toiminnallinen_luokka}
    Log  Tarkistetaan, että testin lähtötilanne on oletettu. Jos ei, niin muutetaan linkit
    ${status}   ${value}=   Run Keyword And Ignore Error    VerifyValue         ${FA_tielinkki_valittu_toiminnallinenluokka}    5
    run keyword if    '${status}'=='FAIL'       Muuta tielinkin tilanne normaaliksi
    click element at coordinates                ${kartta}   0  20
    wait until element is visible               ${FA_tielinkki_toiminnallinen_luokka}
    SeleniumLibrary.Element Text Should Be                      ${FA_tielinkki_MML_ID}        [useita eri arvoja]
    ${tmp_muokkausdate}  Seleniumlibrary.get text     ${FA_Muokattu_viimeksi}
    SeleniumLibrary.Element Text Should Be                      ${FA_Linkkien_lkm}                      Linkkien lukumäärä: 2
    Log  Vaihdetaan linkin toiminnallinen luokka 1:een
    open context menu                           ${FA_tielinkki_toiminnallinen_luokka}
    select from list by value                   ${FA_tielinkki_toiminnallinen_luokka}   1
    Log  Vaihdetaan linkkien liikennevirran suunta yksisuuntaiseksi
    ${status}=  Run Keyword And Return Status  List Selection Should Be  ${FA_tielinkki_Liikennevirta_lista}  ${FA_liikennevirta_MolempiinSuuntiin}
    open context menu                           ${FA_tielinkki_Liikennevirta_lista}
    select from list by value                   ${FA_tielinkki_Liikennevirta_lista}     ${FA_liikennevirta_Digit_vastaan}
    Run Keyword If  '${status}'=='True'  Wait until element is visible  ${MuokkausVaroitus}
    Run Keyword If  '${status}'=='True'  Click Button  ${Muokkausvaroitus_Kyllä_btn}

    Log  vaihdetaan tielinkin tyyppi moottoritieksi
    open context menu                           ${FA_tielinkki_tielinkintyyppi_lista}
    select from list by value                   ${FA_tielinkki_tielinkintyyppi_lista}         1
    Log  tallennetaan muutokset
    click element                               ${FA_footer_Tallenna}
    Wait Until Element Is Not Visible           ${Spinner_Overlay}
    Odota sivun latautuminen
    Log  Nollataan koko linkin valinta ja käydään tarkistamassa, että molempien linkkien tiedot ovat muuttuneet
    click element at coordinates                ${kartta}  1  -50
    wait until element is not visible           ${FA_footer_Tallenna}
    Log  Varmistetaan, että muutokset visualisoituu oikein (punainen suuntanuoli)
    Odota sivun latautuminen
    #Screen Should Contain                       TL12_pun_suuntanuoli.png
    #   Tuplaklikkaus ei toiminut, päädyttiin käyttämään kahta erillistä sen sijaan, koska toimivat
    set selenium speed     0
    #click element at coordinates                ${kartta}   0  20
    #click element at coordinates                ${kartta}   0  20
    doubleclick_element_at_coordinates          ${kartta}   0  20
    set selenium speed      ${delay}
    wait until element is visible               ${FA_tielinkki_MML_ID}
    ${tmp_linkid}=  Seleniumlibrary.get text   ${FA_otsikko}
    Should Start With                           ${tmp_linkid}                           Linkin ID:
    Log  Tarkistetaan, että tallennuspäivämäärä on vaihtunut
    VerifyTextNOT                               ${FA_Muokattu_viimeksi}                 ${tmp_muokkausdate}
    SeleniumLibrary.Element Text Should Be                      ${FA_Linkkien_lkm}                      Linkkien lukumäärä: 1
    SeleniumLibrary.Element Text Should Be                      ${FA_otsikko}                           ${EkaLinkId}
    List Selection Should Be                    ${FA_tielinkki_toiminnallinen_luokka}   1
    List Selection Should Be                    ${FA_tielinkki_Liikennevirta_lista}     ${FA_liikennevirta_Digit_vastaan}
    List Selection Should Be                    ${FA_tielinkki_tielinkintyyppi_lista}         1
    Log  Tarkistetaan toisen tielinkin tiedot
    click element                               ${zoombar_minus}
    click element                               ${zoombar_plus}
    Odota sivun latautuminen

    #   tuplaklikkaus toimi jostain syystä kahdella erillisellä klikkauksella parhaiten,
    set selenium speed     0.1
    #click element at coordinates                ${kartta}   304  -157           #-177
    #click element at coordinates                ${kartta}   305  -158           #-178
    doubleclick_element_at_coordinates          ${kartta}   304  -157           #-177
    set selenium speed      ${delay}
    wait until element is visible               ${FA_tielinkki_MML_ID}
    ${tmp_linkid}=  Seleniumlibrary.get text   ${FA_otsikko}
    Should Start With                           ${tmp_linkid}                           Linkin ID:
    Log  Tarkistetaan, että toisella linkillä on sama tallennusaika kuin ensimmäisellä
    VerifyTextNOT                               ${FA_Muokattu_viimeksi}                 ${tmp_muokkausdate}
    SeleniumLibrary.Element Text Should Be                      ${FA_Linkkien_lkm}                      Linkkien lukumäärä: 1
    SeleniumLibrary.Element Text Should Be                      ${FA_otsikko}                           ${TokaLinkId}
    List Selection Should Be                    ${FA_tielinkki_toiminnallinen_luokka}   1
    List Selection Should Be                    ${FA_tielinkki_Liikennevirta_lista}     ${FA_liikennevirta_Digit_vastaan}
    List Selection Should Be                    ${FA_tielinkki_tielinkintyyppi_lista}   1
    Log  Muutetaan tielinkkien tiedot takaisin lähtötilanteeseen

    #lasketaan seleniumin nopeutta hetkeksi, koska tässä kohtaa aiheutui usein turhia faileja
    set selenium speed                          0.5
    click element at coordinates                ${kartta}  -10  -50
    wait until element is not visible           ${FA_footer_Tallenna}
    Set Selenium Speed                          ${DELAY}
    click element at coordinates                ${kartta}   0  20
    wait until element is visible               ${FA_tielinkki_toiminnallinen_luokka}
    element should be visible                   ${FA_tielinkki_MML_ID}
    SeleniumLibrary.Element Text Should Be                      ${FA_otsikko}   Ominaisuustiedot
    open context menu                           ${FA_tielinkki_toiminnallinen_luokka}
    select from list by value                   ${FA_tielinkki_toiminnallinen_luokka}   5
    open context menu                           ${FA_tielinkki_Liikennevirta_lista}
    select from list by value                   ${FA_tielinkki_Liikennevirta_lista}     ${FA_liikennevirta_MolempiinSuuntiin}
    open context menu                           ${FA_tielinkki_tielinkintyyppi_lista}
    select from list by value                   ${FA_tielinkki_tielinkintyyppi_lista}   2
    Log  tallennetaan muutokset
    click element                               ${FA_footer_Tallenna}
    Wait Until Element Is Not Visible           ${Spinner_Overlay}
    sleep  2
    odota sivun latautuminen
    #Element Should Not Be Visible               ${map_overlay}

Tielinkit_11

    vaihda tietolaji                            ${TL_Tielinkki_RB}
    Odota sivun latautuminen
    wait until element is visible               ${FA_Link_incomplete-links}  10
    
    Log  avataan Korjattavien linkkien lista
    click element                               ${FA_Link_incomplete-links}
    wait until element is visible               css=.content-box>header  20

    Log  tarkistetaan, että listalta löytyvät otsikot
    page should contain                         Kunnan omistama
    page should contain                         Yksityisen omistama
    page should contain                         Valtion omistama

    Log  Tarkistetaan, että listan linkeistä satunnaisesti valittu paikka/linkki
        #selector korjattava kun listaan saadaan sisältöä
    IF    '${korjattavien_tsekkaus}' == 'False'
        Sleep    5
        Click Element    css=#work-list > div > div > div > header > a
    ELSE
    Arvo linkki korjattavien listalta
    wait until element is visible               ${tmp_ListLocator}
    Log  otetaan linkin ID talteen ennen sen klikkaamista
    ${tmp_linkID}=  Seleniumlibrary.get text                    ${tmp_ListLocator}
    ${tmp_linkID}=  remove string               ${tmp_linkID}   \#linkProperty/
    Log  ${tmp_linkID}
    click element                               ${tmp_ListLocator}
    click element at coordinates                ${kartta}  -100  -100
    Zoomaa kartta                               10  5 m
    Odota sivun latautuminen
    double click element at coordinates         ${kartta}  0  20
    element should contain                      ${FA_otsikko}  ${tmp_linkID}

    Log  varmistetaan että kartalta klikattu linkin ID täsmää listalta otettuun.
    Set Selenium Speed                          ${DELAY}
    END

Tielinkit_13
    #Ei testata, CTRL valinta on vanha ominaisuus
    Log  Paikannetaan kartalta kohta, josta valitaan muokattavat tielinkit (4kpl, turun kauppatorin kulma)
    Paikanna osoite                             6710989, 239704
    Zoomaa kartta                               3  20 m
    click element                               ${Siirry muokkaustilaan}
    vaihda tietolaji                            ${TL_Tielinkki_RB}
    Odota sivun latautuminen
    sleep  2 sec
    press control and drag and drop by offset   ${kartta}   160   100
    #    pause execution
    wait until element is visible               ${mass_update_modal_functClass_menu}
    Log  Varmistetaan otsikko
    SeleniumLibrary.Element Text Should Be                      ${mass_update_modal_otsikko}            Olet valinnut 4 tielinkkiä
    log  Muutetaan linkeiltä toiminnallinen luokka ja linkin tyyppi
    open context menu                           ${mass_update_modal_functClass_menu}
    select from list by value                   ${mass_update_modal_functClass_menu}    8
    open context menu                           ${mass_update_modal_linkType_menu}
    select from list by value                   ${mass_update_modal_linkType_menu}      4
    click element                               ${mass_update_modal_tallenna}
    wait until element is visible               ${map_overlay}
    Odota sivun latautuminen
    Log  Muutetaan samojen tielinkkien tiedot takaisin
    press control and drag and drop by offset   ${kartta}   160   100
    wait until element is visible               ${mass_update_modal_functClass_menu}
    SeleniumLibrary.Element Text Should Be                      ${mass_update_modal_otsikko}            Olet valinnut 4 tielinkkiä
    open context menu                           ${mass_update_modal_functClass_menu}
    select from list by value                   ${mass_update_modal_functClass_menu}    5
    open context menu                           ${mass_update_modal_linkType_menu}
    select from list by value                   ${mass_update_modal_linkType_menu}      3
    click element                               ${mass_update_modal_tallenna}
    wait until element is visible               ${map_overlay}
    wait until element is not visible           ${map_overlay}

#######################
## Sisäiset keywordit #
#######################

Vaihda Tielinkin visualisointi  [Arguments]  ${tielinkin_visualisointi}
    wait until element is visible   ${valitse tietolaji}
    select radio button             ${Tielinkin_RB_ryhmä}  ${tielinkin_visualisointi}
    wait until element is visible   ${Tielinkin_legenda_boksi_kaikki}

Arvo linkki korjattavien listalta
    Log  Arvotaan listalta linkki väliltä 1-25
    ${RandListItem}=            Evaluate                random.randint(1,25)       modules=random
    ${tmp_ListLocator}=         set variable            xpath=(.//*[@id='work-list']//*[@class='work-list-item'])[${RandListItem}]
    Set Test Variable           ${tmp_ListLocator}

Nollaa karttavalinta
    Log  Nollataan tielinkin valinta seuraavia steppejä varten
    Paikanna osoite                         6676108, 372839
    # Viive tarvi hetkellisesti kasvattaa, koska kartan klikkaaminen aiheutti muuten ongelmia
    set selenium speed  0.2
    wait until element is visible       ${kartta}
    click element at coordinates        ${kartta}   0  20
    Set Selenium Speed              ${DELAY}

Muuta tielinkin tilanne normaaliksi
    open context menu                           ${FA_tielinkki_toiminnallinen_luokka}
    select from list by value                   ${FA_tielinkki_toiminnallinen_luokka}   5
    open context menu                           ${FA_tielinkki_Liikennevirta_lista}
    select from list by value                   ${FA_tielinkki_Liikennevirta_lista}     ${FA_liikennevirta_MolempiinSuuntiin}
    open context menu                           ${FA_tielinkki_tielinkintyyppi_lista}
    select from list by value                   ${FA_tielinkki_tielinkintyyppi_lista}   3
    click element                               ${FA_footer_Tallenna}
    wait until element is visible               ${map_overlay}
    Odota sivun latautuminen
    #wait until element is not visible           ${map_overlay}

Paina Elementtia Kartalta Ja Katso tiedot
    FOR  ${n}  IN RANGE  10
        Click element at coordinates            ${kartta}   0  20
        ${status}=  Run Keyword And Return Status  Element Should Be Visible    ${FA_otsikko}
        Exit For Loop If  "${status}"=="True"
    END

