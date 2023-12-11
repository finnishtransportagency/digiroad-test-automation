*** Settings ***
Documentation       Testit Pysäköintikiellolle
Resource            common_keywords.robot

Suite Setup         Login To DigiRoad
Suite Teardown      Close Browser

Test Setup          Testin Aloitus



*** Test Cases ***
Pysäköintikielto 1
    [Tags]              Pysakointikielto
    [Documentation]     Pysakointikielto, selain: ${BROWSER}
    KW_Pysakointikielto.Pysakointi_1  ${TL_Pysäköintikielto_RB}  6939647, 349559

Pysäköintikielto 2
    [Tags]              Pysakointikielto
    [Documentation]     Pysakointikielto, selain: ${BROWSER}
    KW_Pysakointikielto.Pysakointi_2  ${TL_Pysäköintikielto_RB}  6939647, 349559

Pysäköintikielto 3
    [Tags]              Pysakointikielto
    [Documentation]     Pysakointikielto, selain: ${BROWSER}
    KW_Pysakointikielto.Pysakointi_3  ${TL_Pysäköintikielto_RB}  6695662, 372171