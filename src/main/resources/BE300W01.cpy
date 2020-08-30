      ******************************************************************
      *  COPY: BE300W01                                                *
      *                                                                *
      *  DESCRIZIONE:                                                  *
      *        Tracciato del file movimenti                            *
      *     UNIONE TABELLE BE00TBMO E BE00TBAG                         *
      *     BONIFICI EUROPEI.                                          *
      ******************************************************************
      *#VAR1 101010 CR00706 CCID BEBE2026                              *
      *#   Inserito campo PROG-ULT-AGG di tabella MO                   *
      *#END-VAR                                                        *
      ******************************************************************

       01 BE3P02-AREA.

      ******************************************************************
      * CHIAVE COMUNE ALLE TABELLE BE00TBMO E BE00TBAG                 *
      ******************************************************************

           05 BE3P02-ISTITUTO      PIC S9(006) COMP-3.
      *       Istituto

           05 BE3P02-DATA-INSE     PIC  X(008).
      *       Data inserimento nel formato SSAAMMGG

           05 BE3P02-NUM-DIST      PIC S9(010) COMP-3.
      *       Numero distinta

           05 BE3P02-NUM-MOV       PIC S9(010) COMP-3.
      *       Numero movimento all'interno della distinta

      ******************************************************************
      * DATI PRESENTI IN TABELLA BE00TBMO                              *
      ******************************************************************

           05 BE3P02-TIPO-DIST     PIC  X(001).
      *       Tipo distinta (bonifico singolo, multiplo, ecc.)

           05 BE3P02-TIPO-MOV      PIC  X(001).
      *       Tipo movimento

           05 BE3P02-NATU-MOV      PIC  X(005).
      *       Natura movimento

           05 BE3P02-RAGGR-MOV     PIC  X(004).
      *       Raggruppamento di appartenenza/canale acquisizione

           05 BE3P02-S-RAGGR-MOV   PIC S9(003) COMP-3.
      *       Sottoraggruppamento di appartenenza

           05 BE3P02-MOV-FUN       PIC  X(004).
      *       Attributo del movimento

           05 BE3P02-MOV-CAR       PIC  X(004).
      *       Attributo del movimento

           05 BE3P02-MOV-MOT       PIC  X(004).
      *       Attributo del movimento

           05 BE3P02-STATO-MOV     PIC  X(001).
      *       Stato del movimento

           05 BE3P02-TIME-INSE     PIC  X(008).
      *       Ora di inserimento formato HHMMSSCC

           05 BE3P02-OPER-INSE     PIC  X(012).
      *       NDG utente inserimento

           05 BE3P02-USER-INSE     PIC  X(012).
      *       User utente inserimento

           05 BE3P02-IMPORTO       PIC S9(018) COMP-3.
      *       Importo del singolo movimento in centesimi di euro

           05 BE3P02-SEGNO-OPER    PIC  X(001).
      *       Segno dell'operazione

           05 BE3P02-DIVISA-MOV    PIC  X(003).
      *       Divisa del movimento

           05 BE3P02-CRO-OPE       PIC  X(035).
      *       CRO dell'operazione

           05 BE3P02-ORD-IBAN      PIC  X(034).
      *       Codice IBAN dell'ordinante

           05 BE3P02-ORD-RAP-SERV  PIC  X(002).
      *       Codice servizio interno ordinante formato Cedacri

           05 BE3P02-ORD-RAP-FIL   PIC  X(005).
      *       Codice filiale  interno ordinante formato Cedacri

           05 BE3P02-ORD-RAP-CC    PIC  X(008).
      *       CC interno ordinante formato Cedacri

           05 BE3P02-ORD-ANAG-ORI  PIC  X(070).
      *       Anagrafica dell'ordinante Originaria

           05 BE3P02-ORD-INDI-ORI  PIC  X(140).
      *       Indirizzo dell'ordinante Originario

           05 BE3P02-ORD-PAED-ORI  PIC  X(002).
      *       Codice paese domicilio dell'ordinante originario

           05 BE3P02-ORD-CAP-ORI   PIC S9(005) COMP-3.
      *       CAP del comune dell'ordinante Originario

           05 BE3P02-ORD-COMU-ORI  PIC  X(050).
      *       Comune Originario dell'ordinante Originario

           05 BE3P02-ORD-PROV-ORI  PIC  X(002).
      *       Provincia dell'ordinante Originaria

           05 BE3P02-ORD-COD-P-ORI PIC  X(002).
      *       Codice paese reasidenza dell'ordinante Originaria

           05 BE3P02-ORD-ANAG      PIC  X(070).
      *       Anagrafica dell'ordinante digitata

           05 BE3P02-ORD-INDI      PIC  X(140).
      *       indirizzo dell'ordinante

           05 BE3P02-ORD-CAP-COMU  PIC S9(005) COMP-3.
      *       cap del comune ordinante

           05 BE3P02-ORD-COMU      PIC  X(050).
      *       Comune dell'iordinante

           05 BE3P02-ORD-PROV      PIC  X(002).
      *       Provincia dell'ordinante

           05 BE3P02-ORD-COD-PAE   PIC  X(002).
      *       Codice paese ISO ordinante

           05 BE3P02-ORD-COD-P     PIC  X(002).
      *       Codice paese di residenza

           05 BE3P02-ORD-VL-AD-ORI PIC  X(008).
      *       Data valuta addebito indicata dall'ordinante

           05 BE3P02-ORD-DT-AD-ORI PIC  X(008).
      *       data di addebito indicata dall'ordinante

           05 BE3P02-ORD-VL-AD     PIC  X(008).
      *       data valuta di addebito applicata

           05 BE3P02-ORD-DT-AD     PIC  X(008).
      *       data di addebito applicata

           05 BE3P02-ORD-FM-PG-AD  PIC  X(002).
      *       Forma di pagamento utilizzato per l'adebito

           05 BE3P02-ORD-NUM-ADD   PIC S9(008) COMP-3.
      *       Numero assegnato da CC all'operazione di addebito

           05 BE3P02-ORD-NUM-ADD-O PIC S9(008) COMP-3.
      *       Numero assegnato da CC all'operazione di addebito
      *       Contenente gli oneri (in caso di distinzione tra
      *       commissioni ed oneri)

           05 BE3P02-ORD-NUM-PRE-D PIC S9(008) COMP-3.
      *       Numero prenotata dare

           05 BE3P02-ORD-COMM-CALC PIC S9(006) COMP-3.
      *       Commissioni operazione sull'ordinante calcolate

           05 BE3P02-ORD-COMM-RISC PIC S9(006) COMP-3.
      *       Commissioni operazione sull'ordinante riscosse

           05 BE3P02-ORD-SP-OP-CAL PIC S9(006) COMP-3.
      *       Spese operazione ordinante calcolate

           05 BE3P02-ORD-SP-OP-RIS PIC S9(006) COMP-3.
      *       Spese operazione ordinante riscosse

           05 BE3P02-ORD-CAU-ADD   PIC  X(005).
      *       Causale di addebito

           05 BE3P02-ORD-CAU-ADO   PIC  X(005).
      *       Causale di addebito Oneri (in caso di
      *       distinzione tra commissioni ed oneri)

           05 BE3P02-ORD-CAU-AT-AD PIC  X(005).
      *       Causale di segnalazione antiriciclaggio

           05 BE3P02-ORD-CAU-SE-AD PIC  X(005).
      *       Causale di segnalazione estero

           05 BE3P02-BEN-TIPO-COOR PIC  X(001).
      *      Tipo coordinate bancarie beneficiario

           05 BE3P02-BEN-IBAN      PIC  X(034).
      *       Codice IBAN del beneficiario

           05 BE3P02-BEN-RAP-SERV  PIC  X(002).
      *       Codice servizio interno beneficiario formato Cedacri

           05 BE3P02-BEN-RAP-FIL   PIC  X(005).
      *       Codice filiale  interno beneficiario formato Cedacri

           05 BE3P02-BEN-RAP-CC    PIC  X(008).
      *       CC interno beneficiario formato Cedacri

           05 BE3P02-BEN-NUM-ASS   PIC S9(012) COMP-3.
      *       Numero assegno di traenza

           05 BE3P02-BEN-SER-ASS   PIC  X(002).
      *       Seri assegno

           05 BE3P02-BEN-TR-ASS    PIC  X(001).
      *       Flag di trasferibilità dell'assegno

           05 BE3P02-BEN-ANAG-ORI  PIC  X(070).
      *       Anagrafica del  beneficiario originaria

           05 BE3P02-BEN-INDI-ORI  PIC  X(140).
      *       Indirizzo del beneficiario originario

           05 BE3P02-BEN-PAED-ORI  PIC  X(002).
      *       Codice paese domicilio del beneficiario originario

           05 BE3P02-BEN-CAP-ORI   PIC S9(005) COMP-3.
      *       CAP del comune del beneficiario originario

           05 BE3P02-BEN-COMU-ORI  PIC  X(050).
      *       Comune originario del beneficiario originario

           05 BE3P02-BEN-PROV-ORI  PIC  X(002).
      *       Provincia del beneficiario originaria

           05 BE3P02-BEN-COD-P-ORI PIC  X(002).
      *       Codice paese reasidenza dell'ordinante originario

           05 BE3P02-BEN-ANAG      PIC  X(070).
      *       Anagrafica del  beneficiario (digitata)

           05 BE3P02-BEN-INDI      PIC  X(140).
      *       Indirizzo del beneficiario

           05 BE3P02-BEN-CAP-COMU  PIC S9(005) COMP-3.
      *       CAP del comune del  beneficiario

           05 BE3P02-BEN-COMU      PIC  X(050).
      *       Comune del beneficiario

           05 BE3P02-BEN-PROV      PIC  X(002).
      *       Provincia del beneficiario

           05 BE3P02-BEN-COD-PAE   PIC  X(002).
      *       Codice paese ISO del beneficiario

           05 BE3P02-BEN-COD-P     PIC  X(002).
      *       Codice paese di residenza del beneficiario

           05 BE3P02-BEN-VAL-FISSA PIC  X(008).
      *       Data valuta fissa al beneficiario

           05 BE3P02-BEN-VL-AC-ORI PIC  X(008).
      *       Data valuta accredito indicata dall'ordinanate (SSAAMMGG)

           05 BE3P02-BEN-DT-AC-ORI PIC  X(008).
      *       Data di accredito indicata dall'ordinante formato SSAAMMGG

           05 BE3P02-BEN-VL-AC-APP PIC  X(008).
      *       Data valuta di accredito nel formato SSAAMMGG.

           05 BE3P02-BEN-DT-AC-APP PIC  X(008).
      *       Data di accredito nel formato SSAAMMGG.

           05 BE3P02-BEN-NUM-ACC   PIC S9(008) COMP-3.
      *       Numero assegnato da CC all'operazione di accredito

           05 BE3P02-BEN-NUM-PRE-A PIC S9(008) COMP-3.
      *       Numero prenotata avere

           05 BE3P02-BEN-TIPO-COMM PIC  X(003).
      *       Tipo commissioni operazione sul beneficiario

           05 BE3P02-BEN-COMM-CALC PIC S9(006) COMP-3.
      *       Commissioni operazione sul beneficiario calcolate

           05 BE3P02-BEN-COMM-RISC PIC S9(006) COMP-3.
      *       Commissioni operazione sul beneficiario riscosse

           05 BE3P02-BEN-SPESE-OPE PIC S9(006) COMP-3.
      *       Spese operazione beneficiario

           05 BE3P02-BEN-IMP-ORIG  PIC S9(018) COMP-3.
      *       Importo originario in centesimi di euro

           05 BE3P02-BEN-CAU-ACC   PIC  X(005).
      *       Causale di accredito

           05 BE3P02-BEN-CAU-AT-AC PIC  X(005).
      *       Causale di segnalazione antiriciclaggio

           05 BE3P02-BEN-CAU-SE-AC PIC  X(005).
      *       Causale di segnalazione estero

           05 BE3P02-OPE-FIL-COM-A PIC  X(005).
      *       Codice filiale di competenza corrente del movimento

           05 BE3P02-OPE-FIL-COM-P PIC  X(005).
      *       Codice filiale di competenza precedente del movimento

           05 BE3P02-OPE-MOV-GR-BK PIC  X(001).
      *       Movimento di gruppo bancario

           05 BE3P02-OPE-FM-TC-PG  PIC  X(002).
      *       forma tecnica di pagamento

           05 BE3P02-OPE-FL-CO-BK  PIC  X(001).
      *       Flag compensazione valuta banca

           05 BE3P02-OPE-FL-CO-ABK PIC  X(001).
      *       Flag compensazione valuta di addebito/banca

           05 BE3P02-OPE-FL-COND   PIC  X(001).
      *       Flag di condizionato

           05 BE3P02-OPE-FL-URGE   PIC  X(001).
      *       Flag di movimento

           05 BE3P02-OPE-FL-ANT-ES PIC  X(001).
      *       Flag di antergata esente

           05 BE3P02-OPE-O-TP-PAE  PIC  X(001).
      *       Tipo paese (UE, SEPA, ecc.)

           05 BE3P02-OPE-MIT-BIC   PIC  X(011).
      *       BIC della banca mittente

           05 BE3P02-OPE-MIT-ABI   PIC  X(005).
      *       ABI della banca mittente

           05 BE3P02-OPE-MIT-CAB   PIC  X(005).
      *       CAB della banca mittente

           05 BE3P02-OPE-D-TP-PAE  PIC  X(001).
      *       Tipo paese (UE, SEPA, ecc.)

           05 BE3P02-OPE-DES-BIC   PIC  X(011).
      *       BIC della banca destinataria

           05 BE3P02-OPE-DES-ABI   PIC  X(005).
      *       ABI della banca destinataria

           05 BE3P02-OPE-DES-CAB   PIC  X(005).
      *       CAB della banca destinataria

           05 BE3P02-OPE-FIL-P     PIC  X(005).
      *       Filiale di provenienza

           05 BE3P02-OPE-BIC-FIL-P PIC  X(011).
      *       BIC della filiale di provenienza

           05 BE3P02-OPE-FIL-D     PIC  X(005).
      *       Filiale di destinazione

           05 BE3P02-OPE-BIC-FIL-D PIC  X(011).
      *       BIC della filiale di destinazione

           05 BE3P02-OPE-TM-ORD-MV PIC  X(006).
      *       Ora ordine movimento

           05 BE3P02-OPE-DT-AC-MV  PIC  X(008).
      *       Data accettazione del movimento

           05 BE3P02-OPE-DT-VAL-BK PIC  X(008).
      *       Data valuta banca del movimento

           05 BE3P02-OPE-DT-REG    PIC  X(008).
      *       Data regtolamento nel formato SSAAMMGG

           05 BE3P02-OPE-DT-ACMW-O PIC  X(008).
      *       Data accettazione movimento originario
      *       (valorizzata solo per storni in spedizione)

           05 BE3P02-OPE-DT-VLBK-O PIC  X(008).
      *       valuta banche del movimento originario
      *       (valorizzata solo per storni in spedizione)

           05 BE3P02-OPE-DT-REG-O PIC  X(008).
      *       Data regolamento movimento originario
      *       (valorizzata solo per storni in spedizione)

           05 BE3P02-OPE-CAUS-ABI  PIC  X(005).
      *       Causale interna cedacri di procedura

           05 BE3P02-OPE-DESC-CAUS PIC  X(050).
      *       Info cliente-cliente

           05 BE3P02-OPE-SP-ANT-CL PIC S9(006) COMP-3.
      *       Spese per antergazione calcolate

           05 BE3P02-OPE-SP-ANT-RI PIC S9(006) COMP-3.
      *       Spese per antergazione riscosse

           05 BE3P02-OPE-SP-IB-CL  PIC S9(006) COMP-3.
      *       Spese per IBAN errate/mancanti calcolate

           05 BE3P02-OPE-SP-IB-RI  PIC S9(006) COMP-3.
      *       Spese per IBAN errate/mancanti riscosse

           05 BE3P02-OPE-ON-BI-CL  PIC S9(006) COMP-3.
      *       Oneri su Bir calcolati

           05 BE3P02-OPE-ON-BI-RI  PIC S9(006) COMP-3.
      *       Oneri su Bir riscossi

