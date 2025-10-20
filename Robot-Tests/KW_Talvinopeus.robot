#Joni Laari    Sitowise    2024
*** Settings ***
Documentation        Pageobject for winter speed limit (talvinopeusrajoitus)
Resource    common_keywords.robot


*** Keywords ***
Talvinopeus Perustestit    [arguments]    ${testipaikka}
    Testin Aloitus
    Vaihda Tietolaji    ${TL_Talvinopeusrajoitus_RB}
    Paikanna Osoite    ${testipaikka}
    Odota Sivun Latautuminen
    Click Center Of The Map And Wait For Locator    ${FA_otsikko}
    # Tarkistetaan, että tielinkkien lukumäärä on yli 1, koska klikattiin tietä kerran.
    # Pitäisi siis antaa koko tie eikä osio.
    Tielinkkien Lukumäärän Tulee Olla Näkyvissä ja Yli 1
    Click Element At Coordinates    ${Kartta}    100    0
    Click Element At Coordinates    ${Kartta}    0    20
    Wait Until Element Is Visible    ${FA_otsikko}
    Wait Until Element Is Visible    ${FA_linkkien_lukumaara}
    Tielinkkien Lukumäärän Tulee Olla Näkyvissä ja Yli 1
    Log  Säilytä nopeusrajoitusvalinta, kun siirrytään muokkaustilaan
    ${id} =    Get Text    ${FA_otsikko}
    Siirry Muokkaustilaan
    Element Should Contain    ${FA_otsikko}    ${id}
    Log  Tarkistaa, että nopeusrajoitukset ovat laskevassa järjestyksessä.
    Click Element    ${Popup_TalviNopeusRajoitus}
    FOR    ${i}    IN RANGE    2    5
        ${n} =    Evaluate    ${i}-1
        Element Should Contain
        ...    xpath=/html/body/div[1]/div[2]/main/article/div/div/div[4]/div/div/div[3]/select  ${Talvinopeusrajoitukset}[${n}]
        Click Element
        ...    css=#feature-attributes-form > div > div > div.form-elements-container > div > div > div.input-unit-combination > select option:nth-child(${n})
        Capture Page Screenshot
    END
    Click Element    ${FA_footer_Peruuta}
    Sleep    5 s
    Element Should Not Be Visible    ${FA_otsikko}
    Log    Nopeusrajoitusten kohdalla näkyy teksti:"Zoomaa lähemmäksi, jos haluat nähdä kohteita".
    Click Element    ${zoombar_minus}
    Element Should Be Visible    ${Map_popup}
    Element Should Contain    ${Map_popup}    ${Zoom_popup_context}
    Odota Sivun Latautuminen
    Click Element At Coordinates    ${Kartta}    0    20
    Repeat Keyword    10 s    Element Should Not Be Visible    ${FA_otsikko}


Tielinkkien Lukumäärän Tulee Olla Näkyvissä ja Yli 1
    ${koko_kinkkien_lkm_teksti} =    Get Text    ${FA_linkkien_lukumaara}
    ${linkkien_lkm} =   Split String    ${koko_kinkkien_lkm_teksti}    ${empty}
    ${linkkien_lkm}    Set Variable    ${linkkien_lkm[-1]}
    Builtin.Should Be True    ${linkkien_lkm} > 1


