*** Settings ***
Documentation       Keywords for Suurin Sallittu 
Resource    common_keywords.robot

*** Keywords ***

Massa_1  [arguments]  ${tietolaji}  ${testipaikka}  ${rajoitus}    ${rajoituksen_arvo}
    Testin Aloitus
    Siirry Testipaikkaan                ${tietolaji}  ${testipaikka}
    Zoomaa kartta  5  5 m
    Odota sivun latautuminen
    Click Element At Coordinates        ${Kartta}  0  20
    Wait Until Element Is Visible       ${FA_otsikko}
    ${tunniste}=  Palauta Rajoituksen Tunniste  ${tietolaji}
    Element Should Contain              css=.form-control-static.${tunniste}  ${rajoituksen_arvo}
    Lue Rajoitus on kenttä              ${tietolaji}      ${rajoituksen_arvo}
    Element Should Contain              ${FA_Massarajoitus}  ${rajoitus}

Massa_2  [arguments]  ${tietolaji}  ${testipaikka}  ${rajoitus}
    Siirry Testipaikkaan                ${tietolaji}  ${testipaikka}
    Odota sivun latautuminen
    Click Element At Coordinates        ${Kartta}  0  10
    Wait Until Element Is Visible       ${FA_otsikko}
    Siirry Muokkaustilaan
    ${tunniste}=  Palauta Rajoituksen Tunniste  ${tietolaji}

    #Tarkistetaan onko linkillä kyseinen rajoitus. Nollataan jos on.
    ${status}=  Run Keyword And Return Status  Element Should Be Disabled  id=${tunniste}
    Run Keyword If                      ${status}==False  Nollaa Rajoitus  ${tunniste}
    Run Keyword If                      ${status}==False  Siirry Muokkaustilaan
    Click Element                       css=[value=enabled]
    Input Text                          css=.input-unit-combination [type=text]  ${rajoitus}
    Click Element                       ${FA_footer_Tallenna}
    Wait Until Element Is Not Visible   ${Spinner_Overlay}
    Odota sivun latautuminen
    Siirry Katselutilaan

    #Tarkistetaan rajoituksen sisältö
    Click Element At Coordinates        ${Kartta}  0  20
    Wait Until Element Is Visible       ${FA_otsikko}
    Element Should Contain              css=.form-editable-${tunniste} > div.input-unit-combination > div:nth-child(1) > p  ${rajoitus}
    Siirry Muokkaustilaan
    Nollaa Rajoitus                     ${tunniste}


##########################
### Sisäiset Keywordit ###
##########################

Lue Rajoitus on kenttä  [arguments]  ${tietolaji}      ${rajoituksen_arvo}
    #Ei voitu yhdistää css selektorin kanssa kentän lukua, tehtiin hirveä jossittelu juttu
    IF  '${tietolaji}'=="trailerTruckWeightLimit"
    Element Should Contain  ${FA_Yhdistelmän_Rajoitus}  ${rajoituksen_arvo}
    ELSE IF  '${tietolaji}'=="axleWeightLimit"
    Element Should Contain  ${FA_Akselimassa_rajoitus}  ${rajoituksen_arvo}
    ELSE IF  '${tietolaji}'=="bogieWeightLimit"
    Element Should Contain  ${FA_Telimassa_rajoitus}  ${rajoituksen_arvo}
    ELSE IF  '${tietolaji}'=="heightLimit"
    Element Should Contain  ${FA_Korkeus_rajoitus}  ${rajoituksen_arvo}
    ELSE IF  '${tietolaji}'=="widthLimit"
    Element Should Contain  ${FA_Leveys_rajoitus}  ${rajoituksen_arvo}
    ELSE IF  '${tietolaji}'=="lengthLimit"
    Element Should Contain  ${FA_Pituus_rajoitus}  ${rajoituksen_arvo}
    ELSE IF  '${tietolaji}'=="totalWeightLimit"
    Element Should Contain  ${FA_SuurinSallittu_rajoitus}  ${rajoituksen_arvo}
    END

Palauta Rajoituksen Tunniste  [arguments]  ${tietolaji}
    #Palautetaan if lauseen avulla haluttu selectorin tunnus. Vaaditaan että saadaan kaikki testattua samalla keywordillä.
    IF  '${tietolaji}'=="trailerTruckWeightLimit"
    ${tunniste}=  Set Variable  trailer-truck-weight-limit
    ELSE IF  '${tietolaji}'=="axleWeightLimit"
    ${tunniste}=  Set Variable  axle-weight-limit
    ELSE IF  '${tietolaji}'=="bogieWeightLimit"
    ${tunniste}=  Set Variable  bogie-weight-limit
    ELSE IF  '${tietolaji}'=="heightLimit"
    ${tunniste}=  Set Variable  height-limit
    ELSE IF  '${tietolaji}'=="widthLimit"
    ${tunniste}=  Set Variable  width-limit
    ELSE IF  '${tietolaji}'=="lengthLimit"
    ${tunniste}=  Set Variable  length-limit
    ELSE IF  '${tietolaji}'=="totalWeightLimit"
    ${tunniste}=  Set Variable  total-weight-limit
    END
    [Return]  ${tunniste}

Nollaa Rajoitus  [arguments]  ${tunniste}
    Click Element  css=[value=disabled]
    Click Element   ${FA_footer_Tallenna}
    Wait Until Element Is Not Visible  ${Spinner_Overlay}
    Odota sivun latautuminen
    Siirry Katselutilaan
    Click Element At Coordinates        ${Kartta}  0  20
    Wait Until Element Is Visible  ${FA_otsikko}



*** Variables ***

${FA_SuurinSallittu_Rajoitus}           css=.form-control-static.total-weight-limit
${FA_Yhdistelmän_Rajoitus}              css=.form-control-static.trailer-truck-weight-limit
${FA_Akselimassa_rajoitus}              css=.form-control-static.axle-weight-limit
${FA_Telimassa_rajoitus}                css=.form-control-static.bogie-weight-limit
${FA_Korkeus_rajoitus}                  css=.form-control-static.height-limit
${FA_Leveys_rajoitus}                   css=.form-control-static.width-limit
${FA_Pituus_rajoitus}                   css=.form-control-static.length-limit
${FA_Massarajoitus}                     css=.input-unit-combination :nth-child(1)  .form-control-static
${FA_Muokkaustila_Ei_Rajoitusta}        css=.edit-control-group.choice-group :nth-child(1) label input