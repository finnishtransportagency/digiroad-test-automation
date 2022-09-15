#2022       Joni Laari      Sitowise Oy

*** Settings ***
Documentation       Pageobject for Traffic signs (Palvelupiste)
Resource    common_keywords.robot

*** Keywords ***

Palvelupiste_1  [arguments]  ${testipaikka}  ${Pisteen_tyyppi}  ${Pisteen_teksti}
    log  Luodaan uusi Palvelupiste, Täytetään kaikki kentät
    Siirry Testipaikkaan  ${TL_Palvelupiste_RB}  ${Testipaikka}
    Odota sivun latautuminen
    Alusta Testipaikka

    Log  Alustetaan testipaikka uusiksi. Tarkistetaan, että Palvelupiste näkyy oikeassa kategoriassa.
    Siirry Muokkaustilaan
    Click Element                               ${Muokkaustila_AddTool}
    Click Element At Coordinates                ${Kartta}   0   20
    Wait Until Element Is Visible               css=.form-control
    Click Element                               css=.form-control
    Click Element                               ${PP_Pysäköintialue}
    Click Element                               ${PP_Alityyppi_Perusvarustelu}
    Input Text                                  css=.form-control.service-name  ${Pisteen_teksti}
    Input Text                                  css=.form-control.large-input   ${Pisteen_teksti}
    Input Text                                  css=.form-control.service-parking-place-count   300
    Click Element                               ${FA_footer_Tallenna}
    Siirry Katselutilaan
    Click Element At Coordinates                ${Kartta}   0   20
    ${date}=  Get Current Date                  result_format=%d.%m.%Y
    Wait Until Element Is Visible               ${FA_otsikko}
    Tarkista Palvelupisteen Kentät              ${date}
    Alusta Testipaikka


Palvelupiste_2  [Arguments]  ${testipaikka}  ${Pisteen_tyyppi}  ${Pisteen_teksti}
    Testin Aloitus
    log  Paikannetaan Palvelupiste. Tarkistetaan palvelupisteen tyyppi.
    Siirry Testipaikkaan                        ${TL_Palvelupiste_RB}  ${testipaikka}
    Odota sivun latautuminen

    Click Element At Coordinates                ${Kartta}  0  20
    Wait Until Element Is Visible               ${FA_otsikko}
    Element Should Contain                      css=#feature-attributes-form  ${Pisteen_teksti}


Palvelupiste_3  [Arguments]  ${testipaikka}  ${Pisteen_tyyppi}  ${Pisteen_teksti}
    log  Luodaan uusi Palvelupiste, Täytetään kaikki kentät
    Siirry Testipaikkaan  ${TL_Palvelupiste_RB}  ${Testipaikka}
    Odota sivun latautuminen
    Alusta Testipaikka

    Log  Alustetaan testipaikka uusiksi. Tarkistetaan, että Palvelupiste näkyy oikeassa kategoriassa.
    Siirry Muokkaustilaan
    Click Element                               ${Muokkaustila_AddTool}
    Wait Until Element Is Enabled               ${Kartta}
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
    Zoomaa kartta                               5   50 m
    Wait Until Element Is Visible               ${FA_Poista_chkbx}
    Click Element                               ${FA_Poista_chkbx}
    Click Element                               ${FA_footer_Tallenna}
    Siirry Katselutilaan
    Alusta Testipaikka


