#    Joni Laari        Sitowise        2023

*** Settings ***
Documentation       API testitapaukset lanes-in-Municipality
Resource            common_keywords.robot
Resource            API_keywords.robot

Suite Setup     Init Session
Suite Teardown  Close Browser


*** Test Cases ***
Kaista_kunta_get
    [Tags]              API  Kaistarajapinta

    [Documentation]     Suoritetaan GET-pyyntö rajapinnasta ja verrataan UI:n tuloksiin
    API_KW_lanes_in_municipality.Kaista_kunta_get    ${179_Lohikoskentie_kaistamäärä}    637           179
    API_KW_lanes_in_municipality.Kaista_kunta_get    ${179_Schaumaninpuistotie_kaistamäärä}    46504   179
    API_KW_lanes_in_municipality.Kaista_kunta_get    ${179_Survontie_kaistamäärä}    46555             179
    API_KW_lanes_in_municipality.Kaista_kunta_get    ${179_Keuruuntie_kaistamäärä}    18               179
    API_KW_lanes_in_municipality.Kaista_kunta_get    ${179_Vasarakatu_kaistamäärä}    46508            179

    API_KW_lanes_in_municipality.Kaista_kunta_get    ${286_Kauppalankatu_kaistamäärä}    370    286
    API_KW_lanes_in_municipality.Kaista_kunta_get    ${286_Mikkelintie_kaistamäärä}    15       286
    API_KW_lanes_in_municipality.Kaista_kunta_get    ${286_Jyrääntie_kaistamäärä}    14616      286
    API_KW_lanes_in_municipality.Kaista_kunta_get    ${286_Kalevantie_kaistamäärä}    368       286
    API_KW_lanes_in_municipality.Kaista_kunta_get    ${286_Kymenlaaksontie_kaistamäärä}    367    286


Kaista_kunta_get_ui_vertailu
    [Tags]              API  Kaistarajapinta

    [Documentation]     Suoritetaan GET-pyyntö rajapinnasta ja verrataan UI:n tuloksiin
    API_KW_lanes_in_municipality.Kaista_kunta_get_ui_vertailu    6676844, 371888