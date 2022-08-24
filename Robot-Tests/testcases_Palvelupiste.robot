#2022    Joni Laari      Sitowise Oy

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
    ...  - Tarkistetaan kaikki eri tyyppiset palvelupisteet
    KW_Palvelupiste.Palvelupiste_2  6761477, 427461  ${PP_Pysäköintitalo}    Pysäköintitalo
    KW_Palvelupiste.Palvelupiste_2  6900791, 434121  ${PP_Pysäköintialue}    Pysäköintialue
    KW_Palvelupiste.Palvelupiste_2  6901701, 435308  ${PP_Merkittävä_Rautatieasema}           Merkittävä rautatieasema
    KW_Palvelupiste.Palvelupiste_2  6745819, 478333  ${PP_Vähäisempi_Rautatieasema}    Vähäisempi rautatieasema
    KW_Palvelupiste.Palvelupiste_2  6679260, 393880  ${PP_Metroasema}       Maanalainen/metroasema
    KW_Palvelupiste.Palvelupiste_2  6879737, 375234  ${PP_Linja_Auto_Asema}    Linja-autoasema
    KW_Palvelupiste.Palvelupiste_2  6688632, 387709  ${PP_Lentokenttä}          Lentokenttä
    KW_Palvelupiste.Palvelupiste_2  6671396, 387254  ${PP_Laivaterminaali}      Laivaterminaali
    KW_Palvelupiste.Palvelupiste_2  6671385, 387269  ${PP_Taksiasema}      Taksiasema
    KW_Palvelupiste.Palvelupiste_2  6714733, 504191  ${PP_Lepoalue}         Lepoalue
    #TODO
    KW_Palvelupiste.Palvelupiste_2  6688614, 387718  ${PP_Tulli}    Tulli
    KW_Palvelupiste.Palvelupiste_2  6719166, 547657  ${PP_Rajanylityspaikka}          Rajanylityspaikka
    #KW_Palvelupiste.Palvelupiste_2  6638302, 272758  ${PP_Lastausterminaali}      Autojen lastausterminaali
    KW_Palvelupiste.Palvelupiste_2  6718817, 546054  ${PP_LA_KA_pysäköinti}      Linja- ja kuorma-autojen pysäköintialue
    #KW_Palvelupiste.Palvelupiste_2  6670510, 385928  ${PP_Tierumpu}         Tierumpu
    #KW_Palvelupiste.Palvelupiste_2  6714733, 504191  ${PP_E18_Rekkaparkki}      E18 rekkaparkki


Palvelupiste_case_3
    [Tags]              Palvelupiste  AWS
    [Documentation]     Palvelupiste, selain: ${BROWSER}
    ...  
    #KW_Palvelupiste.Palvelupiste_3  6899607, 433900

    KW_Palvelupiste.Palvelupiste_3  6899607, 433900  ${PP_Pysäköintitalo}    Pysäköintitalo
    KW_Palvelupiste.Palvelupiste_3  6899607, 433900  ${PP_Pysäköintialue}    Pysäköintialue
    KW_Palvelupiste.Palvelupiste_3  6899607, 433900  ${PP_Merkittävä_Rautatieasema}           Rautatieasema
    KW_Palvelupiste.Palvelupiste_3  6899607, 433900  ${PP_Vähäisempi_Rautatieasema}           Rautatieasema
    KW_Palvelupiste.Palvelupiste_3  6899607, 433900  ${PP_Linja_Auto_Asema}    Linja-autoasema
    KW_Palvelupiste.Palvelupiste_3  6899607, 433900  ${PP_Lentokenttä}          Lentokenttä
    KW_Palvelupiste.Palvelupiste_3  6899607, 433900  ${PP_Laivaterminaali}      Laivaterminaali
    KW_Palvelupiste.Palvelupiste_3  6899607, 433900  ${PP_Taksiasema}      Taksiasema
    KW_Palvelupiste.Palvelupiste_3  6899607, 433900  ${PP_Lepoalue}         Lepoalue
    #TODO
    KW_Palvelupiste.Palvelupiste_3  6899607, 433900  ${PP_Tulli}    Tulli
    KW_Palvelupiste.Palvelupiste_3  6899607, 433900  ${PP_Rajanylityspaikka}          Rajanylityspaikka
    KW_Palvelupiste.Palvelupiste_3  6899607, 433900  ${PP_Lastausterminaali}      "Autojen lastausterminaali"   #kokeillaan auttavatko heittomerkit 24.8.22
    KW_Palvelupiste.Palvelupiste_3  6899607, 433900  ${PP_LA_KA_pysäköinti}      Linja- ja kuorma-autojen pysäköintialue
    KW_Palvelupiste.Palvelupiste_2  6670510, 385928  ${PP_Tierumpu}         Tierumpu
    #KW_Palvelupiste.Palvelupiste_2  6714733, 504191  ${PP_E18_Rekkaparkki}      E18 rekkaparkki


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