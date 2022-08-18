*** Settings ***
Documentation       Pageobject for Traffic signs (Palvelupiste)

*** Keywords ***

Palvelupiste_1  [arguments]  ${testipaikka}
    log  Luodaan uusi Palvelupiste, Täytetään kaikki kentät
    Siirry Testipaikkaan  ${TL_Palvelupiste_RB}  ${Testipaikka}
    #Valitse Kaikki Palvelupisteet
    Odota sivun latautuminen

    Alusta Testipaikka
    #Luo Palvelupiste

    Log  Alustetaan testipaikka uusiksi. Tarkistetaan, että Palvelupiste näkyy oikeassa kategoriassa.
    Siirry Muokkaustilaan
    Click Element                               ${Muokkaustila_AddTool}
    Click Element At Coordinates                ${Kartta}   0   20
    Wait Until Element Is Visible               css=.form-control
    Click Element                               css=.form-control
    Click Element                               css=.form-control option[value="12"]    #pysäköintialue, väliaikainen ennen nimeämisten muuttumista
    Click Element                               css=.form-control.select-service-type-extension option[value="2"]   #perusvarustelu, value numeroina
    Input Text                                  css=.form-control.service-name  Hippoksen parkki
    Input Text                                  css=.form-control.large-input   Hipposparkin lisätiedot
    Input Text                                  css=.form-control.service-parking-place-count   300
    Click Element                               ${FA_footer_Tallenna}
    #Click Element                               ${Muokkaustila_SelectTool}
    Siirry Katselutilaan

    #Click Element                               ${FA_footer_Tallenna}

    Click Element At Coordinates                ${Kartta}   0   20
    ${date}=  Get Current Date                  result_format=%d.%m.%Y
    Wait Until Element Is Visible               ${FA_otsikko}
    Tarkista Palvelupisteen Kentät              ${date}

    Alusta Testipaikka


Palvelupiste_2  [Arguments]  ${testipaikka}  ${Merkin_tyyppi}  ${Merkin_teksti}
    Testin Aloitus
    log  Paikannetaan Palvelupiste. Tarkistetaan palvelupisteen tyyppi.
    Siirry Testipaikkaan            ${TL_Palvelupiste_RB}  ${testipaikka}
    Valitse Kaikki Palvelupisteet
    Click Element                   ${Merkin_tyyppi}
    Odota sivun latautuminen

    Click Element At Coordinates    ${Kartta}  0  20
    Wait Until Element Is Visible   ${FA_otsikko}
    Element Should Contain          css=#feature-attributes-form  ${Merkin_teksti}

Palvelupiste_3  [Arguments]  ${testipaikka}
    Log  Loudaan uusi merkki. Tarkistetaan kentän raja-arvot ja xss/html injektiot.
    Siirry Testipaikkaan  ${TL_Palvelupiste_RB}  ${Testipaikka}
    #Valitse Kaikki Palvelupisteet
    Odota sivun latautuminen

    Log  Luodaan uusi Palvelupiste, ja testtaan voidaanko virheellisiä arvoja tallettaa
    Alusta Testipaikka
    Siirry Muokkaustilaan
    Odota sivun latautuminen
    click element                           ${Muokkaustila_AddTool}
    Click Element At Coordinates            ${Kartta}  0  20
    Wait Until Element Is Visible           ${FA_otsikko}
    Element Should Be Enabled               ${FA_footer_Peruuta}
    Click Element   ${Tyyppi}
    Click Element   ${Tyyppi_DDM}
    Click Element   ${Alityyppi}
    Click Element   ${Alityyppi_DDM}

    FOR  ${teksti}  IN  @{Haku_Muuttujat}
        Syota virheellinen arvo                 ${Arvo}  ${teksti}
    END

    Log  Arvotaan satunnainen numero, tallennus pitäisi olla poissa. Jos nopeus = oikea rajoitus, testiä ei ajeta.
    ${numero}  ${status}=  Arvo Numero
    Run Keyword If  '${status}'=='False'  Input Text  ${Arvo}  ${numero}
    Element Should Be Disabled                  ${FA_footer_Tallenna}

    Log  Arvotaan satunnainen string, tallennus pitäisi olla poissa.
    ${str}=  Generate Random String
    Input Text                                  ${Arvo}  ${str}
    Click Element                               ${Päämerkin_Teksti}
    Element Should Be Disabled                  ${FA_footer_Tallenna}

    FOR  ${teksti}  IN  @{Nopeusrajoitukset}
        Syota kelvollinen arvo                  ${Arvo}  ${teksti}
    END

    Log  Kaista numeron testit

    FOR  ${teksti}  IN  10  00  40  30  100  999
        Syota virheellinen arvo                 ${Kaista}  ${teksti}
    END

    FOR  ${teksti}  IN  11  19  25  24  31  39
        Syota kelvollinen arvo                  ${Kaista}  ${teksti}
    END


