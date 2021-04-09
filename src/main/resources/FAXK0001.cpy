      ******************************************************************
      *                          FAXK0001                              *
      *                                                                *
      ******************************************************************
      * LS140307 ELIMINATA GESTIONE RICONOSCIMENTO AMBIENTE CICS
      *          ADESSO VIENE FATTO TRAMITE LA COPY CICSK001
      * SL201108 MODIFICHE PER DFAX AUTOMATICA DA DIFI
      * IS050614 IT140004 RINOMINATI PGM DFAX
      ******************************************************************
      *
       01 FAXK0001.
      *----------------------------------------------------------------*
      *    LUNGHEZZA COMMAREE
      *----------------------------------------------------------------*
      *
           02 K001-LEN-FAXC0001           PIC S9(04) COMP VALUE +2000.
           02 K001-LEN-FAXC0002           PIC S9(04) COMP VALUE +150.
           02 K001-LEN-COMENCH            PIC S9(04) COMP VALUE +100.
      *
      *----------------------------------------------------------------*
      *          CODICI TRANSAZIONI PROGRAMMI
      *----------------------------------------------------------------*
      *
      *    02 K001-T-07210                PIC  X(04) VALUE 'DF2X'.      IS050614
           02 K001-T-05220                PIC  X(04) VALUE 'DF2X'.      IS050614
      *    02 K001-T-07211                PIC  X(04) VALUE 'DFAX'.      IS050614
           02 K001-T-05221                PIC  X(04) VALUE 'DFAX'.      IS050614
      *    02 K001-T-07212                PIC  X(04) VALUE 'DF1X'.      IS050614
           02 K001-T-05222                PIC  X(04) VALUE 'DF1X'.      IS050614
      *
      *----------------------------------------------------------------*
      *          PROGRAMMI CHIAMANTI CORRETTI
      *----------------------------------------------------------------*
      *
      *    02 K001-D07210A0               PIC X(08).                    IS050614
           02 K001-D05220A0               PIC X(08).                    IS050614
      *       88 K001-D07210A0-OK         VALUE 'D07214A0'.             IS050614
              88 K001-D05220A0-OK         VALUE 'D05223A0'.             IS050614
      *
      *    02 K001-D07211A0               PIC X(08).                    IS050614
           02 K001-D05221A0               PIC X(08).                    IS050614
      *       88 K001-D07211A0-OK         VALUE 'D07211A0' 'D07212A0'   IS050614
              88 K001-D05221A0-OK         VALUE 'D05221A0' 'D05222A0'   IS050614
                                                'D07213A0'              SL201108
                                                'SCHERMO'  'PIENCH'.
      *
      *    02 K001-D07212A0               PIC X(08).                    IS050614
           02 K001-D05222A0               PIC X(08).                    IS050614
      *       88 K001-D07212A0-OK         VALUE 'D07211A0'.             IS050614
              88 K001-D05222A0-OK         VALUE 'D05221A0'.             IS050614
      *
      *----------------------------------------------------------------*
      *
      *----------------------------------------------------------------*
      *          TIPO OPERAZIONE SULLA PRATICA
      *----------------------------------------------------------------*
      *
           02  K001-TIPO                  PIC X(01).
               88 K001-FAX                VALUE 'F'.
               88 K001-MAIL               VALUE 'M'.
      *
      *----------------------------------------------------------------*
      *          CODICE RITORNO
      *----------------------------------------------------------------*
      *
           02 K001-RESP                   PIC S9(08) COMP VALUE +0.
           02 K001-ABD-SQLCODE            PIC -------999  VALUE ZERO.
      *
      *----------------------------------------------------------------*
      *          CAMPI PER GESTIONE DATA
      *----------------------------------------------------------------*
      *
           02 K001-DATA-ZERO              PIC  X(10) VALUE '01.01.0001'.
      *
           02 K001-DATA-6GMA              PIC  9(06) VALUE ZERO.
           02 FILLER REDEFINES K001-DATA-6GMA.
              03 K001-DATA6GMA-GG         PIC  9(02).
              03 K001-DATA6GMA-MM         PIC  9(02).
              03 K001-DATA6GMA-AA         PIC  9(02).
      *
           02 K001-DATA-6                 PIC  9(06) VALUE ZERO.
           02 FILLER REDEFINES K001-DATA-6.
              03 K001-DATA6-AA            PIC  9(02).
              03 K001-DATA6-MM            PIC  9(02).
              03 K001-DATA6-GG            PIC  9(02).
      *
           02 K001-DATA-8GMA              PIC  9(08) VALUE ZERO.
           02 FILLER REDEFINES K001-DATA-8GMA.
              03 K001-DATA8GMA-GG         PIC  9(02).
              03 K001-DATA8GMA-MM         PIC  9(02).
              03 K001-DATA8GMA-AA         PIC  9(04).
      *
           02 K001-DATA-8                 PIC  9(08) VALUE ZERO.
           02 FILLER REDEFINES K001-DATA-8.
              03 K001-DATA8-ANNO          PIC  9(04).
              03 FILLER REDEFINES K001-DATA8-ANNO.
                 04 K001-DATA8-SS         PIC  9(02).
                 04 K001-DATA8-AA         PIC  9(02).
              03 K001-DATA8-MM            PIC  9(02).
              03 K001-DATA8-GG            PIC  9(02).
      *
           02 K001-DATA-10.
              03 K001-DATA10-GG           PIC  9(02) VALUE ZERO.
              03 FILLER                   PIC  X(01) VALUE '.'.
              03 K001-DATA10-MM           PIC  9(02) VALUE ZERO.
              03 FILLER                   PIC  X(01) VALUE '.'.
              03 K001-DATA10-ANNO         PIC  9(04) VALUE ZERO.
              03 FILLER REDEFINES K001-DATA10-ANNO.
                 04 K001-DATA10-SS        PIC  9(02).
                 04 K001-DATA10-AA        PIC  9(02).
      *
      *----------------------------------------------------------------*
      *          CAMPI PER VARIABILI CON DEFINIZIONI DIVERSE
      *----------------------------------------------------------------*
      *
           02 K001-FLD-NUM-14             PIC  9(14) VALUE ZERO.
           02 K001-FLD-ALF-14 REDEFINES
              K001-FLD-NUM-14             PIC  X(14).
           02 FILLER REDEFINES K001-FLD-NUM-14.
              03 FILLER                   PIC  X(13).
              03 K001-FLD-ALF-1           PIC  X(01).
              03 K001-FLD-NUM-1 REDEFINES
                 K001-FLD-ALF-1           PIC  9(01).
           02 FILLER REDEFINES K001-FLD-NUM-14.
              03 FILLER                   PIC  X(12).
              03 K001-FLD-ALF-2           PIC  X(02).
              03 K001-FLD-NUM-2 REDEFINES
                 K001-FLD-ALF-2           PIC  9(02).
           02 FILLER REDEFINES K001-FLD-NUM-14.
              03 FILLER                   PIC  X(11).
              03 K001-FLD-ALF-3           PIC  X(03).
              03 K001-FLD-NUM-3 REDEFINES
                 K001-FLD-ALF-3           PIC  9(03).
           02 FILLER REDEFINES K001-FLD-NUM-14.
              03 FILLER                   PIC  X(10).
              03 K001-FLD-ALF-4           PIC  X(04).
              03 K001-FLD-NUM-4 REDEFINES
                 K001-FLD-ALF-4           PIC  9(04).
           02 FILLER REDEFINES K001-FLD-NUM-14.
              03 FILLER                   PIC  X(09).
              03 K001-FLD-ALF-5           PIC  X(05).
              03 K001-FLD-NUM-5 REDEFINES
                 K001-FLD-ALF-5           PIC  9(05).
           02 FILLER REDEFINES K001-FLD-NUM-14.
              03 FILLER                   PIC  X(08).
              03 K001-FLD-ALF-6           PIC  X(06).
              03 K001-FLD-NUM-6 REDEFINES
                 K001-FLD-ALF-6           PIC  9(06).
           02 FILLER REDEFINES K001-FLD-NUM-14.
              03 FILLER                   PIC  X(07).
              03 K001-FLD-ALF-7           PIC  X(07).
              03 K001-FLD-NUM-7 REDEFINES
                 K001-FLD-ALF-7           PIC  9(07).
           02 FILLER REDEFINES K001-FLD-NUM-14.
              03 FILLER                   PIC  X(06).
              03 K001-FLD-ALF-8           PIC  X(08).
              03 K001-FLD-NUM-8 REDEFINES
                 K001-FLD-ALF-8           PIC  9(08).
           02 FILLER REDEFINES K001-FLD-NUM-14.
              03 FILLER                   PIC  X(05).
              03 K001-FLD-ALF-9           PIC  X(09).
              03 K001-FLD-NUM-9 REDEFINES
                 K001-FLD-ALF-9           PIC  9(09).
           02 FILLER REDEFINES K001-FLD-NUM-14.
              03 FILLER                   PIC  X(04).
              03 K001-FLD-ALF-10          PIC  X(10).
              03 K001-FLD-NUM-10 REDEFINES
                 K001-FLD-ALF-10          PIC  9(10).
           02 FILLER REDEFINES K001-FLD-NUM-14.
              03 FILLER                   PIC  X(03).
              03 K001-FLD-ALF-11          PIC  X(11).
              03 K001-FLD-NUM-11 REDEFINES
                 K001-FLD-ALF-11          PIC  9(11).
           02 FILLER REDEFINES K001-FLD-NUM-14.
              03 FILLER                   PIC  X(02).
              03 K001-FLD-ALF-12          PIC  X(12).
              03 K001-FLD-NUM-12 REDEFINES
                 K001-FLD-ALF-12          PIC  9(12).
           02 FILLER REDEFINES K001-FLD-NUM-14.
              03 FILLER                   PIC  X(01).
              03 K001-FLD-ALF-13          PIC  X(13).
              03 K001-FLD-NUM-13 REDEFINES
                 K001-FLD-ALF-13          PIC  9(13).
      *
      *----------------------------------------------------------------*
      *   CAMPI PER VISUALIZZAZIONE PAGINA
      *----------------------------------------------------------------*
      *
           02 K001-PAGINA.
              03 K001-PAG-C               PIC  9(01) VALUE ZERO.
              03 FILLER                   PIC  X(01) VALUE '/'.
              03 K001-PAG-T               PIC  9(01) VALUE ZERO.
      *
           02 K001-PAGINA3.
              03 K001-PAG3-C              PIC  9(03) VALUE ZERO.
              03 FILLER                   PIC  X(01) VALUE '/'.
              03 K001-PAG3-T              PIC  9(03) VALUE ZERO.
      *
      *----------------------------------------------------------------*
      *          CURSORE
      *----------------------------------------------------------------*
      *
           02 K001-CURS                   PIC S9(04) COMP VALUE +0.
      *
      *----------------------------------------------------------------*
      *          AREA PER LANCIO TRANSAZIONE CICS DA SCHERMO VUOTO
      *----------------------------------------------------------------*
      *
           02 K001-LANCIA-TRANS.
              03 K001-TRANSID             PIC X(04).
              03 FILLER                   PIC X(01).
              03 K001-DATI-LANCIO         PIC X(75).
              03 K001-MSG-LANCIO-1        PIC X(80).
              03 K001-MSG-LANCIO-2        PIC X(80).
           02 K001-LEN-LANCIA-TRANS       PIC S9(4) COMP VALUE +240.
      *
      *----------------------------------------------------------------*
      *          CAMPI PER PULIZIA VIDEO
      *----------------------------------------------------------------*
      *
           02 K001-CLEAR                  PIC  X(01) VALUE LOW-VALUE.
      *
      *----------------------------------------------------------------*
      *          NUMERO MASSIMO PAGINE VIDEO
      *----------------------------------------------------------------*
      *
           02 K001-DIM-TAB-PAGING-9       PIC  9(03) VALUE 9.
           02 K001-DIM-TAB-PAGING-99      PIC  9(03) VALUE 99.
           02 K001-DIM-TAB-PAGING-999     PIC  9(03) VALUE 999.
      *
      *----------------------------------------------------------------*
      *          NUMERO MASSIMO ELEMENTI PER PAGINA VIDEO
      *----------------------------------------------------------------*
      *
           02 K001-DIM-COL-PAGING-2       PIC  9(02) VALUE 2.
           02 K001-DIM-COL-PAGING-3       PIC  9(02) VALUE 3.
           02 K001-DIM-RIGHE-PAGING-2     PIC  9(02) VALUE 2.
           02 K001-DIM-RIGHE-PAGING-3     PIC  9(02) VALUE 3.
           02 K001-DIM-RIGHE-PAGING-4     PIC  9(02) VALUE 4.
           02 K001-DIM-RIGHE-PAGING-5     PIC  9(02) VALUE 5.
           02 K001-DIM-RIGHE-PAGING-15    PIC  9(02) VALUE 15.
      *
      *----------------------------------------------------------------*
      *       RIGHE/COLONNE PER MESSAGGI -
      *----------------------------------------------------------------*
      *
           02  K001-MAX-PAG-MSG           PIC  9(02) VALUE 2.
           02  K001-MAX-RIGHE-MSG         PIC  9(02) VALUE 3.
           02  K001-MAX-COL-MSG           PIC  9(02) VALUE 40.
      *
      *----------------------------------------------------------------*
      *          AREA PER RICONOSCIMENTO AMBIENTE  CICS TEST/PROD
      *----------------------------------------------------------------*
      *
           02 FILLER                      PIC  X(04).                   LS140307
      *
      ********************** EOM FAXK0001   ****************************
