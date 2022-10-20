#Niko Lahtinen  Sitowise  2020

*** Settings ***
Documentation       Common Variables

*** Variables ***

##########
# Header #
##########

${Käyttöohje}                                   css=#header a:nth-of-type(2)
${Käyttöohje_cont}                              Käyttöohje
${Muokkaustila_ilmoitus}                        xpath=.//*[@id='header']/div
${Muokkaustila_ilmoitus_cont}                   Olet muokkaustilassa. Kuntakäyttäjien tulee kohdistaa muutokset katuverkolle, ELY-käyttäjien maantieverkolle.
${Muokkaustila_taustaväri}                      #1c7fdd;


##############
# Left Panel #
##############

# Yleiset
${Hae_syotekentta}                              css=.location.input-sm
${Hae_btn}                                      css=.panel-header .btn.btn-sm.btn-primary
${Haku_tulokset}                                id=search-results
${Tyhjenna_tulokset_btn}                        css=.panel-section button.btn.btn-secondary
${valitse tietolaji}                            css=.panel-header .action-mode-btn.btn.btn-block.btn-primary
${Siirry muokkaustilaan}                        css=.panel-group:not([style="display: none;"]) .action-mode-btn.btn.btn-block.edit-mode-btn.btn-primary
${Siirry katselutilaan}                         css=.panel-group:not([style="display: none;"]) .action-mode-btn.btn.btn-block.read-only-btn.btn-secondary
${Muokkaustila_SelectTool}                      css=.panel-group:not([style="display: none;"]) .action.select
${Muokkaustila_AddTool}                         css=.panel-group:not([style="display: none;"]) .action.add
${Muokkaustila_PolygonTool}                     css=div.action.polygon
${Muokkaustila_Laatikko}                        xpath=//*[@id="map-tools"]/div/div[3]/div[17]/div/div[3]/div[3]
${Muokkaustila_Leikkaus}                        css=.panel-group:not([style="display: none;"]) .action.cut

###################
# Tietolajilista: #
###################

### Viivamaiset Kohteet ###

${Valitse_tietolaji_ikkuna}                     css=.asset-selection
${Tietolaji_RB_group}                           navigation-radio

${TL_Tielinkki_RB}                              linkProperty
${TL_Kaistan_mallinnustyökalu_RB}               nav-laneModellingTool
${TL_Nopeusrajoitus_RB}                         speedLimit
${TL_Kääntymisrajoitus_RB}                      manoeuvre
${TL_Ajoneuvokohtaiset_rajoitukset_RB}          prohibition
${TL_Pysäköintikielto_RB}                       parkingProhibition
${TL_VAK-rajoitus_RB}                           hazardousMaterialTransportProhibition
${TL_Käpy_tietolaji_RB}                         cyclingAndWalking

${TL_suurin_sallittu_massa_RB}                  totalWeightLimit
${TL_Yhdistelmän_suurin_sallittu_massa_RB}      trailerTruckWeightLimit
${TL_suurin_sallittu_akselimassa_RB}            axleWeightLimit
${TL_suurin_sallittu_telimassa_RB}              bogieWeightLimit
${TL_suurin_sallittu_korkeus_RB}                heightLimit
${TL_suurin_sallittu_pituus_RB}                 lengthLimit
${TL_suurin_sallittu_leveys_RB}                 widthLimit

${TL_Päällyste_RB}                              pavedRoad
${TL_Leveys_RB}                                 roadWidth
${TL_Valaistus_RB}                              litRoad
${TL_Kantavuus_RB}                              carryingCapacity
${TL_Kelirikko_RB}                              roadDamagedByThaw
${TL_Tietyöt_RB}                                roadWork

${TL_Eurooppatienumero_RB}                      europeanRoads
${TL_Liittymänumero_RB}                         exitNumbers
${TL_Hoitoluokat_RB}                            careClass
${TL_Kaistojen_lukumäärä_RB}                    numberOfLanes
${TL_Joukkoliikennekaista_RB}                   massTransitLanes
${TL_Talvinopeusrajoitus_RB}                    winterSpeedLimits
${TL_Liikennemäärä_RB}                          trafficVolume

