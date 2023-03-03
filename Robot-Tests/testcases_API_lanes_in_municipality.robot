*** Settings ***
Documentation       API testitapaukset lanes-in-Municipality
Resource            common_keywords.robot
Resource            API_keywords.robot

Suite Setup     Init Session
Suite Teardown  Close Browser


*** Test Cases ***
Kaista_kunta_get
    [Tags]              API  Kaistarajapinta

    [Documentation]     tehdään GET pyyntö
    API_KW_lanes_in_municipality.Kaista_kunta_get    6678559, 373156