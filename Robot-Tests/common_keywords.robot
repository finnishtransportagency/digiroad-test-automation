*** Settings ***
Library                     SeleniumLibrary     timeout=60.0   run_on_failure=Capture Page Screenshot
#Library                     Dialogs
Library                     String
Library                     selenium_extensions.py
Library                     DateTime

# -> Comment before committing
# Library                     DebugLibrary
# Resource                    DRownvariables.robot
# <- Comment before committing

Resource                    variables.robot
Resource                    API_KW_lanes_in_municipality.robot
Resource                    API_KW_lanes_in_range.robot
#Resource                    API_KW_lane_information.robot    #otettu pois käytöstä toistaiseksi rajapintaongelmien johdosta
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
Resource                    KW_Leveys.robot
Resource                    KW_Valaistus.robot
Resource                    KW_Kantavuus.robot
Resource                    KW_Tietyot.robot
Resource                    KW_Kelirikko.robot
Resource                    KW_Eurooppatienumero.robot
Resource                    KW_Liittymänumero.robot
Resource                    KW_Talvinopeus.robot
Resource                    KW_Liikennemäärä.robot
Resource                    KW_Hoitoluokat.robot
Resource                    KW_Rautatien_huoltotie.robot



*** Variables ***
${BROWSER}                  Firefox
${DELAY}                    0.2

${LOGIN URL}                      https://digiroadtest.testivaylapilvi.fi/
${LiviUserNameField}              id=username
${LiviPasswordField}              id=password
${LiviLoginButton}                css=.submit
${VaylaMFAButton}                 css=div[class*='visible-md'] input[aria-label='Vayla12cTestOAM']
${IMAGE_DIR}                      ${CURDIR}\\img


*** Keywords ***
Login To DigiRoad
    Log    ${BROWSER}
    Log    ${LOGIN URL}
    Open Browser    ${LOGIN URL}    ${BROWSER}
    ...  options=add_argument('--no-sandbox');add_argument('--disable-gpu');add_argument('--verbose')
    #    ...  service_log_path=driver.log

    # Maximize Browser Window
    Set Window Size    1920    1080
    Set Selenium Speed    ${DELAY}
    Wait Until Element Is Visible    ${VaylaMFAButton}
    Click Button    ${VaylaMFAButton}
    Wait Until Element Is Visible   ${LiviUserNameField}
    #${temp}=                        set variable            ${LOG LEVEL}
    #Set Log Level                   NONE
    Input Password    ${LiviUserNameField}    ${LiviUSER}
    Input Password    ${LiviPasswordField}    ${LiviPWD}
    Click Button    ${LiviLoginButton}
    #Set Log Level                   ${temp}
    Wait Until Element Is Visible    ${kartta}    30
    Odota Sivun Latautuminen
    Sleep  5


Sulje QA popup
    Wait Until Element Is Visible    css=.modal-overlay.confirm-modal .btn.btn-secondary.close
    Click Element    css=.modal-overlay.confirm-modal .btn.btn-secondary.close


Testin Aloitus
    Set Selenium Speed    ${DELAY}
    Go to    ${LOGIN URL}
    Set Test Variable    ${MUOKKAUSTILA_AKTIVOITU}    false
    # Trying to make starting test case more reliable.
    # Especially in AWS it seems that page keeps on loading forever sometimes.
    ${map_enabled} =    Run Keyword And Return Status
    ...    Wait Until Element Is Enabled    ${kartta}
    ${muokkaustila_button_visible} =    Run Keyword And Return Status
    ...    Wait Until Element Is Visible    ${Siirry muokkaustilaan}    20
    IF    ${muokkaustila_button_visible} == ${False} or ${map_enabled} == ${False}
        Reload Page
    END
    Wait Until Element Is Enabled    ${kartta}
    Wait Until Element Is Visible    ${Siirry muokkaustilaan}    60


###################
# Common keywords #
###################

# Verifies element text is not equal to given string
VerifyTextNOT    [Arguments]    ${locator}    ${context}
    ${LocatorValue} =    SeleniumLibrary.Get Text     ${locator}
    Should Not Be Equal As Strings    ${LocatorValue}     ${context}


#Verifies elements value attribute against given value
VerifyValue    [Arguments]    ${locator}    ${context}
    ${LocatorValue} =    Get value    ${locator}
    Should Be Equal As Strings    ${LocatorValue}    ${context}


#Verifies value of elements attribute against given value
VerifyAttribute    [Arguments]    ${locator}    ${context}
    ${LocatorValue} =    Set Variable    ${locator}
    Should Be Equal    ${LocatorValue}    ${context}


Odota sivun latautuminen
    Sleep    1 s
    Wait Until Keyword Succeeds    10 min    10 sec    Element Should Not Be Visible    class=loadingBar


Zoomaa edestakaisin
    Click Element    ${zoombar_minus}
    Odota Sivun Latautuminen
    Click Element    ${zoombar_plus}
    Odota Sivun Latautuminen


