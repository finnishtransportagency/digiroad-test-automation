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
    #Ottaa argumentiksi tiennumeron, tienosanumeron sekä kuntanumeron
    API_KW_lanes_in_municipality.Kaista_kunta_get    ${179_Lohikoskentie_kaistamäärä}         637      1        179
    API_KW_lanes_in_municipality.Kaista_kunta_get    ${179_Schaumaninpuistotie_kaistamäärä}    46504  1        179
    API_KW_lanes_in_municipality.Kaista_kunta_get    ${179_Survontie_kaistamäärä}             46555    1        179
    API_KW_lanes_in_municipality.Kaista_kunta_get    ${179_Keuruuntie_kaistamäärä}            18      49        179
    API_KW_lanes_in_municipality.Kaista_kunta_get    ${179_Vasarakatu_kaistamäärä}            46508   3        179

    API_KW_lanes_in_municipality.Kaista_kunta_get    ${286_Kauppalankatu_kaistamäärä}          370        1       286
    API_KW_lanes_in_municipality.Kaista_kunta_get    ${286_Mikkelintie_kaistamäärä}            15         11       286
    API_KW_lanes_in_municipality.Kaista_kunta_get    ${286_Jyrääntie_kaistamäärä}             14616        1       286
    API_KW_lanes_in_municipality.Kaista_kunta_get    ${286_Kalevantie_kaistamäärä}            368         1       286
    API_KW_lanes_in_municipality.Kaista_kunta_get    ${286_Kymenlaaksontie_kaistamäärä}        367        1       286

    API_KW_lanes_in_municipality.Kaista_kunta_get    ${285_Karhulantie_kaistamäärä}            3571       1        285
    API_KW_lanes_in_municipality.Kaista_kunta_get    ${285_Kyminlinnantie_kaistamäärä}         170        1       285
    API_KW_lanes_in_municipality.Kaista_kunta_get    ${285_Kouvolantie_kaistamäärä}            15         1      285
    API_KW_lanes_in_municipality.Kaista_kunta_get    ${285_Tavastilantie_kaistamäärä}          3582       1       285
    API_KW_lanes_in_municipality.Kaista_kunta_get    ${285_Seiskatie_kaistamäärä}              7          1      285

    API_KW_lanes_in_municipality.Kaista_kunta_get    ${508_Hopunmäentie_kaistamäärä}            14337     1      508
    API_KW_lanes_in_municipality.Kaista_kunta_get    ${508_Koskelantie_kaistamäärä}             14338     1      508
    API_KW_lanes_in_municipality.Kaista_kunta_get    ${508_Keuruuntie_kaistamäärä}              348       1      508
    API_KW_lanes_in_municipality.Kaista_kunta_get    ${508_Tehtaantie_kaistamäärä}               14352    1      508
    API_KW_lanes_in_municipality.Kaista_kunta_get    ${508_Orivedentie_kaistamäärä}              58       1      508

    API_KW_lanes_in_municipality.Kaista_kunta_get    ${091_Mannerheimintie_kaistamäärä}         1      1      091
    API_KW_lanes_in_municipality.Kaista_kunta_get    ${091_Länsiväylä_kaistamäärä}              51     3         091
    API_KW_lanes_in_municipality.Kaista_kunta_get    ${091_Kuusisaarentie_kaistamäärä}          40911   1      091
    API_KW_lanes_in_municipality.Kaista_kunta_get    ${091_Vihdintie_kaistamäärä}              14352    2      091
    API_KW_lanes_in_municipality.Kaista_kunta_get    ${091_Myllymestarintie_kaistamäärä}        101      8      091


Kaista_kunta_get_ui_vertailu
    [Tags]              API  Kaistarajapinta

    [Documentation]     Suoritetaan GET-pyyntö rajapinnasta ja verrataan UI:n tuloksiin
    API_KW_lanes_in_municipality.Kaista_kunta_get_ui_vertailu    6676844, 371888