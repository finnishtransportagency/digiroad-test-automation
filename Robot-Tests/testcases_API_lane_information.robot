#    Joni Laari        Sitowise        2023

*** Settings ***
Documentation       API testitapaukset lane_information
Resource            common_keywords.robot
Resource            API_keywords.robot

Suite Setup     Init Session
Suite Teardown  Close All Browsers


*** Test Cases ***
Kaista_tieto_get
    [Tags]              API  Kaistarajapinta

    [Documentation]     Suoritetaan GET-pyyntö rajapinnasta ja verrataan UI:n tuloksiin
    API_KW_lane_information.Kaista_tieto_get    6893503, 443782    664