Palvelupiste_4  [Arguments]  ${testipaikka}
    Siirry Testipaikkaan  ${TL_Palvelupiste_RB}  ${Testipaikka}
    #Valitse Kaikki Palvelupisteet
    Odota sivun latautuminen

    Log  Luodaan uusi merkki, ja sille lisä kilpi. Siirretään molempia yhdessä.
    Alusta Testipaikka

    Click Element At Coordinates  ${Kartta}  0  -40
    ${status}=  Run Keyword And Return Status  Wait Until Element Is Visible  ${FA_otsikko}
    Run Keyword If  ${status}==True  Poista Kohde


    Siirry Muokkaustilaan
    Odota sivun latautuminen
    click element                           ${Muokkaustila_AddTool}
    Click Element At Coordinates            ${Kartta}  0  20
    Wait Until Element Is Visible           ${FA_otsikko}
    Element Should Be Enabled               ${FA_footer_Peruuta}

    Log  Täytetään palvelupisteen kentät.
    Click Element                           ${Tyyppi}
    Click Element                           ${Tyyppi_DDM}
    Click Element                           ${Alityyppi}
    Click Element                           ${Alityyppi_DDM}
    Input Text                              ${Arvo}  100
    Täytä Lisäkilven Kentät
    Click Element                           ${FA_footer_Tallenna}
    Wait Until Element Is Not Visible       ${Spinner_Overlay}
    Odota sivun latautuminen

    Log  Siirretään Palvelupisteä lisäkilvellä
    Click Element                           ${Muokkaustila_SelectTool}
    Click Element at Coordinates            ${Kartta}  0  20
    Wait Until Element Is Visible           ${FA_otsikko}
    Siirrä Kohde                            0  -40
    Click Element                           ${FA_footer_Tallenna}
    Wait Until Element Is Not Visible       ${Spinner_Overlay}
    Odota sivun latautuminen

    Log  Tarkistetaan onko Palvelupiste siirtynyt. 
    Log  Klikataan vanhaan kohtaan, jolloin merkki ei pitäisi aueta
    Click Element At coordinates            ${Kartta}  0  20
    ${status}=  Run Keyword And Return Status  Wait Until Element Is Visible  ${FA_otsikko}
    Run Keyword If  ${status}==True         Alusta Testipaikka
    Run Keyword If  ${status}==True         Fail  Palvelupiste ei siirtynyt.

    Click Element At coordinates            ${Kartta}  0  -40
    Wait Until Element Is Visible           ${FA_otsikko}
    Click Element                           ${FA_Poista_chkbx}
    Click Element                           ${FA_footer_Tallenna}
    Wait Until Element Is Not Visible       ${Spinner_Overlay}

    #Siirry Katselutilaan
    #Alusta Testipaikka

