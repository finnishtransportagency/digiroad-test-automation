#2022       Joni Laari      Sitowise Oy

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
    Click Element                               ${PP_Tyyppi}
    Click Element                               ${PP_Alityyppi}
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


Palvelupiste_2  [Arguments]  ${testipaikka}  ${Merkin_tyyppi}  ${Pisteen_teksti}
    Testin Aloitus
    log  Paikannetaan Palvelupiste. Tarkistetaan palvelupisteen tyyppi.
    Siirry Testipaikkaan            ${TL_Palvelupiste_RB}  ${testipaikka}
    #Valitse Kaikki Palvelupisteet
    #Click Element                   ${Merkin_tyyppi}
    Odota sivun latautuminen

    Click Element At Coordinates    ${Kartta}  0  20
    Wait Until Element Is Visible   ${FA_otsikko}
    Element Should Contain          css=#feature-attributes-form  ${Pisteen_teksti}


Palvelupiste_3  [Arguments]  ${testipaikka}  ${Merkin_tyyppi}  ${Pisteen_teksti}
    log  Luodaan uusi Palvelupiste, Täytetään kaikki kentät
    Siirry Testipaikkaan  ${TL_Palvelupiste_RB}  ${Testipaikka}
    #Valitse Kaikki Palvelupisteet
    Odota sivun latautuminen
    Alusta Testipaikka
    #Luo Palvelupiste

    Log  Alustetaan testipaikka uusiksi. Tarkistetaan, että Palvelupiste näkyy oikeassa kategoriassa.
    Siirry Muokkaustilaan
    Click Element                               ${Muokkaustila_AddTool}
    Sleep                                       3
    Click Element At Coordinates                ${Kartta}   0   20
    Wait Until Element Is Visible               css=.form-control
    Click Element                               css=.form-control
    Click Element                               css=.form-control option[data-value= ${Pisteen_teksti}]
    Input Text                                  css=.form-control.large-input   ${Pisteen_teksti}

    Click Element                               ${FA_footer_Tallenna}
    Wait Until Element Is Not Visible           css=.spinner-overlay.modal-overlay
    Click Element                               ${Muokkaustila_SelectTool}
    Click Element At Coordinates                ${Kartta}   0   20
    Click Element                               ${zoombar_minus}
    Siirrä Kohde                                300   0
    Odota sivun latautuminen
    Wait Until Element Is Visible               ${FA_Poista_chkbx}
    Click Element                               ${FA_Poista_chkbx}
    Click Element                               ${FA_footer_Tallenna}
    Siirry Katselutilaan


Palvelupiste_4  [Arguments]  ${Testipaikka}
    Siirry Testipaikkaan  ${TL_Palvelupiste_RB}  ${Testipaikka}
    Odota sivun latautuminen
    Alusta Testipaikka

    Log  Palvelupistettä ei voi lisätä muokkaustyökalulla. Rivi:779
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
    FOR  ${selector}  IN  @{PP_lista}
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
${PP_Pysäköintitalo}            css=.form-control option[data-value="Pysäköintitalo"]
${PP_Pysäköintialue}            css=.form-control option[data-value="Pysäköintialue"]
${PP_Merkittävä_Rautatieasema}  css=.form-control.select-service-type-extension option[data-value="Merkittävä rautatieasema"]
${PP_Vähäisempi_Rautatieasema}  css=.form-control.select-service-type-extension option[data-value="Vähäisempi rautatieasema"]
${PP_Metroasema}                css=.form-control.select-service-type-extension option[data-value="Maanalainen/metroasema"]
${PP_Linja_Auto_Asema}          css=.form-control option[data-value="Linja-autoasema"]
${PP_Lentokenttä}               css=.form-control option[data-value="Lentokenttä"]
${PP_Laivaterminaali}           css=.form-control option[data-value="Laivaterminaali"]
${PP_Taksiasema}                css=.form-control option[data-value="Taksiasema"]
${PP_Lepoalue}                  css=.form-control option[data-value="Lepoalue"]
${PP_Tulli}                     css=.form-control option[data-value="Tulli"]
${PP_Rajanylityspaikka}         css=.form-control option[data-value="Rajanylityspaikka"]
${PP_Lastausterminaali}         css=.form-control option[data-value="Autojen lastausterminaali"]
${PP_LA_KA_pysäköinti}          css=.form-control option[data-value="Linja- ja kuorma-autojen pysäköintialue"]
${PP_Tierumpu}                  css=.form-control option[data-value="Tierumpu"]
${PP_E18_Rekkaparkki}           css=.form-control option[data-value="E18 rekkaparkki"]

@{PP_lista}  
...     ${PP_Pysäköintitalo}  ${PP_Pysäköintialue}  ${PP_Merkittävä_Rautatieasema}
...     ${PP_Vähäisempi_Rautatieasema}  ${PP_Metroasema}  ${PP_Linja_Auto_Asema}
...     ${PP_Lentokenttä}  ${PP_Laivaterminaali}  ${PP_Taksiasema}  ${PP_Lepoalue}
...     ${PP_Tulli}  ${PP_Rajanylityspaikka}..${PP_Lastausterminaali}  ${PP_Lastausterminaali}
...     ${PP_LA_KA_pysäköinti}  ${PP_Tierumpu}  ${PP_E18_Rekkaparkki}

@{Nopeusrajoitukset}
...     20  30  40  50  60  70  80  90  100  120

#####################
### Merkin kentät ###
#####################

#_DMM valitsin on alasvetovalikon valinta.

${PP_Tyyppi_Pysäköinti}                           css=.form-control option[data-value="Pysäköintialue"]
${PP_Tyyppi_DDM_Pysäköinti}                       css=.form-control option[data-value="Pysäköintialue"]
${PP_Alityyppi_Pysäköinti}                        css=.form-control.select-service-type-extension option[data-value="Perusvarustelu"]
${PP_Alityyppi_DDM_Pysäköinti}                    css=.form-control.select-service-type-extension option[data-value="Perusvarustelu"]