Vaihda Tietolaji    [Arguments]    ${tietolaji_locator}
    Wait Until Element Is Visible    ${valitse tietolaji}
    Click Element    ${valitse tietolaji}
    Wait Until Element Is Visible    ${Valitse_tietolaji_ikkuna}
    Select Radio Button    ${Tietolaji_RB_group}    ${tietolaji_locator}
    Radio Button Should Be Set To    ${Tietolaji_RB_group}  ${tietolaji_locator}
    # Teemu 23.9.2025. Vaihdettu tähän Siirry katselutilaan ehdollinen verifiointi jos testissä aiemmin mennään muokkaustilaan.
    IF    '${MUOKKAUSTILA_AKTIVOITU.lower()}' == 'true'
        Wait Until Element Is Visible    ${Siirry katselutilaan}
    ELSE
        Wait Until Element Is Visible    ${Siirry muokkaustilaan}
    END


Zoomaa kartta  [Arguments]   ${loopvalue}  ${maxskaala}
    Log    Zoomataan karttaa annetun maksimin mukaan, tai jos maksimia ei ole annettu kunnes mittasuhde on 1:10 000
    FOR   ${i}     IN RANGE        ${loopvalue}
       ${var}=     SeleniumLibrary.Get Text        ${skaala}
       Run Keyword If              '${var}' == '${maxskaala}'    Exit For Loop
       Click Element               ${zoombar_plus}
       sleep  0.5 sec
    END
    Odota sivun latautuminen


Paikanna osoite     [Arguments]    ${Osoite}
    Log   Käyttää hakua paikantamaan osoite
    Wait Until Element Is Visible    ${kartta}
    SeleniumLibrary.Input Text    ${Hae_syotekentta}    ${Osoite}
    Click Element    ${Hae_btn}
    Wait Until Element Is Visible    ${Kartta}
    Wait Until Element Is Visible    ${Haku_tulokset}    10
    Wait Until Keyword Succeeds    30 sec    5 sec    Click Element    ${Tyhjenna_tulokset_btn}
    #Odota sivun latautuminen


Elements should be visible    [Arguments]    ${elem1}    ${elem2}
    Element Should Be Visible    ${elem1}
    Element Should Be Visible    ${elem2}


Siirry Muokkaustilaan
    Wait Until Element Is Visible    ${Siirry muokkaustilaan}
    Click Element    ${Siirry muokkaustilaan}
    Set Test Variable    ${MUOKKAUSTILA_AKTIVOITU}    true
    #Wait Until Element Is Visible       ${Map_popup}  10


Siirry Katselutilaan
    Wait Until Element Is Visible    ${Siirry katselutilaan}
    Click button    ${Siirry katselutilaan}
    Wait Until Element Is Not Visible    ${Map_popup}
    Set Test Variable    ${MUOKKAUSTILA_AKTIVOITU}    false


Tupla Klikkaa Kartan Keskelle
    Set Selenium Speed    0
    # Tried commenting these out since separate double click exists.
    # Need to still improve by doubleclick and wait
    # Click Element At Coordinates    ${Kartta}    0    20
    # Click Element At Coordinates    ${Kartta}    0    20
    selenium_extensions.Doubleclick Element At Coordinates    ${Kartta}    0    20
    Set Selenium Speed    ${DELAY}


Tuplaklikkaa Kartan Keskella Ja Odota Lokaattori    [Arguments]    ${locator}
    TRY
        Set Selenium Speed    0
        FOR    ${index}    IN RANGE    20    -1    -10
            Log    DoubleClicking map at coordinates 0 and ${index}
            selenium_extensions.Doubleclick Element At Coordinates    ${Kartta}    0    ${index}
            ${status} =    Run Keyword And Return Status
            ...    Wait Until Element Is Visible    ${locator}    timeout=3
            IF    ${status} == ${False}
                CONTINUE
            ELSE
                BREAK
            END
        END
        IF    ${status} == ${False}
            Fail
            ...    Tuplaklikkaus kartan keskelle epäonnistui:
        END
    EXCEPT    AS    ${error_msg}
        Fail
        ...    Yritettiin tuplaklikata kartan keskelle ja odottaa lokaattoria ${locator} mutta ${error_msg}
    FINALLY
        Set Selenium Speed    ${DELAY}
    END


Siirry Testipaikkaan
    [Arguments]    ${Tietolaji}    ${Testipaikka}
    Wait Until Element Is Visible     ${valitse tietolaji}
    Vaihda Tietolaji    ${Tietolaji}
    Paikanna Osoite    ${testipaikka}
    Zoomaa Kartta    5   20 m
    Odota Sivun Latautuminen


Alusta Testipaikka
    Log  Jos testipaikalla on valmiiksi kohde, vanha poistetaan.
    Click Element At Coordinates                    ${Kartta}  0  20
    ${status} =    Run Keyword And Return Status
    ...    Wait Until Element Is Visible
    ...    ${FA_otsikko}
    ...    10
    Run Keyword If    '${status}'=='True'    Poista Kohde


