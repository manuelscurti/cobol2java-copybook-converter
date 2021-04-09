      ******************************************************************
      *                         FAXC0001                               *
      *                                                                *
      *  COMMAREA UTILIZZATA DAL PROGRAMMA  D05221A0                   *
      *  FUNZIONE  : DFAX                                              *
      *  LUNGHEZZA :  2000 BYTES                                       *
      *                                                                *
      ******************************************************************
      * SL041007 DFAX PER NETWORK
      * SL230508 MODIFICA PER MEM GECO
      * SL280508 ODS 61/08/MCD DEL 20/05/2008
      * SL121108 ODS 155/08/MCD DEL 29/10/2008
      * SL201108 MODIFICA PER DFAX AUTOMATICA DA DIFI
      * SL090609 ODS 147/09/MCD DEL 20/05/2009 - REFERENZA FOVE
      * IS050614 IT140004 RINOMINATI PGM DFAX
      ******************************************************************
      *
      **** 01 FAXC0001.
      *
           02 :PR:TIPO-OPERAZIONE                   PIC  X.
              88  :PR:TIPO-OPERAZIONE-TRANSID       VALUE 'T'.
              88  :PR:TIPO-OPERAZIONE-XCTL          VALUE 'P'.
              88  :PR:TIPO-OPERAZIONE-SCREEN        VALUE 'S'.
              88  :PR:TIPO-OPERAZIONE-LINK          VALUE 'L'.
              88  :PR:TIPO-OPERAZIONE-START         VALUE 'R'.
      *
           02 :PR:PGM-CHIAMATO                      PIC  X(08).
           02 :PR:PGM-CHIAMANTE                     PIC  X(08).
           02 :PR:PGM-DA-CHIAMARE                   PIC  X(08).
      *
           02 :PR:TRN-CHIAMATO                      PIC  X(04).
           02 :PR:TRN-CHIAMANTE                     PIC  X(04).
      *
           02 :PR:PGM-INIZIO                        PIC  X(08).
      *
           02 FILLER                                PIC  X(09).
      *
      *                                             -----------
      *                                             TOT.   50
      *
      *-----------------------------------------------------------------
      *    CAMPI PASSATI PER GESTIONE PRATICHE IN STUDIO     (700 BYTES)
      *-----------------------------------------------------------------
      *
           02 :PR:DATI.
              03 :PR:CODCLI                         PIC  9(14).
              03 :PR:CODSOC                         PIC  9(03).
              03 :PR:SIGLA                          PIC  X(03).
              03 :PR:NOMCLI                         PIC  X(25).
              03 :PR:NUMPRA                         PIC  9(14).
              03 :PR:VDR                            PIC  9(07).
              03 :PR:IDTBLO                         PIC  9(05).
              03 :PR:CODSTU                         PIC  9(03).
              03 :PR:DECIS                          PIC  XX.
              03 :PR:APP-RIF                        PIC  X.
              03 :PR:SCELTA                         PIC  X.
                 88  :PR:FAX                        VALUE 'F'.
      *SL280508  88  :PR:MAIL                       VALUE 'M'.
              03 :PR:SCELTA-MAIL                    PIC  X.             SL280508
                 88  :PR:MAIL                       VALUE 'M'.          SL280508
              03 :PR:NUMFAX                         PIC  X(12).
              03 :PR:INDMAIL                        PIC  X(35).
              03 :PR:PRATICA                        PIC  X.
                 88  :PR:CARTA                      VALUE 'C'.
                 88  :PR:CLASSICO                   VALUE 'L'.
              03 :PR:ESITO                          PIC  X.
                 88  :PR:ESITO-OK                   VALUE 'S'.
              03 :PR:BONIF                          PIC  X.
                 88  :PR:BONIF-OK                   VALUE 'S'.
              03 :PR:PF10                           PIC  X.
                 88  :PR:PF10-OK                    VALUE 'S'.
              03 :PR:PF11                           PIC  X.
                 88  :PR:PF11-OK                    VALUE 'S'.
              03 :PR:IMPFIN                         PIC  9(7)V99.
              03 :PR:IMSIP                          PIC  9(5)V99.
              03 :PR:INTVDR                         PIC  9(7)V99.
              03 :PR:IMPASS                         PIC  9(5)V99.
              03 :PR:IMPMENS                        PIC  9(7)V99.
              03 :PR:NUMDUR                         PIC  9(3).
              03 :PR:CODMAXI                        PIC  X.
              03 :PR:IMPMAXI                        PIC  9(7)V99.
              03 :PR:BANCA                          PIC  X.
              03 :PR:PRODOTTO                       PIC  XXX.
              03 :PR:ABI                            PIC  9(5).
              03 :PR:CAB                            PIC  9(5).
              03 :PR:CONTO                          PIC  X(12).
              03 :PR:TITOLARE                       PIC  X(30).
              03 :PR:INDIR-VDR                      PIC  X(30).
              03 :PR:CAP-VDR                        PIC  9(05).
              03 :PR:CITTA-VDR                      PIC  X(30).
              03 :PR:TIME                           PIC  X(04).
              03 :PR:AGE                            PIC  9(03).
              03 :PR:IMPEROG                        PIC  9(07)V99.
              03 :PR:VDRFIN                         PIC  9(07).
              03 :PR:VDR-DRBE                       PIC  X.             SL041007
                 88  :PR:DRBE-OK                    VALUE 'S'.          SL041007
              03 :PR:MOD-PAG                        PIC  9.             SL041007
              03 :PR:AGE-STU                        PIC  9(3).          SL230508
              03 :PR:PROROGA                        PIC  9(3).          SL121108
              03 :PR:SCAD                           PIC  9(8).          SL121108
              03 :PR:INDCLI                         PIC  X(30).         SL121108
              03 :PR:CITTACLI                       PIC  X(25).         SL121108
              03 :PR:CAPCLI                         PIC  9(05).         SL121108
              03 :PR:IBAN.                                              SL121108
                 05 :PR:NAZ                         PIC  X(02).         SL121108
                 05 :PR:CHECKDIGIT                  PIC  X(02).         SL121108
                 05 :PR:CIN                         PIC  X.             SL121108
                 05 :PR:ABICLI                      PIC  9(05).         SL121108
                 05 :PR:CABCLI                      PIC  9(05).         SL121108
                 05 :PR:CONTOCLI                    PIC  X(12).         SL121108
      *
              03 :PR:MESSAGGIO                      PIC  X(80).         SL201108
              03  :PR:INVIO                         PIC  X.             SL201108
                  88  :PR:PRIMO-INVIO               VALUE 'S'.          SL201108
                  88  :PR:INVIO-SUCC                VALUE 'N'.          SL201108
              03 :PR:FOVE                           PIC  XX.            SL090609
              03 FILLER                             PIC  X(185).        SL090609
      ********03 FILLER                             PIC  X(187).        SL201108
      ********03 FILLER                             PIC  X(268).        SL121108
      ********03 FILLER                             PIC  X(366).        SL280508
      ********03 FILLER                             PIC  X(367).        SL230508
      ******* 03 FILLER                             PIC  X(370).        SL041007
      ********03 FILLER                             PIC  X(372).
      *
      *-----------------------------------------------------------------
      *    CAMPI PER GESTIONE PAGING (50 BYTES)
      *-----------------------------------------------------------------
      *
           02 :PR:DATI-MESS.
              03 :PR:I-TAB-PAG-M                    PIC  9(03).
              03 :PR:N-PAG-TOT-M                    PIC  9(03).
              03 :PR:N-PAG-COR-M                    PIC  9(03).
              03 :PR:TF-M                           PIC  9(01).
      *
              03 FILLER                             PIC  X(40).
      *
      *-----------------------------------------------------------------
      *    CAMPI PER GESTIONE PAGING MESSAGGI - MAX 9 PAG - (1200 BYTES)
      *-----------------------------------------------------------------
      *
           02 :PR:TAB-MESSAGGI.
              03 :PR:TB-PAG-MESS  OCCURS 9.
              04 :PR:TB-RIGA-MESS OCCURS 3          PIC  X(40).
      *
           02 :PR:AGG-MESS                          PIC  X(01).
      *
           02 :PR:MSG-ESITO                         PIC  X(70).
      *
           02 FILLER                                PIC  X(49).
      *
      *
      ************************** EOM FAXC0001 **************************