Palvelupiste_4  [Arguments]  ${Testipaikka}    ${Pisteen_tyyppi}  ${Pisteen_teksti}
    Siirry Testipaikkaan  ${TL_Palvelupiste_RB}  ${Testipaikka}
    Odota sivun latautuminen
    Alusta Testipaikka

    Log  Palvelupistettä ei voi lisätä muokkaustyökalulla. Rivi:779
    Siirry Muokkaustilaan
    Click Element At Coordinates            ${Kartta}  0  50
    Repeat Keyword  10 s  Element Should Not Be Visible  ${FA_otsikko}

    Log  Tarkistetaan, että lisäystyökalu toimii edellisestä huolimatta
    Click Element                               ${Muokkaustila_AddTool}
    Click Element                               ${zoombar_minus}
    Wait Until Element Is Enabled               ${Kartta}
    Click Element At Coordinates                ${Kartta}   0   20
    Wait Until Element Is Visible               css=.form-control
    Click Element                               css=.form-control
    Click Element                               ${Pisteen_tyyppi}
    Input Text                                  css=.form-control.large-input   ${Pisteen_teksti}

    Click Element                               ${FA_footer_Tallenna}
    Wait Until Element Is Not Visible           css=.spinner-overlay.modal-overlay
    Click Element                               ${Muokkaustila_SelectTool}
    Click Element At Coordinates                ${Kartta}   0   20
    Wait Until Element Is Visible               ${FA_Poista_chkbx}
    Click Element                               ${FA_Poista_chkbx}
    Click Element                               ${FA_footer_Tallenna}
    Siirry Katselutilaan
    Alusta Testipaikka


#######################
## Sisäiset keywordit #
#######################

Tarkista Palvelupisteen Kentät  
    [Arguments]  ${date}
    Element Should Contain                      ${FA_Lisätty_Järjestelmään}  ${date}

*** Variables ***
${PP_Pysäköintitalo}            css=.form-control option[data-value="pysakointitalo"]
${PP_Pysäköintialue}            css=.form-control option[data-value="pysakointialue"]
${PP_Merkittävä_Rautatieasema}  css=.form-control.select-service-type-extension option[data-value="merkittava-rautatieasema"]
${PP_Vähäisempi_Rautatieasema}  css=.form-control.select-service-type-extension option[data-value="vahaisempi-rautatieasema"]
${PP_Metroasema}                css=.form-control.select-service-type-extension option[data-value="maanalainen/metroasema"]
${PP_Linja_Auto_Asema}          css=.form-control option[data-value="linja-autoasema"]
${PP_Lentokenttä}               css=.form-control option[data-value="lentokentta"]
${PP_Laivaterminaali}           css=.form-control option[data-value="laivaterminaali"]
${PP_Taksiasema}                css=.form-control option[data-value="taksiasema"]
${PP_Lepoalue}                  css=.form-control option[data-value="lepoalue"]
${PP_Tulli}                     css=.form-control option[data-value="tulli"]
${PP_Rajanylityspaikka}         css=.form-control option[data-value="rajanylityspaikka"]
${PP_Lastausterminaali}         css=.form-control option[data-value="autojen-lastausterminaali"]
${PP_LA_KA_pysäköinti}          css=.form-control option[data-value="linja-ja-kuorma-autojen-pysakointialue"]
${PP_Tierumpu}                  css=.form-control option[data-value="tierumpu"]
${PP_E18_Rekkaparkki}           css=.form-control option[data-value="e18-rekkaparkki"]

@{PP_lista}  
...     ${PP_Pysäköintitalo}  ${PP_Pysäköintialue}  ${PP_Merkittävä_Rautatieasema}
...     ${PP_Vähäisempi_Rautatieasema}  ${PP_Metroasema}  ${PP_Linja_Auto_Asema}
...     ${PP_Lentokenttä}  ${PP_Laivaterminaali}  ${PP_Taksiasema}  ${PP_Lepoalue}
...     ${PP_Tulli}  ${PP_Rajanylityspaikka}..${PP_Lastausterminaali}  ${PP_Lastausterminaali}
...     ${PP_LA_KA_pysäköinti}  ${PP_Tierumpu}  ${PP_E18_Rekkaparkki}


#####################
### Pisteen kentät ###
#####################

${PP_Alityyppi_Tarkenne}                        css=.form-control.select-service-type-extension option
${PP_Alityyppi_Perusvarustelu}                    css=.form-control.select-service-type-extension option[data-value="perusvarustelu"]