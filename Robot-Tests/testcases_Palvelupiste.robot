*** Settings ***
Documentation       Regression testcases for Digiroad
Resource            common_keywords.robot

Suite Setup         Login To DigiRoad
Suite Teardown      Close Browser

Test Setup          Testin Aloitus


*** Test Cases ***
Palvelupiste_case_1
    [Tags]              Palvelupiste  AWS
    [Documentation]     Palvelupiste, selain: ${BROWSER}
    ...  
    KW_Palvelupiste.Palvelupiste_1  6900913, 433458


Palvelupiste_case_2
    [Tags]              Palvelupiste
    [Documentation]     Palvelupiste, selain: ${BROWSER}
    ...  - Tarkistetaan kaikki eri tyyppiset liikennemerkit
    KW_Palvelupiste.Palvelupiste_2  6715396, 243669  ${LM_Varoitusmerkit}   Varoitusmerkit
    KW_Palvelupiste.Palvelupiste_2  7329634, 568664  ${LM_Etuajo-oikeus}    Etuajo-oikeus ja väistämismerkit
    KW_Palvelupiste.Palvelupiste_2  7320804, 599586  ${LM_Kielto}           Kielto- ja rajoitusmerkit
    KW_Palvelupiste.Palvelupiste_2  7329642, 568698  ${LM_Määräysmerkit}    Määräysmerkit
    KW_Palvelupiste.Palvelupiste_2  7320090, 598967  ${LM_Sääntömerkit}     Sääntömerkit
    KW_Palvelupiste.Palvelupiste_2  7252914, 514594  ${LM_Opastusmerkit}    Opastusmerkit
    KW_Palvelupiste.Palvelupiste_2  6797931, 339406  ${LM_Palvelukohteet}   Palvelukohteet
    KW_Palvelupiste.Palvelupiste_2  6670510, 385928  ${LM_Muut_merkit}      Muut merkit


Palvelupiste_case_3
    [Tags]              Palvelupiste  AWS
    [Documentation]     Palvelupiste, selain: ${BROWSER}
    ...  
    KW_Palvelupiste.Palvelupiste_3  7320569, 599457


Palvelupiste_case_4
    [Tags]              Palvelupiste  AWS
    [Documentation]     Palvelupiste, selain: ${BROWSER}
    ...  
    KW_Palvelupiste.Palvelupiste_4  7320574, 599512


Palvelupiste_case_5
    [Tags]              Palvelupiste  AWS
    [Documentation]     Palvelupiste, selain: ${BROWSER}
    ...  Liikennemerkkien perustestit.
    KW_Palvelupiste.Palvelupiste_5  7320574, 599512