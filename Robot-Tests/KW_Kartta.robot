
*** Settings ***
Documentation       Pageobject for Map testcases


*** Keywords ***

Kartta_1
    Log     Kartan käyttö zoomnapeilla
    wait until element is visible               ${skaala}
    ${temp}=    SeleniumLibrary.Get Text        ${skaala}
    set selenium speed  0.1
    Repeat Keyword  4 times  click element      ${zoombar_plus}
    Odota sivun latautuminen
    Set Selenium Speed                          ${DELAY}
    VerifyTextNOT                               ${skaala}               ${temp}

    Log     Kartan käyttö tuplaklikkaamalla
    wait until element is visible               ${skaala}
    ${temp}=    SeleniumLibrary.Get Text        ${skaala}
    set selenium speed   0.5
   selenium_extensions.doubleclick_element_at_coordinates          ${kartta}   0  20
    #sikulilibrary.Double Click                 kartta1_kartta.png
    Odota sivun latautuminen
    Set Selenium Speed                          ${DELAY}
    VerifyTextNOT                               ${skaala}               ${temp}

    log  Kartan zoomaus shift+piirto
    ${temp}=    SeleniumLibrary.Get Text       ${skaala}
    press shift and drag and drop by offset     ${kartta}               220   220
    press shift and drag and drop by offset     ${kartta}               220   220
    Odota sivun latautuminen
    VerifyTextNOT                               ${skaala}               ${temp}

Kartta_2
    [Documentation]  Kartan liikuttaminen raahaamalla ja haulla
    wait until element is visible               ${map_coordinates_I}
    ${temp}=    SeleniumLibrary.Get Text       ${map_coordinates_I}
    odota sivun latautuminen
    Seleniumlibrary.mouse down        css=[class='crosshair crosshair-center']
    Seleniumlibrary.Drag And Drop By Offset           ${kartta}      150   -200
    Seleniumlibrary.mouse up          css=[class='crosshair crosshair-center']
    wait until element is visible               ${map_coordinates_I}
    VerifyTextNOT                               ${map_coordinates_I}    ${temp}

Kartta_3
    [Documentation]  Taustakartaksi voi valita ortokuvat, taustakarttasarjan tai maastokartan.
    wait until element is visible           ${Taustakartta}
    Click Element                           ${Maastokartta_btn}
    Wait Until Element Is Visible           ${Maastokartta}
    #Zoomataan karttaa, kunnes skaala 5km - ortokuvat ei näy muuten
    Click Element                           ${zoombar_plus}
    Wait Until Element Is Visible           ${Maastokartta}
    Click Element                           ${zoombar_plus}
    Wait Until Element Is Visible           ${Maastokartta}
    Click Element                           ${zoombar_plus}
    Wait Until Element Is Visible           ${Maastokartta}
    Click Element                           ${Ortokuvat_btn}
    Wait Until Element Is Visible           ${Ortokuvat}

Kartta_4
    [Documentation]   Sovellus näyttää viestin "Zoomaa lähemmäksi, jos haluat nähdä kohteita", kun mittakaavataso on liian pieni.
    ...     Testissä käytössä oletustietolaji, eli joukkoliikenteen pysäkki (näkyvät 1:20 000 mittakaavalla)

    Log  Zoomataan karttaa ja tarkistetaan, että haluttu ilmoitus tulee näkyviin
    FOR   ${i}     IN RANGE    10
        Wait Until Element Is Not Visible  ${Map_popup}
       Click Element                       ${zoombar_plus}
       #wait until element is visible       ${Map_popup}
       #Wait until keyword succeeds  2x  200ms  
       Wait Until Element Contains         ${Map_popup}             ${Zoom_popup_context}
       Wait Until Element Is Not Visible   ${Map_popup}
       ${var}=     SeleniumLibrary.Get Text        ${skaala}
       Run Keyword If  '${var}'=='500 m'   Exit For Loop
    END
    
    Log   Tarkistetaan, että zoom-ilmoitusta ei tulee enää kun skaala on 200m
    Click Element                           ${zoombar_plus}
    Element Should Not Be Visible           ${Map_popup}