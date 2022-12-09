# Antti Salo        Dimenteq Oy     2016
# Kaikki:       pybot -L TRACE -T Digiroad
# Tagin mukaan: pybot -L TRACE -T -i muumi Digiroad

*** Variables ***


*** Settings ***
Documentation       Regression testcases for Digiroad
Resource            common_keywords.robot

Suite Setup         Login To DigiRoad
Suite Teardown      Close Browser

Test Setup          Testin Aloitus

*** Test Cases ***
Käyttöliittymä 1
    [Tags]              UI   AWS
    [Documentation]     Käyttöliittymä, selain: ${BROWSER}
    ...  - Skandinaaviset aakkoset näkyvät oikein
    
    KW_UI.UI_1

Käyttöliittymä 2
    [Tags]              UI   AWS
    [Documentation]     Käyttöliittymä, selain: ${BROWSER}
    ...  - Käyttöohje aukeaa klikkaamalla Käyttöohje-nappulaa.
    KW_UI.UI_2

Käyttöliittymä 3
    [Tags]              UI   AWS
    [Documentation]     Käyttöliittymä, selain: ${BROWSER}
    ...                 - XSSllä ei saa käyttöliittymää rikki.
    KW_UI.UI_3

Käyttöliittymä 4
    [Tags]              UI   AWS
    [Documentation]     Käyttöliittymä, selain: ${BROWSER}
    ...  - Muokkaustilassa "Olet muokkaustilassa..."-teksti sovelluksen yläreunassa
    KW_UI.UI_4

Käyttöliittymä 5_1
    [Tags]              UI   AWS
    [Documentation]     Käyttöliittymä, selain: ${BROWSER}
    ...  - "Sinulla on tallentamattomia..." -dialogi ilmestyy kaikissa tietolajeissa, kun klikkaa muokkauksen jälkeen jotain muuta kuin Tallenna tai Peruuta.
    ...  Testi alasvetolistalta muokattaville aineistoille
    KW_UI.UI_5_ddm

Käyttöliittymä 5_2_1
    [Tags]              UI
    [Documentation]     Käyttöliittymä, selain: ${BROWSER}
    ...  - "Sinulla on tallentamattomia..." -dialogi ilmestyy kaikissa tietolajeissa, kun klikkaa muokkauksen jälkeen jotain muuta kuin Tallenna tai Peruuta.
    ...  - Testi radiobuttonilla muokattaville aineistoille, joissa FA_locator = form-group
    KW_UI.UI_5_radio_non-unit  @{Tietolajit_radio_non-unit}

Käyttöliittymä 5_2_2
    [Tags]              UI   AWS
    [Documentation]     Käyttöliittymä, selain: ${BROWSER}
    ...  - "Sinulla on tallentamattomia..." -dialogi ilmestyy kaikissa tietolajeissa, kun klikkaa muokkauksen jälkeen jotain muuta kuin Tallenna tai Peruuta.
    ...  - Testi radiobuttonilla muokattaville aineistoille, joisa FA_locator = form-group-unit
    KW_UI.UI_5_radio_unit  @{Tietolajit_radio_unit}

Käyttöliittymä 5_3
    [Tags]              UI
    [Documentation]     Käyttöliittymä, selain: ${BROWSER}
    ...  - "Sinulla on tallentamattomia..." -dialogi ilmestyy kaikissa tietolajeissa, kun klikkaa muokkauksen jälkeen jotain muuta kuin Tallenna tai Peruuta.
    ...  Testi checkboxilla  muokattaville aineistoille
    ...  Tarkistaa tietolajien avautuvan, ei yritä muokata niitä
    Log  Testille annetaan parametrina tietolaji ja paikka jossa se testataan (osoite tai koordinaatti)
    KW_UI.UI_5_chkbx            ${TL_Suojatie_RB}                  7477738, 483051
    KW_UI.UI_5_chkbx            ${TL_Liikennevalo_RB}              7047864, 509469
    KW_UI.UI_5_chkbx            ${TL_Joukkoliikenteen_pysäkki_RB}  6711145, 240049
    KW_UI.UI_5_chkbx            ${TL_Palvelupiste_RB}              6711455, 239920
    KW_UI.UI_5_chkbx            ${TL_Rautatien_tasoristeys_RB}     6712202, 240424
    KW_UI.UI_5_chkbx            ${TL_Esterakennelma_RB}            6711849, 240709
    KW_UI.UI_5_chkbx            ${TL_Opastustaulu_RB}              6738104, 251253

Käyttöliittymä 5_4
    [Tags]              UI   AWS
    [Documentation]     Käyttöliittymä, selain: ${BROWSER}
    ...  - "Sinulla on tallentamattomia..." -dialogi ilmestyy kaikissa tietolajeissa, kun klikkaa muokkauksen jälkeen jotain muuta kuin Tallenna tai Peruuta.
    ...  Testi napilla  muokattaville aineistoille
    KW_UI.UI_5_Button  ${TL_Kääntymisrajoitus_RB}  brahenkatu 10, turku

Käyttöliittymä 6
    [Tags]              UI   AWS
    [Documentation]     Käyttöliittymä, selain: ${BROWSER}
    ...  - Usean kohteen valinta kerralla muokattavaksi
    KW_UI.UI_6
