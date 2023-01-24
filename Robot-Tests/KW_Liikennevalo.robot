*** Settings ***
Documentation  Testit ajetaan suoraan api:n kautta. 
Resource   common_keywords.robot

*** Keywords ***
Valo 2  [Arguments]  ${testipaikka}
    Log  Vaihdetaan liikennevalon suuntaa
    Siirry Testipaikkaan                ${TL_Liikennevalo_RB}  ${testipaikka}
    Click Element At Coordinates        ${Kartta}  0  20
    Wait Until Element Is Visible       ${FA_otsikko}
    Siirry Muokkaustilaan
    Click Element                       css=button.change-validity-direction
    Element Should Be Enabled           ${FA_footer_Tallenna}
    Click Element At Coordinates        ${Kartta}  0  -100
    Wait Until Element Is Visible       ${MuokkausVaroitus}
    Wait Until Element Is Not Visible   ${Map_popup}
    Click Element                       ${Muokkausvaroitus_Sulje_btn}
    #Element Should Be Disabled          ${FA_footer_Tallenna}
    Click Element                       ${FA_footer_Peruuta}

Valo 3  [Arguments]  ${testipaikka}
    Log  Tarkistetaan onko testipaikassa valmiiksi liikennevalo
    Siirry Testipaikkaan                ${TL_Liikennevalo_RB}  ${testipaikka}
    Odota sivun latautuminen
    Click Element At Coordinates        ${Kartta}  0  20
    ${status}=  Run Keyword And Return Status  Wait Until Element Is Visible  ${FA_otsikko}  timeout=10 s
    Run Keyword If  ${status}==True  Poista Liikennevalo
    Click Element At Coordinates        ${Kartta}  -18  70
    ${status}=  Run Keyword And Return Status  Wait Until Element Is Visible  ${FA_otsikko}  timeout=10 s
    Run Keyword If  ${status}==True  Poista Liikennevalo

    Log  Talletetaan uusi liikennevalo sekä lisäopastinlaite
    Siirry Muokkaustilaan
    Wait Until Element Is Not Visible   ${Map_popup}
    Click Element                       ${Muokkaustila_AddTool}
    Click Element At Coordinates        ${Kartta}  0  20
    Wait Until Element Is Visible       ${FA_otsikko}
    Input Text                          id=trafficLight_info-1  lisätieto1
    Click Element                       ${Lisää_Opastinlaite}
    Input Text                          id=trafficLight_info-2  lisätieto2
    Click Element                       ${FA_footer_Tallenna}
    Wait Until Element Is Not Visible   ${Spinner_Overlay}
    Odota sivun latautuminen
    Siirry Katselutilaan

    Log  Tarkistetaan liikennevalon tiedot
    #BUGI DROTH-3013, Tiedot tallettuvat väärälle valolle
    Click Element At Coordinates        ${Kartta}  0  20
    Wait Until Element Is Visible       ${FA_otsikko}
    Element Should Contain              ${FA_lisätieto-2}  lisätieto1
    Element Should Contain              ${FA_lisätieto-1}  lisätieto2

    Log  Siirretään liikennevaloa
    Siirry Muokkaustilaan
    Siirrä Liikennevalo                 -20  50
    Click Element                       ${FA_footer_Tallenna}
    Wait Until Element Is Not Visible   ${Spinner_Overlay}
    Odota sivun latautuminen
    Siirry Katselutilaan

    Click Element At Coordinates        ${Kartta}  -18    70
    Wait Until Element Is Visible       ${FA_otsikko}
    
    
    Log  Poistetaan liikennevalo
    Poista Liikennevalo

##########################
### Sisäiset Keywordit ###
##########################

Poista Liikennevalo
    Siirry Muokkaustilaan
    Click Element  ${FA_Poista_chkbx}
    Click Element   ${FA_footer_Tallenna}
    Wait Until Element Is Not Visible  ${Spinner_Overlay}
    Odota sivun latautuminen
    Siirry Katselutilaan

Siirrä Liikennevalo  [Arguments]  ${xKoord}  ${yKoord}
# Siirtää valittua liikennevaloa annetun offsetin verran, arvot positiivisia keskipisteestä oikealle ja alas
    Seleniumlibrary.mouse down                      css=[class='crosshair crosshair-center']
    Seleniumlibrary.drag and drop by offset         css=[class='crosshair crosshair-center']  ${xKoord}  ${yKoord}
    Seleniumlibrary.mouse up                        css=[class='crosshair crosshair-center']


Tarkista Liikennevalon Tiedot  
    [Arguments]  ${data}
    ${data}=  Convert To String  ${data}
    FOR  ${line}  IN  @{Tiedot}
        Should Contain  ${data}  ${line}
    END