Palvelupiste_5  [Arguments]  ${Testipaikka}
    Siirry Testipaikkaan  ${TL_Palvelupiste_RB}  ${Testipaikka}
    Odota sivun latautuminen
    Alusta Testipaikka

    Log  Palvelupisteä ei voi lisätä muokkaustyökalulla. Rivi:779
    Siirry Muokkaustilaan
    Click Element At Coordinates            ${Kartta}  0  20
    Repeat Keyword  10 s  Element Should Not Be Visible  ${FA_otsikko}

    Log  Palvelupisteen voi lisätä lisäystyökalulla. Rivi: 778
    Click Element                           ${Muokkaustila_AddTool}
    Click Element At Coordinates            ${Kartta}  0  20
    Log  Klikkaamalla kartalta sijainti uudelle liikennemerkille, avautuu ominaisuustietonäkymä uudelle liikennemerkille. Rivi: 781
    Wait Until Element Is Visible           ${FA_otsikko}

    Log  Uuden palvelupisteen luonti peruutetaan painamalla "Peruuta" -painiketta. Rivi: 785
    Click Element                           ${FA_footer_Peruuta}
    Wait Until Element Is Not Visible       ${FA_otsikko}

    Log  Jos lisäystyökalulla klikkaa kohtaa, jolla ei ole linkkiä, Palvelupiste muodostuu lähimmälle linkille. Rivi: 782
    Click Element At Coordinates            ${Kartta}  40  20
    Wait Until Element Is Visible           ${FA_otsikko}
    Log  Uusi Palvelupiste luodaan painamalla "Tallenna"-painiketta. Rivi: 784
    Click Element                           ${FA_footer_Tallenna}
    Wait Until Element Is Not Visible       ${Spinner_Overlay}
    Odota sivun latautuminen

    Click Element                           ${Muokkaustila_SelectTool}
    Click Element At Coordinates            ${Kartta}  0  20
    Wait Until Element Is Visible           ${FA_otsikko}
    Log  Palvelupisteen voi poistaa: Rivi 790
    Click Element                           ${FA_Poista_chkbx}
    Click Element                           ${FA_footer_Tallenna}
    Wait Until Element Is Not Visible       ${Spinner_Overlay}
    Odota sivun latautuminen



#######################
## Sisäiset keywordit #
#######################

Valitse Kaikki Palvelupisteet
    FOR  ${selector}  IN  @{LM_lista}
        Click Element  ${selector}
    END

Luo Palvelupiste
    Siirry Muokkaustilaan
    Odota sivun latautuminen
    Click Element                           ${Muokkaustila_AddTool}
    Click Element At Coordinates            ${Kartta}  0  20
    Wait Until Element Is Visible           ${FA_otsikko}
    Element Should Be Enabled                ${FA_footer_Peruuta}
    Täytä Palvelupisteen kentät
    Click Element                           ${FA_footer_Tallenna}
    Sleep  1
    Wait Until Element Is Not Visible           ${Spinner_Overlay}  timeout=30 s
    Odota sivun latautuminen


Täytä Palvelupisteen kentät
    Click Element                               css=.form-control
    Click Element                               css=.form-control option[value="12"]    #pysäköintialue, väliaikainen ennen nimeämisten muuttumista
    Click Element                               css=.form-control.select-service-type-extension option[value="2"]   #perusvarustelu, value numeroina
    Input Text                                  css=.form-control.service-name  Hippoksen parkki
    Input Text                                  css=.form-control.large-input   Hipposparkin lisätiedot
    Input Text                                  css=.form-control.service-parking-place-count   300