101010     05 BE3P02-MO-PROG-ULT-AGG PIC X(20).
101010*       Programma ultimo aggiornamento tabella BE00TBMO
101010
101010*    05 FILLER               PIC  X(200).
101010     05 FILLER               PIC  X(180).


      ******************************************************************
      * DATI PRESENTI IN TABELLA BE00TBAG                              *
      ******************************************************************

           05 BE3P02-ORD-COD-FISC  PIC  X(016).
      *       Codice fiscale ordinante

           05 BE3P02-ORD-TP-ID-ORI PIC  X(001).
      *       Tipo identificativo ordinante originario
      *       B=BIC P=Private C=cd.fiscale A=cd.azienda I=IBAN

           05 BE3P02-ORD-ID-ORI    PIC  X(035).
      *       Codice identificativo dell'ordinante

           05 BE3P02-ORD-TIP-IDEN  PIC  X(001).
      *       Tipologia del codice identificativo dell'ordinante

           05 BE3P02-ORD-COD-IDEN  PIC  X(035).
      *       Codice identificativo dell'ordinante

           05 BE3P02-ORD-NDG       PIC  X(012).
      *       NDG ordinante

           05 BE3P02-ORD-FL-ST-CON PIC  X(001).
      *       Flag di stampa contabile dell'ordinante

           05 BE3P02-ORD-ANAG-EFF  PIC  X(070).
      *       Anagrafica ordinanate effettivo

           05 BE3P02-ORD-INDI-EFF  PIC  X(140).
      *       Indirizzo ordinanante effettivo

           05 BE3P02-ORD-PAED-EFF  PIC  X(002).
      *       Codice paese ISO di domicilio dell'ordinante effettivo

           05 BE3P02-ORD-CAP-EFF   PIC S9(005) COMP-3.
      *       CAP del comune dell'ordinante effettivo

           05 BE3P02-ORD-COMU-EFF  PIC  X(050).
      *       Comune dell'ordinante effettivo

           05 BE3P02-ORD-PROV-EFF  PIC  X(02).
      *       Provincia dell'ordinante effettiva

           05 BE3P02-ORD-COD-P-EFF PIC  X(02).
      *       Codice paese ISO ordinante effettivo

           05 BE3P02-ORD-TP-ID-EFF PIC  X(01).
      *       Tipo identification (B=BIC, P=private) effettivo

           05 BE3P02-ORD-ID-EFF    PIC  X(035).
      *       Identification dell'ordinante effettivo

           05 BE3P02-BEN-COD-FISC  PIC  X(016).
      *       Codice fiscale del beneficiario

           05 BE3P02-BEN-TP-ID-ORI PIC  X(001).
      *       Tipo identificativo beneficiario originario
      *       B=BIC P=Private C=cd.fiscale A=cd.azienda I=IBAN

           05 BE3P02-BEN-ID-ORI    PIC  X(035).
      *       Codice identificativo del beneficiario

           05 BE3P02-BEN-TIP-IDEN  PIC  X(001).
      *       Tipologia del codice identificativo del beneficiario

           05 BE3P02-BEN-COD-IDEN  PIC  X(035).
      *       Codice identificativo del beneficiario

           05 BE3P02-BEN-NDG       PIC  X(012).
      *       NDG beneficiario (per movimenti interni)

           05 BE3P02-BEN-FL-ST-CON PIC  X(001).
      *       Flag di stampa contabile del beneficiario

           05 BE3P02-BEN-ANAG-EFF  PIC  X(070).
      *       Anagrafica beneficiario effettiva

           05 BE3P02-BEN-INDI-EFF  PIC  X(140).
      *       Indirizzo beneficiario effettivo

           05 BE3P02-BEN-PAED-EFF  PIC  X(002).
      *       Codice paese ISO di domicilio del beneficiario effettivo

           05 BE3P02-BEN-CAP-EFF   PIC S9(005) COMP-3.
      *       CAP del comune beneficiacio effettivo

           05 BE3P02-BEN-COMU-EFF  PIC  X(050).
      *       Comune del beneficiario effettivo

           05 BE3P02-BEN-PROV-EFF  PIC  X(002).
      *       Provincia del beneficiario effettiva

           05 BE3P02-BEN-COD-P-EFF PIC  X(002).
      *       Codice paese ISO beneficiario effettivo

           05 BE3P02-BEN-TP-ID-EFF PIC  X(001).
      *       Tipo identification (B=BIC, P=private) effettivo

           05 BE3P02-BEN-ID-EFF    PIC  X(035).
      *       Identification del beneficiario effettivo

           05 BE3P02-OPE-NOTE-INT  PIC  X(080).
      *       Note ad uso interno da usare per la funzione di rimando

           05 BE3P02-OPE-CONTR-INV PIC  X(004).
      *       Controllo invarianza

           05 BE3P02-OPE-IMP-DIV   PIC S9(018) COMP-3.
      *       Importo del singolo movimento in divisa

           05 BE3P02-OPE-DT-RI-CAM PIC  X(008).
      *       Data riferimento del cambio

           05 BE3P02-OPE-CAMBIO    PIC S9(018) COMP-3.
      *       Cambio dell'operazione

           05 BE3P02-OPE-IMP-COMP  PIC S9(018) COMP-3.
      *       Importo compensativo presunto per deleghe fiscali

           05 BE3P02-OPE-CANALE    PIC  X(001).
      *       Canale di provenienza standard Cedacri

           05 BE3P02-OPE-TIPO-ALIM PIC  X(001).
      *       Tipo alimentazione (on-line, batch)

           05 BE3P02-OPE-COD-SS-D  PIC  X(002).
      *       Codice sottosistema di destinazione

           05 BE3P02-OPE-DT-RG-RIC PIC  X(008).
      *       Data regolamento richiesta

           05 BE3P02-OPE-MD-ULT-M  PIC  X(001).
      *       Tipo ultima modifica

           05 BE3P02-OPE-DT-ULT-M  PIC  X(008).
      *       Data di ultima variazione del movimento

           05 BE3P02-OPE-TM-ULT-M  PIC  X(006).
      *       Ora di ultima variazione del movimento

           05 BE3P02-OPE-UF-ULT-M  PIC S9(005) COMP-3.
      *       Filiale ultima modifica

           05 BE3P02-OPE-OP-ULT-M  PIC  X(012).
      *       NDG operatore ultima variazione

           05 BE3P02-OPE-US-ULT-M  PIC  X(012).
      *       UserId ultima variazione

           05 BE3P02-OPE-CL-ULT-M  PIC  X(003).
      *       Classe dati variati

           05 BE3P02-OPE-MD-AU-1   PIC  X(001).
      *       Tipo autorizzazione

           05 BE3P02-OPE-TP-AU-1   PIC  X(001).
      *       Tipo di prima autorizzazione

           05 BE3P02-OPE-DT-AU-1   PIC  X(008).
      *       Data di prima autorizzazione

           05 BE3P02-OPE-TM-AU-1   PIC  X(006).
      *       Ora di prima autorizzazione

           05 BE3P02-OPE-FL-AU-1   PIC S9(005) COMP-3.
      *       Filiale di prima autorizzazione

           05 BE3P02-OPE-OP-AU-1   PIC  X(012).
      *       NDG operatore prima autorizzazione

           05 BE3P02-OPE-US-AU-1   PIC  X(012).
      *       UserId prima autorizzazione

           05 BE3P02-OPE-MD-AU-2   PIC  X(001).
      *       Tipo autorizzazione

           05 BE3P02-OPE-TP-AU-2   PIC  X(001).
      *       Tipo di seconda autorizzazione

           05 BE3P02-OPE-DT-AU-2   PIC  X(008).
      *       Data di seconda autorizzazione

           05 BE3P02-OPE-TM-AU-2   PIC  X(006).
      *       Ora di seconda autorizzazione

           05 BE3P02-OPE-FL-AU-2   PIC S9(005) COMP-3.
      *       Filiale di seconda autorizzazione

           05 BE3P02-OPE-OP-AU-2   PIC  X(012).
      *       NDG operatore seconda autorizzazione

           05 BE3P02-OPE-US-AU-2   PIC  X(012).
      *       UserId seconda autorizzazione

           05 BE3P02-OPE-DT-APP-IN PIC  X(008).
      *       Data della giornata applicativa di acquisizione

           05 BE3P02-OPE-DT-APP-OU PIC  X(008).
      *       Data della giornata applicativa di evasione

           05 BE3P02-OPE-KEY-SS-IN PIC  X(050).
      *       Chiave fornita dal sottosistema alimentante

           05 BE3P02-OPE-KEY-ALLE  PIC  X(050).
      *       Chiave di collegamento con allegati

           05 BE3P02-OPE-FL-AN     PIC  X(001).
      *       Flag di controllo anagrafico

           05 BE3P02-OPE-FL-ES-ADD PIC  X(001).
      *       Flag di esito addebito

           05 BE3P02-OPE-FL-STO    PIC  X(001).
      *       Flag di utilizzo storico piazzatura

           05 BE3P02-OPE-FL-VR-ADD PIC  X(001).
      *       Flag di variazione valuta addebito

           05 BE3P02-OPE-FL-FZ-ANT PIC  X(001).
      *       Flag di forzatura antergazione

           05 BE3P02-OPE-FL-FZ-COO PIC  X(001).
      *       Flag di forzatura coordinate

           05 BE3P02-OPE-AQ-DT     PIC  X(008).
      *       Data di produzione scritura contabile acquisizione

           05 BE3P02-OPE-AQ-DT-CON PIC  X(008).
      *       Data contabile di acquisizione

           05 BE3P02-OPE-AQ-RI-CAR PIC S9(011) COMP-3.
      *       Riferimento contabile di carico in acquisizione

           05 BE3P02-OPE-AQ-IN-CAR PIC  X(005).
      *       Filiale di inziativa carico acquisizione

           05 BE3P02-OPE-AQ-TP-CAR PIC  X(001).
      *       Tipo carico acquisizione (iniziativa/conformità)

           05 BE3P02-OPE-AQ-CF-CAR PIC  X(005).
      *       Filiale di conformità carico acquisizione

           05 BE3P02-OPE-AQ-RI-SCA PIC S9(011)V USAGE COMP-3.
      *       Riferimento contabile di scarico in acquisizione

           05 BE3P02-OPE-AQ-IN-SCA PIC  X(005).
      *       Filiale di iniziativa in scarico acquisizione

           05 BE3P02-OPE-AQ-TP-SCA PIC  X(001).
      *       Tipo scarico acquisizione (iniziativa/conformita')

           05 BE3P02-OPE-AQ-CF-SCA PIC  X(005).
      *       Filiale di conformità in scarico acquisizione

           05 BE3P02-OPE-AQ-NM-CAR PIC S9(009)V USAGE COMP-3.
      *       Conto contabilita' di raccordo in acquisizione
      *       in fase di carico

           05 BE3P02-OPE-AQ-NM-SCA PIC S9(009)V USAGE COMP-3.
      *       Conto contabilita' di raccordo in acquisizione
      *       in fase di scarico

           05 BE3P02-OPE-EV-DT     PIC  X(008).
      *       Data di produzione scritura contabile evasione

           05 BE3P02-OPE-EV-DT-CON PIC  X(008).
      *       Data contabile di evasione

           05 BE3P02-OPE-EV-RI-CAR PIC S9(011)V USAGE COMP-3.
      *       Riferimento contabile di carico in evasione

           05 BE3P02-OPE-EV-IN-CAR PIC  X(005).
      *       Filiale di inziativa carico evasione

           05 BE3P02-OPE-EV-CF-CAR PIC  X(005).
      *       Filiale di conformità carico evasione

           05 BE3P02-OPE-EV-TP-CAR PIC  X(001).
      *       Tipo carico evasione (iniziativa/conformità)

           05 BE3P02-OPE-EV-RI-SCA PIC S9(011)V USAGE COMP-3.
      *       Riferimento contabile di scarico in evasione

           05 BE3P02-OPE-EV-IN-SCA PIC  X(005).
      *       Filiale di iniziativa in scarico evasione

           05 BE3P02-OPE-EV-TP-SCA PIC  X(001).
      *       Tipo scarico evasione (iniziativa/conformita')

           05 BE3P02-OPE-EV-CF-SCA PIC  X(005).
      *       Filiale di conformità in scarico evasione

           05 BE3P02-OPE-EV-NM-CAR PIC S9(009)V USAGE COMP-3.
      *       Conto contabilità di raccordo in evasione
      *       in fase di carico

           05 BE3P02-OPE-EV-NM-SCA PIC S9(009)V USAGE COMP-3.
      *       Conto contabilità di raccordo in evasione
      *       in fase di scarico

           05 BE3P02-OPE-ROUT-PEA  PIC  X(010).
      *       Canale di regolamento

           05 BE3P02-OPE-TIP-NOTE    PIC  X(002).
      *       Tipo note:
      *       SS=SCT strutturate, SN=SCT non strutturate
      *       B= bonifici nazionali

           05 BE3P02-OPE-NOTE.
      *       Campo note

              10 BE3P02-OPE-NOTE-LEN PIC S9(004) COMP.
      *          Lunghezza note

              10 BE3P02-OPE-NOTE-TEXT PIC X(500).
      *          Note

           05 BE3P02-OPE-RI-OP-OR  PIC  X(035).
      *       Codice riferimento operazione insertita ordinante

           05 BE3P02-OPE-044-BIC-T PIC  X(011).
      *       BIC tramite della banca di destinazione se esterno

           05 BE3P02-OPE-044-ABI-T PIC  X(005).
      *       ABI tramite

           05 BE3P02-OPE-044-CAB-T PIC  X(005).
      *       CAB tramite

           05 BE3P02-OPE-044-UFF-O PIC  X(002).
      *       Ufficio mittente 3° sottocampo IDC 044

           05 BE3P02-OPE-054-BIC-T PIC  X(011).
      *       BIC tramite 1 della banca di destinazione se esterno

           05 BE3P02-OPE-054-ABI-T PIC  X(005).
      *       ABI tramite

           05 BE3P02-OPE-054-CAB-T PIC  X(005).
      *       CAB tramite

           05 BE3P02-OPE-054-UFF-D PIC  X(002).
      *       Ufficio mittente  3° sottocampo IDC 054

           05 BE3P02-OPE-040-UFF-M PIC  X(002).
      *       Ufficio mittente  3° sottocampo IDC 040

           05 BE3P02-OPE-040-UFF-D PIC  X(002).
      *       Ufficio ricevente 3° sottocampo IDC 050

           05 BE3P02-OPE-BANCA-ORI PIC  X(016).
      *       IDC 107: banca originante

           05 BE3P02-OPE-BANCA-FIN PIC  X(016).
      *       IDC 108: banca originante

           05 BE3P02-OPE-DATA-RIFE PIC  X(008).
      *       Data riferimento IDC 031

           05 BE3P02-OPE-TIPO-OPE  PIC  X(002).
      *       Tipo operazione

           05 BE3P02-OPE-CRO-ORIG  PIC  X(035).
      *       CRO originario operazione

           05 BE3P02-OPE-CIFRA-CON PIC  X(005).
      *       Cifra di controllo

           05 BE3P02-OPE-COCK      PIC  X(010).
      *       MAC end to end

           05 BE3P02-OPE-CAB-CM-FI PIC  X(005).
      *       Cab del comune della filiale dell'ordinante

           05 BE3P02-OPE-CAB-CM-OR PIC  X(005).
      *       Cab del comune dell'ordinante

           05 BE3P02-OPE-FL-MD-TRA PIC  X(002).
      *       Flag di modalità trasmissiva

           05 BE3P02-OPE-FL-RIT-FM PIC  X(001).
      *       Flag ritardo forza maggiore

           05 BE3P02-OPE-DES-RETU  PIC  X(035).
      *       Messaggio di errore ritornato dal sistema

           05 BE3P02-OPE-COD-ERR   PIC  X(004).
      *       Codice errore in caso di ritorno errato

130826     05 BE3P02-ABI-CONTROP   PIC  X(005).
      *       Codice BIC banca controparte

130826     05 BE3P02-BIC-CONTROP   PIC  X(011).
      *       Codice BIC banca controparte

130826     05 BE3P02-FL-WLC-BANCA  PIC  X(001).
      *       Flag presenza banca nella liste negative

130826     05 BE3P02-DES-BANCA     PIC  X(105).
      *       Ragine sociale banca presente in liste negative

130826*    05 FILLER               PIC  X(166).
130826     05 FILLER               PIC  X(044).