Talvinopeusrajoitus Monivalinta    [Arguments]    ${testipaikka}    @{talvinopeudet_lista}
    Testin Aloitus
    Paikanna Osoite    ${testipaikka}
    Vaihda Tietolaji    ${TL_Talvinopeusrajoitus_RB}
    Siirry Muokkaustilaan
    Wait Until Element Is Enabled    ${Muokkaustila_PolygonTool}
    Click Element    ${Muokkaustila_PolygonTool}
    Suorita Monivalinta
    Wait Until Element Is Visible    ${Popup_valikko_talvinopeus}
    Element Should Be Enabled    ${FA_header_Tallenna}
    # Teemu 23.9.2025. Vaihdettu siten että asetetaan nopeudeksi ensin 100 jotta testi toimii useamman kerran peräkkäin.
    Click Element    css=input[class*='winter-speed-limits'][value='enabled']
    Select From List By Value    css=select[class*='winter-speed-limits']    100
    Tallenna Dialogista
    #Click Element                               ${FA_header_Peruuta}
    Siirry Katselutilaan
    Sleep    1 s
    Click Center Of The Map And Wait For Locator    ${FA_Talvinopeusrajoitus}
    # Click Element at Coordinates                ${Kartta}  0  20
    Wait Until Element Contains    ${FA_Talvinopeusrajoitus}  100 km/h    timeout=10
    Log  Ei voi aloittaa monivalintaa, jos on muokannut jotain toista nopeusrajoitusta ensin 206.118
    Siirry Muokkaustilaan
    Click Element    ${Popup_TalviNopeusRajoitus}
    Select From List By Value    css=select[class*='winter-speed-limits']    70
    Click Element    css=.${TL_Talvinopeusrajoitus_RB} .polygon
    Click Element At Coordinates    ${Kartta}    100    100
    Wait Until Element Is Visible    ${MuokkausVaroitus}
    Wait Until Element Is Not Visible    ${Map_popup}
    Click Element    ${Muokkausvaroitus_Sulje_btn}
    Click Element    ${FA_footer_Peruuta}
    Log    Talletetaan rajoitus monivalintatyökalulla.
    Click Element    css=.${TL_Talvinopeusrajoitus_RB} .polygon
    Suorita Monivalinta
    Select Radio Button    winter-speed-limits    enabled
    Click Element    ${Popup_TalviNopeusRajoitus_DDM}
    Tallenna Dialogista
    Odota Sivun Latautuminen
    Log    Tarkistetaan edellinen talletus, sekä asetetaan rajoitus\=60 km/h
    Siirry Katselutilaan
    Click Center Of The Map And Wait For Locator    ${FA_otsikko}
    Element Should Contain    ${FA_Talvinopeusrajoitus}    100 km/h
    Siirry Muokkaustilaan
    Click Element    css=.${TL_Talvinopeusrajoitus_RB} .polygon
    Suorita Monivalinta
    Select Radio Button    winter-speed-limits    enabled
    Select From List By Value    css=select[class*='winter-speed-limits']    60
    Tallenna Dialogista
    Odota Sivun Latautuminen
    Log    Tarkistetaan edellinen talletus, sekä asetetaan rajoitus\=60 km/h
    Siirry Katselutilaan
    Click Center Of The Map And Wait For Locator    ${FA_otsikko}
    Element Should Contain    ${FA_Talvinopeusrajoitus}    60 km/h


