#    Joni Laari        Sitowise        2023

*** Settings ***
Documentation       API testitapaukset lanes-in-Municipality
Resource            common_keywords.robot
Resource            API_keywords.robot

Suite Setup     Init Session
Suite Teardown  Close Browser


*** Test Cases ***
Kaista_kunta_get_ui_vertailu
    [Tags]              API  Kaistarajapinta

    [Documentation]     Suoritetaan GET-pyyntö rajapinnasta ja verrataan UI:n tuloksiin
    API_KW_lanes_in_municipality.Kaista_kunta_get_ui_vertailu    6676844, 371888


Kaista_kunta_get
    [Tags]              API  Kaistarajapinta

    [Documentation]     Suoritetaan GET-pyyntö rajapinnasta ja verrataan UI:n tuloksiin
    API_KW_lanes_in_municipality.Kaista_kunta_get    6676844, 371888