### Pistemäiset kohteet ###

${TL_Joukkoliikenteen_pysäkki_RB}               massTransitStop
${TL_Esterakennelma_RB}                         obstacles
${TL_Rautatien_tasoristeys_RB}                  railwayCrossings
${TL_Opastustaulu_RB}                           directionalTrafficSigns
${TL_Suojatie_RB}                               pedestrianCrossings
${TL_Liikennevalo_RB}                           trafficLights
${TL_Liikennemerkit_RB}                         nav-trafficSigns
${TL_Palvelupiste_RB}                           servicePoints

${TL_TR_suurin_sallittu_korkeus_RB}             trHeightLimits
${TL_TR_suurin_sallittu_leveys_RB}              trWidthLimits
${TL_TR_Painorajpotilset_RB}                    trWeightLimits

${TL_Rautateiden_huoltotie_RB}                  nav-maintenanceRoad


#${TL_Ruuhkaantumisherkkyys_RB}                  congestionTendency

######################
# Feature Attributes # Oikea reuna
######################

# Yhteiset:
# FA_otsikko = link id tai "ominaisuustiedot"
${FA_otsikko}                                   css=#feature-attributes-header > span
${FA_header_Tallenna}                           class=btn.btn-primary.save
${FA_header_Peruuta}                            class=btn.btn-secondary.close
${FA_footer_Tallenna}                           css=footer .save.btn.btn-primary
${FA_footer_Peruuta}                            css=footer .cancel.btn.btn-secondary
${FA_Lisätty_Järjestelmään}                     css=#feature-attributes .form-group:first-of-type .form-control-static.asset-log-info
${FA_Muokattu_viimeksi}                         css=#feature-attributes .form-group:nth-of-type(2) .form-control-static.asset-log-info
${FA_Linkkien_lkm}                              css=#feature-attributes .form-group:first-of-type+div .form-control-static.asset-log-info
${FA_Geometrian_lahde}                          css=#feature-attributes .form-group:first-of-type+div+div .form-control-static.asset-log-info
${FA_Anna_Palautetta}                           css=.feedback-data-link.btn.btn-quaternary
${FA_Geometria_Notifikaatio}                    css=.form-group.form-notification
${FA_linkkien_lukumaara}                        css=div:nth-child(3) > p


#${FA_locator_textinput}                         css=#feature-attributes .form-control[type="text"]:first-of-type
${FA_locator_textinput}                         css=.input-group .form-control
${FA_locator_unitinput}                         css=.form-control.unit
${FA_locator_PVM_start}                         css=.arvioitu_kesto-start
${FA_locator_PVM_end}                           css=.arvioitu_kesto-end


#Liikennemäärä
${FA_Liikennemäärä_Rajoitus}                    css=.form-control.traffic-volume

#Suurin sallittu massa
${FA_SuurinSallittuMassa_Rajoitus}              css=.form-control.total-weight-limit
${FA_Poista_chkbx}                              id=delete-checkbox

${FA_Rajoituksen_Voimassaoloaika}               css=.form-group.new-validity-period .form-control
${FA_Rajoituksen_Voimassaoloaika_DDM}           css=.form-group.new-validity-period .form-control option:nth-child(3)


########################
# map-plugins / Footer #
########################


# Kartan skaala, tietolajit näkyvät, kun mittasuhde on 1:10 000, eli elementin teksti on "100 m"
${skaala}                                       css=.olScaleLine-inner

#zoombar
${zoombar_minus}                                css=.minus
${zoombar_plus}                                 css=.plus

#map-selector
${Maastokartta_btn}                             css=.tile-map-selector [title=Maastokartta]
${Ortokuvat_btn}                                css=.tile-map-selector [title=Ortokuvat]
${Taustakarttasarja_btn}                        css=.tile-map-selector [title=Taustakarttasarja]


#coordinates
${coord_system}                                 css=.cbCrsLabel
${map_coordinates_P}                            css=.cbValue[axis=lat]
${map_coordinates_I}                            css=.cbValue[axis=lon]
${merkitse}                                     id=mark-coordinates
${kohdistin}                                    css=.crosshair-wrapper input

