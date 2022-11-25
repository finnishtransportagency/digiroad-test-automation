*** Settings ***
Documentation       Regression testcases for Digiroad
Resource            common_keywords.robot

Suite Setup         Login To DigiRoad
Suite Teardown      Close Browser

Test Setup          Testin Aloitus



*** Test Cases ***
Liikennevalo 1
    [Tags]              Liikennevalo
    [Documentation]     Tarkisetaan liikennevalon suunnan vaihto
    KW_Liikennevalo.Valo_2  6674053, 387004

Liikennevalo 2
    [Tags]              Liikennevalo
    [Documentation]     Talletetaan liikennevalo ja lisäopastinlaite
    KW_Liikennevalo.Valo_3  7197883,588929