#    Click Element   ${Tyyppi}
#    Click Element   ${Tyyppi_DDM}
#    Click Element   ${Alityyppi}
#    Click Element   ${Alityyppi_DDM}
#    Input Text      ${Arvo}                 100
#    Input Text      ${Päämerkin_Teksti}     Testi         
#    Input Text      ${Kunnan_ID}            Kunta12                
#    Input Text      ${Lisätieto}            HienoMerkki             
#    Click Element   ${Rakenne}                      
#    Click Element   ${Rakenne_DDM}                    
#    Click Element   ${Kunto}                          
#    Click Element   ${Kunto_DDM}                     
#    Click Element   ${Koko}                          
#    Click Element   ${Koko_DDM}                    
#    Input Text      ${Korkeus}  100                     
#    Click Element   ${Kalvon_Tyypi}                  
#    Click Element   ${Kalvon_Tyypi_DDM}            
#    Click Element   ${Merkin_Materiaali}             
#    Click Element   ${Merkin_Materiaali_DDM}        
#    Click Element   ${Sijaintitarkenne}               
#    Click Element   ${Sijaintitarkenne_DDM}           
#    Input Text      ${Maastokoordinaatti_X}  82          
#    Input Text      ${Maastokoordinaatti_Y}  86         
#    #Input Text      ${Kaista}   2            
#    Click Element   ${Kaistan_Tyyppi}                 
#    Click Element   ${Kaistan_Tyyppi_DDM}             
#    Click Element   ${Tila}                             
#    Click Element   ${Tila_DDM}                       
#    Input Text      ${Alkupäivämäärä}        1.12.2025            
#    Input Text      ${Loppupäivämäärä}       1.12.2026          
#    Click Element   ${Vauriotyyppi}                    
#    Click Element   ${Vauriotyyppi_DDM}                 
#    Click Element   ${Korjauksen_Kiireellisyys}        
#    Click Element   ${Korjauksen_Kiireellisyys_DDM}     
#    Input Text      ${Arvioitu_Käyttöikä}       1     

Täytä Lisäkilven Kentät
    Click Element  ${Lisakilpi}
    Click Element  ${LK_Alityyppi}
    Click Element  ${LK_Alityyppi_DDM}
    Input Text     ${LK_Arvo}                          40
    Input Text     ${LK_Teksti}                        teksti
    Input Text     ${LK_Lisatieto}                     ei lisä tietoaäöäÅ
    Click Element  ${LK_Koko}
    Click Element  ${LK_Koko_DDM}
    Click Element  ${LK_KalvonTyyppi}
    Click Element  ${LK_KalvonTyyppi_DDM}
    Click Element  ${LK_LisakilvenVari}
    Click Element  ${LK_LisakilvenVari_DDM}

Tarkista Palvelupisteen Kentät  
    [Arguments]  ${date}
    Element Should Contain                      ${FA_Lisätty_Järjestelmään}  ${date}
    
    #Element Should Contain                      ${FA_Tyyppi}  Kielto- ja rajoitusmerkit
    #Element Should Contain                      ${FA_Alityyppi}  C32 Nopeusrajoitus
    #Element Should Contain                      ${FA_Arvo}  100
    #Element Should Contain                      ${FA_Päämerkin_Teksti}  Testi
    #Element Should Contain                      ${FA_Kunnan_ID}  Kunta12
    #Element Should Contain                      ${FA_Lisätieto}  HienoMerkki
    #Element Should Contain                      ${FA_Rakenne}  Silta
    #Element Should Contain                      ${FA_Kunto}  Tyydyttävä
    #Element Should Contain                      ${FA_Koko}  Normaalikokoinen merkki
    #Element Should Contain                      ${FA_Korkeus}  100
    #Element Should Contain                      ${FA_Kalvon_Tyyppi}  R2-luokan kalvo
    #Element Should Contain                      ${FA_Merkin_Materiaali}  Alumiini
    #Element Should Contain                      ${FA_Sijaintitarkenne}  Väylän vasen puoli
    #Element Should Contain                      ${FA_Maastokoordinaatti_X}  82
    #Element Should Contain                      ${FA_Maastokoordinaatti_Y}  86
    #Element Should Contain                      ${FA_Kaista}  –
    #Element Should Contain                      ${FA_Kaistan_Tyyppi}  Ohituskaista
    #Element Should Contain                      ${FA_Tila}  Rakenteilla
    #Element Should Contain                      ${FA_Alkupäivämäärä}  01.12.2025
    #Element Should Contain                      ${FA_Loppupäivämäärä}  01.12.2026
    #Element Should Contain                      ${FA_Vauriotyyppi}  Kolhiintunut
    #Element Should Contain                      ${FA_Korjauksen_Kiireellisyys}  Kiireellinen
    #Element Should Contain                      ${FA_Arvioitu_Käyttöikä}  1

