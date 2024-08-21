*** Settings ***
Documentation       VAK tietolajin testit
Resource            common_keywords.robot

Suite Setup         Login To DigiRoad
Suite Teardown      Close Browser

Test Setup          Testin Aloitus



*** Test Cases ***
VAK 1
    [Tags]              VAK
    [Documentation]     Selain: ${BROWSER}
    KW_VAK.VAK_1  ${TL_VAK-rajoitus_RB}  6821696, 312907