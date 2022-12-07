# Niko Lahtinen  Sitowise  2020

*** Variables ***


*** Settings ***
Documentation       Regression testcases for Digiroad
Resource            common_keywords.robot

Suite Setup         Login To DigiRoad
Suite Teardown      Close Browser

Test Setup          Testin Aloitus


*** Test Cases ***
Tielinkit 1
    [Tags]              Roadlinks  AWS
    [Documentation]     Tielinkit, selain: ${BROWSER}
    ...  - Kun tielinkit avataan ensimmäisen kerran, toiminnallinen luokka on näkyvissä.
    ...  Myöhemmin on valittuna se ominaisuus, joka on viimeisimmäksi valittu ennen kuin on vaihdettu tietolajia.
    KW_Tielinkit.Tielinkit_1


Tielinkit 2
    [Tags]              Roadlinks  AWS
    [Documentation]     Tielinkit, selain: ${BROWSER}
    ...  - Tielinkit näkyvät ja ne saa valittua kun mittakaava on vähintään 1:20000.
    ...  Valinnan saa poistettua klikkaamalla muualle. Tielinkin valinta säilyy kun karttaa liikutellaan ja zoomaillaan.
    ...  Valinta säilyy kun vaihdetaan radionapeista, mitä ominaisuutta näytetään.
    KW_Tielinkit.Tielinkit_2

Tielinkit 3
    [Tags]              Roadlinks
    [Documentation]     Tielinkit, selain: ${BROWSER}
    ...  - Tielinkkien toiminnalliset luokat vastaa kartan aineiston visualisointia ja formilla näytettävää luokkaa.
    Log  Testille annetaan parametrina toiminnallinen luokka ja paikka jossa se testataan (osoite tai koordinaatti)
    # hämeentie 33, turku
    KW_Tielinkit.Tielinkit_3  1  6711584, 241929
    KW_Tielinkit.Tielinkit_3  2  6711877, 240587
    KW_Tielinkit.Tielinkit_3  3  6711565, 239904
    KW_Tielinkit.Tielinkit_3  4  6711456, 239789
    KW_Tielinkit.Tielinkit_3  5  6711466, 239867
    KW_Tielinkit.Tielinkit_3  6  6712002, 240743
    KW_Tielinkit.Tielinkit_3  7  6712058, 240425
    KW_Tielinkit.Tielinkit_3  8  6711878, 240628

Tielinkit 4
    [Tags]              Roadlinks
    [Documentation]     Tielinkit, selain: ${BROWSER}
    ...  - Tielinkkien tyyppi täsmää kartan aineiston visualisointiin ja formilla näytettävään tielinkin tyyppiin.
    ...  Samalla tarkistetaan, että Kevyen liikenteen väylät ja lautta/lossiväylät ja ajopolut on visualisoitu ohuemmalla viivalla (määritelty css selectorissa, jolla aineisto tarkistetaan.)
    KW_Tielinkit.Tielinkit_4    Moottoritie                    6709118, 256445
    # Ei löydy aineistosta
    #    KW_Tielinkit.Tielinkit_4    Moottoriliikennetie
    KW_Tielinkit.Tielinkit_4    Yksiajoratainen tie            6707962, 256496
    KW_Tielinkit.Tielinkit_4    Moniajoratainen tie            6709971, 242075
    KW_Tielinkit.Tielinkit_4    Kiertoliittymä                 6711679, 239817
    KW_Tielinkit.Tielinkit_4    Ramppi                         6708746, 257816
    KW_Tielinkit.Tielinkit_4    Jalankulkualue                 6764922, 362677
    KW_Tielinkit.Tielinkit_4    Pyörätie tai yhdistetty pyörätie ja jalkakäytävä     6679499, 388913
    KW_Tielinkit.Tielinkit_4    Levähdysalue                   6709147, 256454
    KW_Tielinkit.Tielinkit_4    Ajopolku                       6707938, 256842
    KW_Tielinkit.Tielinkit_4    Huoltoaukko moottoritiellä     6707468, 247022
    KW_Tielinkit.Tielinkit_4    Lautta/lossi                   6709978, 238631

Tielinkit 5
    [Tags]              Roadlinks  AWS
    [Documentation]     Tielinkit, selain: ${BROWSER}
    ...  - Tielinkkien hallinnolliset luokat vastaa kartan aineiston visualisointia ja formilla näytettävää luokkaa.
    KW_Tielinkit.Tielinkit_5   Kunnan omistama                 6676125, 373042
    KW_Tielinkit.Tielinkit_5   Valtion omistama                6676026, 372929
    KW_Tielinkit.Tielinkit_5   Yksityisen omistama             6676188, 372978
    KW_Tielinkit.Tielinkit_5   Ei tiedossa                      6676135, 372839

