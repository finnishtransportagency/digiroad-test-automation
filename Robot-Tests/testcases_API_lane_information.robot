#    Joni Laari        Sitowise        2023

*** Settings ***
Documentation       API testitapaukset lanes-in-Municipality
Resource            common_keywords.robot
Resource            API_keywords.robot

Suite Setup     Init Session
Suite Teardown  Close Browser


*** Test Cases ***
Kaista_tieto_get
    [Tags]              API  Kaistarajapinta

    [Documentation]     Suoritetaan GET-pyyntö rajapinnasta ja verrataan UI:n tuloksiin
    API_KW_lane_information.Kaista_tieto_get