*** Variables ***
${Lisää_Opastinlaite}  id=button-add-traffic-light-1
${FA_lisätieto-1}       css=#traffic-light-container-1 > div:nth-child(3) > p
${FA_lisätieto-2}       css=#traffic-light-container-2 > div:nth-child(3) > p



${API_URI_TL}      api/trafficLights
${Liikennevalo_json}  {"asset":{"propertyData": [
...     {"groupedId":1,"name":"Tyyppi","propertyType":"single_choice","publicId":"trafficLight_type","values":[{"propertyValue":1}],"localizedName":"Tyyppi"},
...     {"groupedId":1,"name":"Opastimen suhteellinen sijainti","propertyType":"single_choice","publicId":"trafficLight_relative_position","values":[{"propertyValue":"2","propertyDisplayValue":""}],"localizedName":"Opastimen suhteellinen sijainti"},
...     {"groupedId":1,"name":"Opastimen rakennelma","propertyType":"single_choice","publicId":"trafficLight_structure","values":[{"propertyValue":"1","propertyDisplayValue":""}],"localizedName":"Opastimen rakennelma"},
...     {"groupedId":1,"name":"Alituskorkeus","propertyType":"number","publicId":"trafficLight_height","values":[{"propertyValue":"500","propertyDisplayValue":""}],"localizedName":"Alituskorkeus"},
...     {"groupedId":1,"name":"Äänimerkki","propertyType":"single_choice","publicId":"trafficLight_sound_signal","values":[{"propertyValue":"2","propertyDisplayValue":""}],"localizedName":"Äänimerkki"},
...     {"groupedId":1,"name":"Ajoneuvon tunnistus","propertyType":"single_choice","publicId":"trafficLight_vehicle_detection","values":[{"propertyValue":"2","propertyDisplayValue":""}],"localizedName":"Ajoneuvon tunnistus"},
...     {"groupedId":1,"name":"Painonappi","propertyType":"single_choice","publicId":"trafficLight_push_button","values":[{"propertyValue":"2","propertyDisplayValue":""}],"localizedName":"Painonappi"},
...     {"groupedId":1,"name":"Lisätieto","propertyType":"text","publicId":"trafficLight_info","values":[{"propertyValue":"abcd","propertyDisplayValue":""}],"localizedName":"Lisätieto"},
...     {"groupedId":1,"name":"Kaistan tyyppi","propertyType":"single_choice","publicId":"trafficLight_lane_type","values":[{"propertyValue":"1","propertyDisplayValue":""}],"localizedName":"Kaistan tyyppi"},
...     {"groupedId":1,"name":"Kaista","propertyType":"number","publicId":"trafficLight_lane","values":[{"propertyValue":"11","propertyDisplayValue":""}],"localizedName":"Kaista"},
...     {"groupedId":1,"name":"Maastosijainti X","propertyType":"number","publicId":"location_coordinates_x","values":[],"localizedName":"Maastosijainti X"},
...     {"groupedId":1,"name":"Maastosijainti Y","propertyType":"number","publicId":"location_coordinates_y","values":[],"localizedName":"Maastosijainti Y"},
...     {"groupedId":1,"name":"Kunta ID","propertyType":"text","publicId":"trafficLight_municipality_id","values":[{"propertyValue":"12345","propertyDisplayValue":""}],"localizedName":"Kunta ID"},
...     {"groupedId":1,"name":"Tila","propertyType":"single_choice","publicId":"trafficLight_state","values":[{"propertyValue":3}],"localizedName":"Tila"},
...     {"groupedId":1,"name":"Vihjetieto","propertyType":"checkbox","publicId":"suggest_box","values":[{"propertyValue":0}],"localizedName":"Vihjetieto"},
...     {"groupedId":1,"name":"Suunta","propertyType":"hidden","publicId":"bearing","values":[{"propertyValue":275.6615917376728,"propertyDisplayValue":""}]},
...     {"groupedId":1,"name":"Sidecode","propertyType":"hidden","publicId":"sidecode","values":[{"propertyValue":2}]}],"lon":290835.3524533717,"lat":6881313.210069366,"floating":false,"linkId":3881933,"id":0,"bearing":275.6615917376728,"administrativeClass":"Municipality"}}

&{Tiedot}       trafficLight_type=Valo-opastin  trafficLight_info=abcd  trafficLight_municipality_id=12345
...             trafficLight_structure=Pylväs  trafficLight_lane_type=Pääkaista  trafficLight_state=Käytössä pysyvästi  
...             trafficLight_height=500  trafficLight_lane=11  trafficLight_vehicle_detection=Infrapunailmaisin
...             trafficLight_relative_position=Kaistojen yläpuolella

${Likennevalo_bbox}  bbox=290810.6542203504,6881244.247584128,290900.2792203504,6881380.372584128