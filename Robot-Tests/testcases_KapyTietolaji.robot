*** Settings ***
Documentation       Käpy tietolajin testit
Resource            common_keywords.robot

Suite Setup         Login To DigiRoad
Suite Teardown      Close Browser

Test Setup          Testin Aloitus



*** Test Cases ***
Kapy 1
    [Tags]              Kapy
    [Documentation]     Selain: ${BROWSER}
    KW_KapyTietolaji.Kapy_1  ${TL_Käpy_tietolaji_RB}  6822717, 328469

Kapy 2
    [Tags]              Kapy
    [Documentation]     Selain: ${BROWSER}
    KW_KapyTietolaji.Kapy_2  ${TL_Käpy_tietolaji_RB}  6822717, 328469