*** Settings ***
Library                     SeleniumLibrary     timeout=60.0   run_on_failure=Capture Page Screenshot
#Library                     Dialogs
Library                     String
Library                     selenium_extensions.py
Library                     DateTime

Resource                    variables.robot
Resource                    KW_Tielinkit.robot
Resource                    KW_Kartta.robot
Resource                    KW_UI.robot
Resource                    KW_JLP.robot
Resource                    KW_Esterakennelma.robot
Resource                    KW_Tasoristeys.robot
Resource                    KW_Opastustaulu.robot
Resource                    KW_Suojatie.robot
Resource                    KW_Liikennemerkit.robot
Resource                    KW_Kaistatyokalu.robot
Resource                    KW_Kaantymisrajoitus.robot
Resource                    KW_Nopeusrajoitus.robot
Resource                    KW_SuurinSallittu.robot
Resource                    KW_Pysakointikielto.robot
Resource                    KW_Liikennevalo.robot
Resource                    KW_KapyTietolaji.robot
Resource                    KW_VAK.robot
Resource                    KW_AKR.robot
Resource                    KW_Palvelupiste.robot
Resource                    KW_Paallyste.robot


*** Variables ***
${BROWSER}                  Firefox  #Chrome
${DELAY}                    0.2

${LOGIN URL}                https://digiroadtest.testivaylapilvi.fi/
${LiviUserNameField}        id=username
${LiviPasswordField}        id=password
${LiviLoginButton}          css=.submit
${IMAGE_DIR}                ${CURDIR}\\img

*** Keywords ***
Login To DigiRoad
    Log                             ${BROWSER}
    Log                             ${LOGIN URL}
    Open Browser                    ${LOGIN URL}  ${BROWSER}
    ...  options=add_argument('--no-sandbox');add_argument('--disable-gpu');add_argument('--verbose')
    #    ...  service_log_path=driver.log
    
    #Maximize Browser Window
    set window size    1920   1080
    Set Selenium Speed              ${DELAY}
    wait until element is visible   ${LiviUserNameField}
    #${temp}=                        set variable            ${LOG LEVEL}
    #Set Log Level                   NONE
    Input Password                  ${LiviUserNameField}    ${LiviUSER}
    Input Password                  ${LiviPasswordField}    ${LiviPWD}
    Click Button                    ${LiviLoginButton}
    #Set Log Level                   ${temp}
    wait until element is visible   ${kartta}  30
    Odota sivun latautuminen
    sleep  5

Sulje QA popup
    wait until element is visible   css=.modal-overlay.confirm-modal .btn.btn-secondary.close
    click element                   css=.modal-overlay.confirm-modal .btn.btn-secondary.close

Testin Aloitus
    Set Selenium Speed  ${DELAY}
    Go to  ${LOGIN URL}
    wait until element is enabled  ${kartta}
    wait until element is visible  ${Siirry muokkaustilaan}  120


###################
# Common keywords #
###################

#Verifies element text is not equal to given string
VerifyTextNOT          [Arguments]  ${locator}    ${context}
    ${LocatorValue}=                SeleniumLibrary.Get Text   ${locator}
    should not be equal as strings  ${LocatorValue}             ${context}

#Verifies elements value attribute against given value
VerifyValue         [Arguments]     ${locator}    ${context}
    ${LocatorValue}=                Get value                   ${locator}
    Should Be Equal As Strings      ${LocatorValue}             ${context}

#Verifies value of elements attribute against given value
VerifyAttribute     [Arguments]     ${locator}    ${context}
    ${LocatorValue}=                                            ${locator}
    Should Be Equal                 ${LocatorValue}             ${context}

Odota sivun latautuminen
    Sleep                           1 s
    Wait Until Keyword Succeeds     10 min  10 sec  Element Should Not Be Visible  class=loadingBar


Zoomaa edestakaisin
    click element                   ${zoombar_minus}
    odota sivun latautuminen
    click element                   ${zoombar_plus}
    odota sivun latautuminen


Vaihda Tietolaji  [Arguments]  ${tietolaji_locator}
    wait until element is visible   ${valitse tietolaji}
    click element                   ${valitse tietolaji}
    wait until element is visible   ${Valitse_tietolaji_ikkuna}
    select radio button             ${Tietolaji_RB_group}  ${tietolaji_locator}
    #    wait until element is visible   ${Siirry muokkaustilaan}

Zoomaa kartta  [Arguments]   ${loopvalue}  ${maxskaala}
    log  Zoomataan karttaa annetun maksimin mukaan, tai jos maksimia ei ole annettu kunnes mittasuhde on 1:10 000
    FOR   ${i}     IN RANGE        ${loopvalue}
       ${var}=     SeleniumLibrary.Get Text        ${skaala}
       Run Keyword If              '${var}' == '${maxskaala}'  Exit For Loop
       Click Element               ${zoombar_plus}
       sleep  0.5 sec
    END
    Odota sivun latautuminen