Talvinopeusrajoituksen Katkaisu    [Arguments]    ${testipaikka}
    Testin Aloitus
    Log    Testataan talvinopeusrajoituksen katkaisu.
    Paikanna Osoite    ${testipaikka}
    Vaihda Tietolaji    ${TL_Talvinopeusrajoitus_RB}
    Zoomaa Kartta    5    50 m
    Siirry Muokkaustilaan
    Log    Leikataan rajoitus kahteen osaan 206.86
    Log    Katkaisun jälkeen peruuta-nappi toimii 206.91
    Element Should Be Visible    css=.winterSpeedlimits .cut
    Click Element    css=.winterSpeedlimits .cut
    Click Center Of The Map And Wait For Locator    css=#feature-attributes-header > span.edit-mode-title
    Click Element    ${FA_footer_Peruuta}
    Log    Katkaisun jälkeen peruuta-napin painalluksen jälkeen katkaisutyökalu jää käyttöön
    Element Should Be Visible    css=.winterSpeedlimits .cut.active
    Log    Katkaisun jälkeen peruuta-napin painalluksen jälkeen yksittäisen nopeusrajoituksen valinta poistuu 206.93
    Element Should Not Be Visible    css=.edit-mode-title
    Click Element At Coordinates    ${Kartta}    0    10
    Wait Until Element Is Visible    css=#feature-attributes-form > div > div > div.form-elements-container > div:nth-child(1)
    Select Radio Button    ${FA_Talvinopeusrajoitus_A}    enabled
    Radio Button Should Be Set To    ${FA_Talvinopeusrajoitus_A}    enabled
    Select Radio Button    ${FA_Talvinopeusrajoitus_B}    enabled
    Radio Button Should Be Set To    ${FA_Talvinopeusrajoitus_B}    enabled
    Log  "Olet muokannut.." -dialogi jos katkaisun jälkeen klikkaa karttaa ennen tallennusta 206.104
    Click Element At Coordinates    ${Kartta}    -100    -100
    Wait Until Element Is Visible    ${MuokkausVaroitus}
    Element Should Contain    ${MuokkausVaroitus}  ${MuokkausVaroitus_teksti}
    Click Element    ${Muokkausvaroitus_Sulje_btn}
    Click Element    ${FA_footer_Peruuta}
    Wait Until Element Is Not Visible    ${Spinner_Overlay}
    Odota Sivun Latautuminen
    Log    Yhden linkin mittaisen nopeusrajoituksen katkaisun ja tallennuksen jälkeen valintatyökalu jää aktiiviseksi, 206.101
    Element Should Be Visible    css=.panel-group:not([style="display: none;"]) .action.select.action
    Siirry Katselutilaan
    Log    Yhden linkin mittaisen nopeusrajoituksen katkaisun jälkeen uudet nopeusrajoituspätkien arvot ovat muokattavissa 206.102
    Click Element At Coordinates    ${Kartta}    10    0
    Wait Until Element Is Visible    css=#feature-attributes-header > span
    Element Should Contain    ${FA_Talvinopeusrajoitus}    80 km/h
    Siirry Muokkaustilaan
    Click Element    ${Popup_TalviNopeusRajoitus}
    Click Element    css=#feature-attributes-form > div > div > div.form-elements-container > div > div > div.input-unit-combination > select > option:nth-child(1)
    Press Keys    None    Enter
    Odota Sivun Latautuminen
    Click Element    ${FA_footer_Peruuta}
    Wait Until Element Is Not Visible    ${Spinner_Overlay}
    Odota Sivun Latautuminen
    Siirry Katselutilaan
    Click Element At Coordinates    ${Kartta}    0    40
    Click Element At Coordinates    ${Kartta}    200    200
    Wait Until Element Is Not Visible    ${Spinner_Overlay}
    Odota Sivun Latautuminen
    Log    Valittaessa nopeusrajoituksen ominaisuustietonäkymässä näkyy nopeusrajoituksen ID, lisäys ja muokkaus tiedot. 206.30
    Click Center Of The Map And Wait For Locator    ${FA_otsikko}


Talvinopeusrajoitus Kaksisuuntaiseksi    [Arguments]    ${testipaikka}
    Testin Aloitus
    Vaihda Tietolaji    ${TL_Talvinopeusrajoitus_RB}
    Paikanna Osoite    ${testipaikka}
    Zoomaa Kartta    10    5 m
    Siirry Muokkaustilaan
    Odota Sivun Latautuminen
    Click Center Of The Map And Wait For Locator    ${FA_otsikko}
    Element Should Be Visible    ${FA_Jaa_Nopeusrajoitus}
    Log    Peruuta-painike peruuttaa molempisuuntaisen nopeusrajoituksen jaon, rivi:290
    Click Element    ${FA_Jaa_Nopeusrajoitus}
    Click Element    ${FA_Talvinopeusrajoitus_A}
    Click Element    ${FA_Talvinopeusrajoitus_A_DDM}
    Click Element    ${FA_Talvinopeusrajoitus_B}
    Click Element    ${FA_Talvinopeusrajoitus_B_DDM}
    Click Element    ${FA_footer_Peruuta}
    Click Center Of The Map And Wait For Locator    ${FA_otsikko}
    Log
    ...    Kaksisuuntaiseksi jaettua nopeusrajoitusta ei voi tallentaa, jos molemmilla nopeusrajoituksilla on sama rajoitusarvo, rivi:289, BUGI talletuksen voitehdä.
    Click Element    ${FA_Jaa_Nopeusrajoitus}
    Element Should Be Visible    css=.save[disabled]
    Log    Painetaan tallennus nappia, mitään ei pitäisi tapahtua.
    Click Element    ${FA_footer_Tallenna}
    Log    "Jaa nopeusrajoitus kaksisuuntaiseksi"-painike luo kartalle nopeusrajoituksen kohdalle kaksi erisuuntaista nopeusrajoitusta Rivi 288
    Click Element    ${FA_Talvinopeusrajoitus_A}
    Click Element    ${FA_Talvinopeusrajoitus_A_DDM}
    Click Element    ${FA_Talvinopeusrajoitus_B}
    Click Element    ${FA_Talvinopeusrajoitus_B_DDM}
    Click Element    ${FA_footer_Peruuta}
    Wait Until Element Is Not Visible    ${Spinner_Overlay}
    Odota Sivun Latautuminen
    Siirry Katselutilaan
    Click Center Of The Map And Wait For Locator    ${FA_otsikko}
    Element Should Contain    ${FA_Talvinopeusrajoitus}    80 km/h