########
# Muut #
########

## Map popups: ##

#Zoomaa lähemmäksi, jos haluat nähdä kohteita
# Kuntakäyttäjien tulee kohdistaa muutokset katuverkolle, ELY-käyttäjien maantieverkolle.
${Map_popup}                                    css=.instructions-popup header   #xpath=html/body/div[6]/header
# Popup tekstit:
${Muokkaustila_Popup_context}                   Kuntak\xe4ytt\xe4jien tulee kohdistaa muutokset katuverkolle, ELY-k\xe4ytt\xe4jien maantieverkolle.
#Kuntakäyttäjien tulee kohdistaa muutokset katuverkolle, ELY-käyttäjien maantieverkolle.
${Zoom_popup_context}                           Zoomaa lähemmäksi, jos haluat nähdä kohteita
${Hakuvirheilmoitus}                            Syötteestä ei voitu päätellä koordinaatteja, katuosoitetta tai tieosoitetta
${Spinner_Overlay}                              class=spinner-overlay.modal-overlay


##
${Kartta}                                       id=mapdiv
#id=OpenLayers_Map_2_OpenLayers_ViewPort
${Taustakartta}                                 css=[title="Taustakarttasarja"]
${Ortokuvat}                                    css=[title="Ortokuvat"]
${Maastokartta}                                 css=[title="Maastokartta"]
${spinner_tausta}                               url("${LOGIN URL}images/spinner.gif")
${MuokkausVaroitus}                             css=.modal-overlay.confirm-modal .content
${MuokkausVaroitus_teksti}                      Olet muokannut tietolajia.Tallenna tai peru muutoksesi.
${Muokkausvaroitus_Sulje_btn}                   css=.btn.btn-secondary.close
${Muokkausvaroitus_Ei_btn}                      css=.btn.btn-secondary.no
${Muokkausvaroitus_Kyllä_btn}                   css=.btn.btn-primary.yes

${xss1}                                         <h2>testi</h2><
${xss2}                                         \'
${xss3}                                         <p>abc</p>
${html1}                                        <script>
${html2}                                        <html>
${html3}                                        </script><

#${Kartan_polyline_aineisto}                     css=polyline
#${Kartan_polyline_aineistoKOE}                  css=polyline[id^=OpenLayers_Geometry_LineString_]
#${Kartan_polyline_aineisto2}                    css=polyline[id^=OpenLayers_Geometry_LineString_][stroke-opacity="0.7"][stroke-width="10"]
#${MapBussSymbol}                                css=.bus-basic-marker.root
#${Opastustaulu_symbol}                          css=[id^=OpenLayers_Geometry_Point_]

${mass_update_modal_peruuta}                    css=.btn.btn-secondary.close
${mass_update_modal_tallenna}                   css=.btn.btn-primary.save
${mass_update_modal_functClass_menu}            id=functional-class-selection
${mass_update_modal_linkType_menu}              id=link-type-selection
${mass_update_modal_otsikko}                    css=.modal-overlay.mass-update-modal .content
${map_overlay}                                  css=.spinner-overlay.modal-overlay

## Listat

