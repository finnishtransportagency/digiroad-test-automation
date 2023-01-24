[Documentation]  Tähän tiedostoon on talletettu api riippuvaisten testien keywordit.

*** Settings ***
Library                 RequestsLibrary
Library                 Collections

*** Variables ***

*** Keywords ***
Init Session
    Login To DigiRoad
    ${co}=  Get Cookies  as_dict=True
    Close Browser
    Create Session  Digiroad  ${LOGIN URL}  cookies=${co}  verify=True

Muunna Json  [Arguments]  ${json}
    #Muutetaan string --> pythonin json olioksi
    #Huomaa loads($muuttuja)  vaihtoehtoisesti käytä '''$muuttuja'''
    ${json}=  Evaluate  json.loads($json)  json
    [Return]  ${json}

Suorita BB Haku  [Arguments]  ${URI}  ${params}
    ${status}=  GET On Session  Digiroad  ${URI}  params=${params}  expected_status=200
    [Return]  ${status.json()[0]}

Poista Kohde Apin Kautta  [Arguments]  ${url}  ${ID}
    ${status}=  DELETE On Session  Digiroad  ${url}/${ID}

Valo 1
    #testipaikan koordinaatit 6881312, 290858
    ${json}=  Muunna Json  ${Liikennevalo_json}
    #Init Session
    Log  Talletetaan uusi liikennevalo
    ${response}=  POST On Session  Digiroad  ${API_URI_TL}  json=${json}
    Log  Etsitään talletettu liikennevalo bbox haulla
    ${hakutulos}=  Suorita BB Haku  ${API_URI_TL}  ${Likennevalo_bbox}
    ${n}=  Get Length  ${hakutulos}[propertyData]
    Log  Tarkisetaan että talletetut arvot ovat oikein
    FOR  ${i}  IN RANGE  ${n}
        ${status}=  Run Keyword And Return Status  Dictionary Should Contain Key  ${Tiedot}  ${hakutulos}[propertyData][${i}][publicId]
        Run Keyword If  ${status}  Should Be Equal As Strings  ${hakutulos}[propertyData][${i}][values][0][propertyDisplayValue]  ${tiedot}[${hakutulos}[propertyData][${i}][publicId]]
    END
    [Teardown]  Poista Kohde Apin Kautta  ${API_URI_TL}  ${response.content}