Get Default Link Number Value
# Hae odotusarvo (esim. vähintään odotettavissa oleva linkkien määrä)
    #${expected_min}=   Get Expected Link Count From API    ${testipaikka}
    ${expected_min} =    Set Variable    1


Minimum Link Number Value     [Arguments]    ${expected_min}
    # 1) Vähintään-arvo (hierarkiassa sallitaan suurempi luku)
    Wait Until Keyword Succeeds    1 min    5 s
    ...    FlexibleAssertAtLeast    ${FA_linkkien_lukumaara}    ${expected_min}


Tolerance Of One Link Allowed    [Arguments]    ${expected_min}
    # 2) Toleranssi: sallitaan pieni vaihtelu +-1
    ${actual} =    Get Actual Link Count    ${FA_linkkien_lukumaara}
    FlexibleAssertWithinTolerance    ${actual}    ${expected_min}    tolerance=1


Title Contains Expected Word Nopeusrajoitus
    # 3) Regex/tekstin osuminen: otsikko sisältää odotetun sanan
    Element Should Contain    ${FA_otsikko}    "Nopeusrajoitus"


At least X elements    [Arguments]    ${expected_min}
    # 4) Lisäesimerkki: tarkista että linkkien lista sisältää vähintään X elementtiä
    ${count} =    Get Element Count    css:.link-item
    Should Be True    ${count} >= ${expected_min}    msg=Linkkien määrä liian pieni


# Hae tekstissä oleva numero ja palauta int
Get Actual Link Count
    [Arguments]    ${locator}
    ${text} =    Get Text    ${locator}
    # Etsi ensimmäinen numero tekstistä ja muunna int:ksi
    ${num} =    Evaluate    int(re.search(r'\d+', u"""${text}""").group())    modules=re
    Log    Actual link count parsed: ${num}
    RETURN    ${num}


FlexibleAssertAtLeast
    [Arguments]    ${locator}    ${expected_min}
    ${actual} =    Get Actual Link Count    ${locator}
    ${ok} =    Evaluate    int(${actual}) >= int(${expected_min})
    Should Be True    ${ok}    message=Odotettu vähintään ${expected_min}, saatiin ${actual}


FlexibleAssertWithinTolerance
    [Arguments]    ${actual}    ${expected}    ${tolerance}=1
    ${diff} =    Evaluate    abs(int(${actual}) - int(${expected}))
    ${ok} =     Evaluate    int(${diff}) <= int(${tolerance})
    Should Be True    ${ok}    message=Arvo ${actual} ei ole odotusarvon ${expected} ±${tolerance} (diff=${diff})


*** Variables ***
${aloitussivu}                      css=.panel-group:not([style="display: none;"]) .action.select.action
${Popup_TalviNopeusRajoitus}        css=#feature-attributes-form > div > div > div.form-elements-container > div > div > div.input-unit-combination > select
${Popup_TalviNopeusRajoitus_100}    css=#feature-attributes-form > div > div > div.form-elements-container > div > div > div.input-unit-combination > select option:nth-child(2)
${Popup_TalviNopeusRajoitus_DDM}    css=body > div.container > div.modal-overlay.mass-update-modal > div > div.form-elements-container > div > div > div.input-unit-combination > select
${Popup_valikko_talvinopeus}        css=body > div.container > div.modal-overlay.mass-update-modal > div > div.form-elements-container > div
${FA_Talvinopeusrajoitus}           css=#feature-attributes-form > div > div > div.form-elements-container > div
${FA_Talvinopeusrajoitus_A}         winter-speed-limits-a
${FA_Talvinopeusrajoitus_B}         winter-speed-limits-b
${FA_Talvinopeusrajoitus_A_DDM}     css=#feature-attributes-form > div > div > div.form-elements-container > div:nth-child(1) > div > div.input-unit-combination > select
${FA_Talvinopeusrajoitus_B_DDM}     css=#feature-attributes-form > div > div > div.form-elements-container > div:nth-child(2) > div > div.input-unit-combination > select
