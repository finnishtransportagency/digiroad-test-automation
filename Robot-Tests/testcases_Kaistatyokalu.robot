*** Settings ***
Documentation       Regression testcases for Digiroad
Resource            common_keywords.robot

Suite Setup         Login To DigiRoad
Suite Teardown      Close Browser

Test Setup          Testin Aloitus

*** Test Cases ***
Kaistatyökalu 1
    [Tags]              AWS
    [Documentation]     Liikennemerkit, selain: ${BROWSER}
    KW_Kaistatyokalu.Kaistatyökalu_1  6805688, 331942

Kaistatyökalu 2
    [Tags]              AWS
    [Documentation]     Liikennemerkit, selain: ${BROWSER}
    KW_Kaistatyokalu.Kaistatyökalu_2  6805688, 331942