Syota virheellinen arvo  
    [Arguments]                 ${kenttä}  ${arvo}
    Input Text                  ${kenttä}  ${Arvo}
    Click Element               ${Päämerkin_Teksti}
    Element Should Be Disabled  ${FA_footer_Tallenna}

Syota kelvollinen arvo
    [Arguments]                 ${kenttä}  ${arvo}
    Input Text                  ${kenttä}  ${Arvo}
    Click Element               ${Päämerkin_Teksti}
    Element Should Be Enabled   ${FA_footer_Tallenna}

Arvo Numero
    ${numero}=  Evaluate  random.randint(0, sys.maxsize)
    ${numero}=  Convert To String  ${numero}
    FOR  ${num}  IN  @{Nopeusrajoitukset}
        ${status}=  Run Keyword and return status  Should Be Equal  ${num}  ${numero}
    END
    [Return]  ${numero}  ${status}

*** Variables ***
${LM_Varoitusmerkit}    generalWarningSigns
${LM_Etuajo-oikeus}     priorityAndGiveWaySigns
${LM_Kielto}            prohibitionsAndRestrictions
${LM_Määräysmerkit}     mandatorySigns
${LM_Sääntömerkit}      regulatorySigns
${LM_Opastusmerkit}     informationSigns
${LM_Palvelukohteet}    serviceSigns
${LM_Muut_merkit}       otherSigns

@{LM_lista}  
...     ${LM_Varoitusmerkit}  ${LM_Etuajo-oikeus}  ${LM_Kielto}
...     ${LM_Määräysmerkit}  ${LM_Sääntömerkit}  ${LM_Opastusmerkit}
...     ${LM_Palvelukohteet}  ${LM_Muut_merkit}

@{Nopeusrajoitukset}
...     20  30  40  50  60  70  80  90  100  120

#####################
### Merkin kentät ###
#####################

#_DMM valitsin on alasvetovalikon valinta.

${Tyyppi}                           css=#main-service_type
${Tyyppi_DDM}                       css=#main-service_type > option:nth-child(3)
${Alityyppi}                        css=#service_type
${Alityyppi_DDM}                    css=#service_type > option:nth-child(32)
${Arvo}                             css=#service_value
${Päämerkin_Teksti}                 css=#main_sign_text
${Kunnan_ID}                        css=#municipality_id
${Lisätieto}                        css=#service_info
${Rakenne}                          css=#structure
${Rakenne_DDM}                      css=#structure > option:nth-child(3)
${Kunto}                            css=#condition
${Kunto_DDM}                        css=#condition > option:nth-child(3)
${Koko}                             css=#size
${Koko_DDM}                         css=#size > option:nth-child(2)
${Korkeus}                          css=#height
${Kalvon_Tyypi}                     css=#coating_type
${Kalvon_Tyypi_DDM}                 css=#coating_type > option:nth-child(2)
${Merkin_Materiaali}                css=#sign_material
${Merkin_Materiaali_DDM}            css=#sign_material > option:nth-child(2)
${Sijaintitarkenne}                 css=#location_specifier
${Sijaintitarkenne_DDM}             css=#location_specifier > option:nth-child(2)
${Maastokoordinaatti_X}             css=#terrain_coordinates_x
${Maastokoordinaatti_Y}             css=#terrain_coordinates_y
${Kaista}                           css=#lane
${Kaistan_Tyyppi}                   css=#lane_type
${Kaistan_Tyyppi_DDM}               css=#lane_type > option:nth-child(2)
${Tila}                             css=#life_cycle
${Tila_DDM}                         css=#life_cycle > option:nth-child(2)
${Alkupäivämäärä}                   css=#trafficSign_start_date
${Loppupäivämäärä}                  css=#trafficSign_end_date
${Vauriotyyppi}                     css=#type_of_damage
${Vauriotyyppi_DDM}                 css=#type_of_damage > option:nth-child(2)
${Korjauksen_Kiireellisyys}         css=#urgency_of_repair
${Korjauksen_Kiireellisyys_DDM}     css=#urgency_of_repair > option:nth-child(2)
${Arvioitu_Käyttöikä}               css=#lifespan_left