Tielinkit 6
    [Tags]              Roadlinks  AWS
    [Documentation]     Tielinkit, selain: ${BROWSER}
    ...  - Tielinkkien silta luokat vastaa kartan aineiston visualisointia ja formilla näytettävää luokkaa.
    KW_Tielinkit.Tielinkit_6   Silta, Taso 1   6675257, 385417
    KW_Tielinkit.Tielinkit_6   Tunneli         6675627, 385374
    KW_Tielinkit.Tielinkit_6   Alikulku, taso 1        6675579, 385676
    KW_Tielinkit.Tielinkit_6   Maan pinnalla   6675510, 385480

Tielinkit 7
    [Tags]              Roadlinks  AWS
    [Documentation]     Tielinkit, selain: ${BROWSER}
    ...  - Yksisuuntaiset tielinkit on visualisoitu suuntanuolella. Tarkistetaan myös liikennevirta molempiin suuntiin
    KW_Tielinkit.Tielinkit_7   6710973, 238687  ${Digitointisuuntaa vastaan}
    KW_Tielinkit.Tielinkit_7   6711042, 238819  ${Digitointisuuntaan}
    KW_Tielinkit.Tielinkit_7   6711090, 239950  ${Molempiin suuntiin}

Tielinkit 8
    [Tags]              Roadlinks  AWS
    [Documentation]     Tielinkit, selain: ${BROWSER}
    ...  - Radionappien järjestys on: toiminnallinen luokka, tielinkin tyyppi, hallinnollinen luokka, silta, alikulku tai tunneli.
    KW_Tielinkit.Tielinkit_8

Tielinkit 9
    [Tags]              Roadlinks  AWS
    [Documentation]     Tielinkit, selain: ${BROWSER}
    ...  - Tielinkin ominaisuustiedoissa näkyy Link ID, MML ID, viimeisin muokkaus, linkkien lukumäärä, hallinnollinen luokka,
    ...  toiminnallinen luokka, liikennevirran suunta, tielinkin tyyppi, silta/alikulku/tunneli, kuntanumero, tien nimi suomeksi,
    ...  ruotsiksi ja saameksi sekä osoitenumerot oikealla ja vasemmalla (osoitenumerot vain, kun on yksi linkki valittuna) ja tiennumero
    KW_Tielinkit.Tielinkit_9

Tielinkit 10
    [Tags]              Roadlinks  AWS
    [Documentation]     Tielinkit, selain: ${BROWSER}
    ...  - Tielinkin muokkaus ketjuna. Toiminnallista luokkaa, liikennevirran suuntaa ja tielinkin tyyppiä voi muokata.
    ...  Liikennevirran suuntaa ja muita ominaisuuksia muokatessa myös visualisointi muuttuu vastaavasti.
    ...  Muokattu viimeksi- tieto päivittyy tallennettaessa.
    ...  Jos testi epäonnistuu pitää käydä kyseiset tilinkit muuttamassa käsin.
    # Annetaan link id:t argumentteina jolloin niitä ei tarvitse muokata testistä jos haluaa vaihtaa testauspaikan.
    KW_Tielinkit.Tielinkit_10   6711434, 240090  Linkin ID: cc07a9b8-7ca7-483e-97ed-b049f637b636:1   Linkin ID: 41bfe91c-b92e-4d4a-bcbb-68866a83fc72:1

Tielinkit 11
    [Tags]              Roadlinks  AWS
    [Documentation]     Tielinkit, selain: ${BROWSER}
    ...  - Korjattavien linkkien lista, tarkistettaan että kyseisestä linkistä aukeaa lista ja sivun ryhmittely on ok.
    ...  Tarkistetaan, että listan linkeistä aukeaa kyseinen paikka
    KW_Tielinkit.Tielinkit_11


#Tielinkit 13
    #Vanhentunut ominaisuus
    #[Tags]              Roadlinks  Optional  Functionality  Edit
    #[Documentation]     Tielinkit, selain: ${BROWSER}
    #...  - Useita tielinkkejä voi muokata kerralla piirtämällä laatikon ctrl-nappi pohjassa (toiminnallinen luokka ja linkkityyppi)
    #...  Jos testi epäonnistuu pitää testi ajaa uudelleen onnistuneesti läpi tai käydä kyseiset tilinkit muuttamassa käsin.
    #KW_Tielinkit.Tielinkit_11