[Documentation]  Tähän tiedostoon on talletettu api riippuvaisten testien keywordit.

*** Settings ***
Library                 RequestsLibrary
Library                 Collections
Library                 BuiltIn
Library                 OperatingSystem
Resource                common_keywords.robot

*** Variables ***

*** Keywords ***
Init Session
    Login To DigiRoad
    ${co}=  Get Cookies  as_dict=True
    Close Browser
    Create Session  Digiroad  ${LOGIN URL}  cookies=${co}  verify=True

Muunna Json  [Arguments]  ${json}
    [Documentation]    Muutetaan string --> pythonin json olioksi.
    ...    Huomaa loads($muuttuja)  vaihtoehtoisesti käytä '''$muuttuja'''
    ${json}=  Evaluate  json.loads($json)  json
    RETURN  ${json}

Suorita BB Haku  [Arguments]  ${URI}  ${params}
    ${status}=  GET On Session  Digiroad  ${URI}  params=${params}  expected_status=200
    RETURN  ${status.json()[0]}

Poista Kohde Apin Kautta  [Arguments]  ${url}  ${ID}
    ${status}=  DELETE On Session  Digiroad  ${url}/${ID}