#Lisäkilven kentät
${Lisakilpi}                        css=#additional-panel-checkbox
${LK_Alityyppi}                     css=#panelType
${LK_Alityyppi_DDM}                 css=#panelType  > option:nth-child(10)
${LK_Arvo}                          css=#panelValue
${LK_Teksti}                        css=#text
${LK_Lisatieto}                     css=#panelInfo
${LK_Koko}                          css=.form-group.editable.form-traffic-sign-panel #size
${LK_Koko_DDM}                      css=.form-group.editable.form-traffic-sign-panel #size > option:nth-child(1)
${LK_KalvonTyyppi}                  css=.panel-group-container #coating_type
${LK_KalvonTyyppi_DDM}              css=.panel-group-container #coating_type option:nth-child(2)
${LK_LisakilvenVari}                css=#additional_panel_color
${LK_LisakilvenVari_DDM}            css=#additional_panel_color option:nth-child(2)


${FA_Tyyppi}                        css=#feature-attributes-form > div > div > div:nth-child(3) > p
${FA_Alityyppi}                     css=#feature-attributes-form > div > div > div:nth-child(4) > p
${FA_Arvo}                          css=#feature-attributes-form > div > div > div:nth-child(5) > p
${FA_Päämerkin_Teksti}              css=#feature-attributes-form > div > div > div:nth-child(6) > p
${FA_Kunnan_ID}                     css=#feature-attributes-form > div > div > div:nth-child(7) > p
${FA_Lisätieto}                     css=#feature-attributes-form > div > div > div:nth-child(8) > p
${FA_Rakenne}                       css=#feature-attributes-form > div > div > div:nth-child(9) > p
${FA_Kunto}                         css=#feature-attributes-form > div > div > div:nth-child(10) > p
${FA_Koko}                          css=#feature-attributes-form > div > div > div:nth-child(11) > p
${FA_Korkeus}                       css=#feature-attributes-form > div > div > div:nth-child(12) > p
${FA_Kalvon_Tyyppi}                 css=#feature-attributes-form > div > div > div:nth-child(13) > p
${FA_Merkin_Materiaali}                css=#feature-attributes-form > div > div > div:nth-child(14) > p
${FA_Sijaintitarkenne}                 css=#feature-attributes-form > div > div > div:nth-child(15) > p
${FA_Maastokoordinaatti_X}             css=#feature-attributes-form > div > div > div:nth-child(16) > p
${FA_Maastokoordinaatti_Y}             css=#feature-attributes-form > div > div > div:nth-child(17) > p
${FA_Kaista}                           css=#feature-attributes-form > div > div > div:nth-child(18) > p
${FA_Kaistan_Tyyppi}                   css=#feature-attributes-form > div > div > div:nth-child(19) > p
${FA_Tila}                             css=#feature-attributes-form > div > div > div:nth-child(20) > p
${FA_Alkupäivämäärä}                   css=#feature-attributes-form > div > div > div:nth-child(21) > p
${FA_Loppupäivämäärä}                  css=#feature-attributes-form > div > div > div:nth-child(22) > p
${FA_Vauriotyyppi}                     css=#feature-attributes-form > div > div > div:nth-child(23) > p
${FA_Korjauksen_Kiireellisyys}         css=#feature-attributes-form > div > div > div:nth-child(24) > p
${FA_Arvioitu_Käyttöikä}               css=#feature-attributes-form > div > div > div:nth-child(25) > p