Poista Kohde
    Siirry Muokkaustilaan
    Click Element    ${FA_Poista_chkbx}
    Click Element    ${FA_footer_Tallenna}
    #Odota sivun latautuminen
    Wait Until Element Is Not Visible    css=.spinner-overlay.modal-overlay
    Siirry Katselutilaan


Siirrä Kohde    [Arguments]    ${xKoord}    ${yKoord}
    # Siirtää valittua Opastustaulu annetun offsetin verran, arvot positiivisia keskipisteestä oikealle ja alas
    Seleniumlibrary.Mouse Down    css=[class='crosshair crosshair-center']
    Seleniumlibrary.Drag And Drop By Offset    css=[class='crosshair crosshair-center']    ${xKoord}    ${yKoord}
    Seleniumlibrary.Mouse Up    css=[class='crosshair crosshair-center']


Valitse Kohde
    FOR    ${n}    IN RANGE    10
        Click Element At Coordinates    ${kartta}    0    20
        ${status} =    Run Keyword And Return Status
        ...    Wait Until Element Is Visible    ${FA_otsikko}
        Exit For Loop If    '${status}'=='True'
    END


Valitse Selain
    [Documentation]    Valitsee selaimen testeihin viikonpäivän mukaan, käytössä CI ympäristössä
    #Ei käytössä
    [Arguments]       ${BROWSER}
    ${date} =    Get Current Date
    ${date} =    Convert Date     ${date}    result_format=%w
    ${BROWSER}=  Run Keyword If    0<=${date}<5    Set Variable    Chrome
    ...  ELSE IF    Set Variable    ${BROWSER}=    Firefox
    Log To Console    ${BROWSER}
    RETURN    ${BROWSER}


Suorita monivalinta
    Click Element At Coordinates    ${Kartta}    -100    -100
    Click Element At Coordinates    ${Kartta}    100    -100
    Click Element At Coordinates    ${Kartta}    100    100
    selenium_extensions.Doubleclick Element At Coordinates    ${Kartta}    -100    100


Suorita laatikkovalinta
    Click Element At Coordinates    ${Kartta}    0    0
    Click Element At Coordinates    ${Kartta}    100    -100


testklick
    [documentation]     Kutsutaan testklick, voidaan hakea testissä clikkaus paikka kohdille
    tklick    0   0
    FOR   ${i}   IN RANGE  2  35   3
       tklick    ${i}    ${i}
       tklick    -${i}    -${i}
       tklick    ${i}    -${i}
       tklick    -${i}    ${i}
       tklick    ${i}    0
       tklick    -${i}    0
       tklick     0    ${i}
       tklick     0    -${i}
    END


tklick    [arguments]    ${x}    ${y}
    Click Element At Coordinates    ${kartta}    ${x}    ${y}
    ${t} =    Run Keyword And Return Status     Wait Until Element Is Visible    ${FA_otsikko}    timeout=1
    #exit for loop if     ${t} == True
    Run Keyword If    ${t} == True    Log To Console     ${x}
    Run Keyword If    ${t} == True    Log To Console     ${y}


Click Center Of The Map And Wait For Locator    [Arguments]    ${locator}=${FA_otsikko}
    [Documentation]    Tries to click element in the middle of the map by changing y coordinate.
    ...                Fails if header of right side info window not visible after clicking.
    FOR    ${index}    IN RANGE    20    -1    -10
        Log    Clicking map at coordinates 0 and ${index}
        Click Element At Coordinates    ${Kartta}    0    ${index}
        ${status} =    Run Keyword And Return Status
        ...    Wait Until Element Is Visible    ${locator}    timeout=5
        IF    ${status} == ${False}
            CONTINUE
        ELSE
            BREAK
        END
    END
    IF    ${status} == ${False}
        Fail
        ...    Yritettiin klikata kohdetta kartan keskellä mutta tiedot eivät avautuneet oikealle klikkausyritysten jälkeen.
    END


Tallenna Muutokset
    [Documentation]    Clicks save buttton and checks if alerts present.
    ...                If alert present tries clicking again.
    ...                Spinner is sometimes stuck after saving so changing screen size
    ...                to handle that. Needs to be investigated if real bug.
    Click Element    ${FA_footer_Tallenna}
    ${tallennus_epäonnistui} =    Run Keyword And Return Status
    ...    Alert Should Be Present
    ...    timeout=2
    IF    ${tallennus_epäonnistui} == ${True}
        Click Element    ${FA_footer_Tallenna}
    END
    ${spinner_not_visible} =    Run Keyword And Return Status
    ...    Wait Until Element Is Not Visible    ${Spinner_Overlay}    timeout=30
    IF    ${spinner_not_visible} == ${False}
         Set Window Size    1500    1080
         Set Window Size    1920    1080
    END
    Wait Until Element Is Not Visible    ${Spinner_Overlay}
    ...    error=Spinner still visible on map after saving.


Tallenna Dialogista
    Click Element    ${FA_header_Tallenna}
    Wait Until Element Is Not Visible    ${Spinner_Overlay}    timeout=10