Paikanna osoite     [Arguments]  ${Osoite}
    Log   Käyttää hakua paikantamaan osoite
    wait until element is visible       ${kartta}
    SeleniumLibrary.input text         ${Hae_syotekentta}       ${Osoite}
    click element                       ${Hae_btn}
    wait until element is visible       ${Kartta}
    wait until element is visible       ${Haku_tulokset}   10
    Wait Until Keyword Succeeds  30 sec  5 sec  click element  ${Tyhjenna_tulokset_btn}
    #Odota sivun latautuminen

Elements should be visible  [Arguments]  ${elem1}  ${elem2}
    element should be visible           ${elem1}
    element should be visible           ${elem2}

Siirry Muokkaustilaan
    Wait until element is visible       ${Siirry muokkaustilaan}
    click element                       ${Siirry muokkaustilaan}
    #Wait Until Element Is Visible       ${Map_popup}  10

Siirry Katselutilaan
    Wait Until Element Is Visible      ${Siirry katselutilaan}
    Click button                        ${Siirry katselutilaan}
    Wait Until Element Is Not Visible      ${Map_popup}

Tupla Klikkaa Kartan Keskelle
    Set Selenium Speed  0
    Click Element At Coordinates  ${Kartta}  0  20
    Click Element At Coordinates  ${Kartta}  0  20
    doubleclick element at coordinates  ${Kartta}  0  20
    Set Selenium Speed  ${DELAY}

Siirry Testipaikkaan
    [Arguments]  ${Tietolaji}  ${Testipaikka}
    wait until element is visible       ${valitse tietolaji}
    vaihda tietolaji                    ${Tietolaji}
    Paikanna osoite                     ${testipaikka}
    Zoomaa kartta                       5  20 m
    Odota sivun latautuminen

Alusta Testipaikka
    Log  Jos testipaikalla on valmiiksi kohde, vanha poistetaan.
    Click Element At Coordinates                    ${Kartta}  0  20
    ${status}=  Run Keyword And Return Status  Wait Until Element Is Visible  ${FA_otsikko}  10
    Run Keyword If  '${status}'=='True'  Poista Kohde

Poista Kohde
    Siirry Muokkaustilaan
    Click Element                               ${FA_Poista_chkbx}
    Click Element                               ${FA_footer_Tallenna}
    #Odota sivun latautuminen
    Wait Until Element Is Not Visible           css=.spinner-overlay.modal-overlay
    Siirry Katselutilaan

Siirrä Kohde  [Arguments]  ${xKoord}  ${yKoord}
    # Siirtää valittua Opastustaulu annetun offsetin verran, arvot positiivisia keskipisteestä oikealle ja alas
    Seleniumlibrary.mouse down                      css=[class='crosshair crosshair-center']
    Seleniumlibrary.drag and drop by offset         css=[class='crosshair crosshair-center']  ${xKoord}  ${yKoord}
    Seleniumlibrary.mouse up                        css=[class='crosshair crosshair-center']

Valitse Kohde
    FOR  ${n}  IN RANGE  10
        click element at coordinates                ${kartta}   0   20
        ${status}=  Run Keyword And Return Status  Wait Until Element Is Visible  ${FA_otsikko}
        Exit For Loop If  '${status}'=='True'
    END

Valitse Selain
    [Documentation]  Valitsee selaimen testeihin viikonpäivän mukaan, käytössä CI ympäristössä
    #Ei käytössä
    [Arguments]  ${BROWSER}
    ${date}=  Get Current Date
    ${date}=  Convert Date  ${date}  result_format=%w
    ${BROWSER}=  Run Keyword If  0<=${date}<5  Set Variable  Chrome
    ...  ELSE IF  Set Variable  Firefox
    log to console  ${BROWSER}
    [Return]  ${BROWSER}

Suorita monivalinta
    Click Element At Coordinates                ${Kartta}  -100  -100
    Click Element At Coordinates                ${Kartta}  100  -100
    Click Element At Coordinates                ${Kartta}  100  100
    Doubleclick Element At Coordinates          ${Kartta}  -100  100

testklick
    [documentation]     Kutsutaan testklick, voidaan hakea testissä clikkaus paikka kohdille
    tklick    0   0
    FOR   ${i}   IN RANGE  2  35   3
       tklick    ${i}    ${i}
       tklick   -${i}   -${i}
       tklick    ${i}   -${i}
       tklick   -${i}    ${i}
       tklick    ${i}     0
       tklick   -${i}     0
       tklick     0      ${i}
       tklick     0     -${i}
    END
    
tklick   [arguments]      ${x}   ${y}
    click element at coordinates                ${kartta}  ${x}   ${y}
    ${t} =   run keyword and return status   wait until element is visible       ${FA_otsikko}   timeout=1
    #exit for loop if     ${t} == True
    run keyword if     ${t} == True      log to console   ${x}
    run keyword if     ${t} == True      log to console   ${y}