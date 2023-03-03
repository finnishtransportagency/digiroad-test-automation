#*** Settings ***
#Documentation       API testitapaukset liikennevaloille
#Resource            common_keywords.robot
#Resource            API_keywords.robot

#Suite Setup  Init Session
#Suite Teardown  Delete All Sessions


#*** Test Cases ***
#Liikennevalo 1
#    [Tags]              API  Liikennevalo

#    [Documentation]     Talletetaan uusi liikennevalo API:n kautta. 
#    ...                 Tarkistetaan arvota ja poistetaan kyseinen liikennemerkki.
#    KW_Liikennevalo.Valo_1