@{Tietolaji_radiobtns}  
...  ${TL_Tielinkki_RB}    ${TL_Nopeusrajoitus_RB}    ${TL_Kääntymisrajoitus_RB}
...  ${TL_Ajoneuvokohtaiset rajoitukset_RB}     ${TL_Pysäköintikielto_RB}  ${TL_VAK-rajoitus_RB}
...  ${TL_suurin_sallittu_massa_RB}     ${TL_Yhdistelmän suurin_sallittu_massa_RB}  ${TL_suurin_sallittu_akselimassa_RB}  ${TL_suurin_sallittu_telimassa_RB}
...  ${TL_suurin_sallittu_korkeus_RB}       ${TL_suurin_sallittu_pituus_RB}     ${TL_suurin_sallittu_leveys_RB}
...  ${TL_Päällyste_RB}     ${TL_Leveys_RB}     ${TL_Valaistus_RB}      ${TL_Kantavuus_RB}
...  ${TL_Kelirikko_RB}     ${TL_Tietyöt_RB}    ${TL_Eurooppatienumero_RB}      ${TL_Liittymänumero_RB}
...  ${TL_Hoitoluokat_RB}  ${TL_Kaistojen_lukumäärä_RB}  ${TL_Joukkoliikennekaista_RB}  ${TL_Talvinopeusrajoitus_RB}  # Seuraavaksi Pistemäiset kohteet
...  ${TL_Joukkoliikenteen_pysäkki_RB}      ${TL_Esterakennelma_RB}     ${TL_Rautatien_tasoristeys_RB}      ${TL_Opastustaulu_RB}
...  ${TL_Suojatie_RB}      ${TL_Liikennevalo_RB}       ${TL_Liikennemerkit_RB}     ${TL_Palvelupiste_RB}
...  ${TL_Rautateiden_huoltotie_RB}  
# tietolajeja yhteensä 41 Seuraavat nappulat poistettu listalta, koska ne poistavat käyttäjän muokkaustilasta ${TL_Liikennemäärä_RB}  ${TL_Käpy_tietolaji_RB}  
#   ${TL_Kaistan_mallinnustyökalu_RB}  ${TL_TR_suurin_sallittu_korkeus_RB}  ${TL_TR_suurin_sallittu_leveys_RB}  ${TL_TR_Painorajpotilset_RB}

#Listaus tietolajeista joissa muokkausvaihtoehdoissa alasvetolista
@{Tietolajit_ddm}  ${TL_Nopeusrajoitus_RB}  ${TL_Ajoneuvokohtaiset rajoitukset_RB}  ${TL_VAK-rajoitus_RB}
# ddm: 3kpl

#Listaus tietolajeista joissa muokkausvaihtoehdoissa radiobutton
#PysäköintiKielto, KäPy, Päällyste, Leveys, Valaistus, Kantavuus, Kelirikko, Tietyö, Eurooppatienumero, Liittymänumero, Hoitoluokat, Kaistojen lukumäärä
#Joukkoliikennekaista, Talvinopeusrajoitus
#Suurin Sallittu (KAIKKI)


@{Tietolajit_radio_non-unit}  
...  ${TL_Pysäköintikielto_RB}  ${TL_Käpy_tietolaji_RB}  ${TL_Päällyste_RB}  ${TL_Valaistus_RB} 
...  ${TL_Kelirikko_RB}  ${TL_Tietyöt_RB}  ${TL_Eurooppatienumero_RB}  ${TL_Liittymänumero_RB}  ${TL_Hoitoluokat_RB}  ${TL_Kaistojen_lukumäärä_RB}
...  ${TL_Joukkoliikennekaista_RB}  ${TL_Talvinopeusrajoitus_RB}  ${TL_Leveys_RB}
# radio: 14 kpl - poistettu listalta

@{Tietolajit_radio_unit}
...  ${TL_suurin_sallittu_leveys_RB}   ${TL_Kantavuus_RB}  ${TL_suurin_sallittu_massa_RB}  ${TL_Yhdistelmän_suurin_sallittu_massa_RB}  ${TL_suurin_sallittu_akselimassa_RB}  ${TL_suurin_sallittu_telimassa_RB}
...  ${TL_suurin_sallittu_korkeus_RB}  ${TL_suurin_sallittu_pituus_RB}  

#Listaus tietolajeista joissa muokkausvaihtoehdoissa checkbox (listaa ei käytetä missään, vaan selkeyttää tietolajien testausta)
@{Tietolajit_checkbox}  
...  ${TL_Suojatie_RB}      ${TL_Liikennevalo_RB}     ${TL_Kääntymisrajoitus_RB}  
...  ${TL_Palvelupiste_RB}  ${TL_Joukkoliikenteen_pysäkki_RB}
...  ${TL_Opastustaulu_RB}  ${TL_Esterakennelma_RB}   ${TL_Rautatien tasoristeys_RB}    ${TL_Ajoneuvokohtaiset_rajoitukset_RB}
# Checkbox 8 kpl


@{Haku_Muuttujat}
...     ${html1}    ${html2}    ${html3}
...     ${xss1}     ${xss2}     ${xss3}

*** Keywords ***