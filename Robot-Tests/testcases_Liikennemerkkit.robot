*** Settings ***
Documentation       Regression testcases for Digiroad
Resource            common_keywords.robot

Suite Setup         Login To DigiRoad
Suite Teardown      Close Browser

Test Setup          Testin Aloitus

*** Test Cases ***
Liikennemerkit 1
    [Tags]              Liikennemerkit  AWS
    [Documentation]     Liikennemerkit, selain: ${BROWSER}
    ...  
    KW_Liikennemerkit.Liikennemerkit 1  7320569, 599457

Liikennemerkit 2
    [Tags]              Liikennemerkit
    [Documentation]     Liikennemerkit, selain: ${BROWSER}
    ...  - Tarkistetaan kaikki eri tyyppiset liikennemerkit
    KW_Liikennemerkit.Liikennemerkit 2  6715386, 243668  ${LM_Varoitusmerkit}   Varoitusmerkit
    KW_Liikennemerkit.Liikennemerkit 2  6905720, 332155  ${LM_Etuajo-oikeus}    Etuajo-oikeus ja väistämismerkit
    KW_Liikennemerkit.Liikennemerkit 2  7320798, 599590  ${LM_Kielto}           Kielto- ja rajoitusmerkit
    KW_Liikennemerkit.Liikennemerkit 2  6905351, 332447  ${LM_Määräysmerkit}    Määräysmerkit
    KW_Liikennemerkit.Liikennemerkit 2  6905900, 332498  ${LM_Sääntömerkit}     Sääntömerkit
    KW_Liikennemerkit.Liikennemerkit 2  6905721, 332155  ${LM_Opastusmerkit}    Opastusmerkit
    KW_Liikennemerkit.Liikennemerkit 2  6905188, 331751  ${LM_Palvelukohteet}   Palvelukohteet
    KW_Liikennemerkit.Liikennemerkit 2  6905591, 332619  ${LM_Muut_merkit}      Muut merkit

Liikennemerkit 3
    [Tags]              Merkki  AWS
    [Documentation]     Liikennemerkit, selain: ${BROWSER}
    ...  
    KW_Liikennemerkit.Liikennemerkit 3  7320569, 599457

Liikennemerkit_4
    [Tags]              Merkki  AWS
    [Documentation]     Liikennemerkit, selain: ${BROWSER}
    ...  
    KW_Liikennemerkit.Liikennemerkit 4  7320574, 599512

Liikennemerkit_5
    [Tags]              Merkki  AWS
    [Documentation]     Liikennemerkit, selain: ${BROWSER}
    ...  Liikennemerkkien perustestit.
    KW_Liikennemerkit.Liikennemerkit 5  7320574, 599512