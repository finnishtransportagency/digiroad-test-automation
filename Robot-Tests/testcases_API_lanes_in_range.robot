#    Joni Laari        Sitowise        2023

*** Settings ***
Documentation       API testitapaukset lanes-in-range
Resource            common_keywords.robot
Resource            API_keywords.robot

Suite Setup     Init Session
Suite Teardown  Close Browser


*** Test Cases ***
Kaista_kunta_get
    [Tags]              API  Kaistarajapinta

    [Documentation]     Palauttaa kaistatiedot homogenisoituna kysytyltä tieosoiteväliltä 
    API_KW_lanes_in_range.Kaista_väli_get    ${179_Lohikoskentie_kaistamäärä}         637      1        179