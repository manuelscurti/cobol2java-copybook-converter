      ******************************************************************
      *                         FAXC0002                               *
      *                                                                *
      *  COMMAREA UTILIZZATA DAI PROGRAMMI  D05221A0, D05222A0         *
      *  FUNZIONE  : DFAX                                              *
      *  LUNGHEZZA :  150 BYTES                                        *
      *                                                                *
      ******************************************************************
      * IS050614 IT140004 RINOMINATI PGM DFAX
      *
      **** 01 FAXC0002.
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
           02 :PR:INPUT.
              03 :PR:NOME-CODA                      PIC  X(8).
              03 :PR:MAX-ITEM                       PIC  9(4).          SL060508
      *
           02 :PR:OUTPUT.
              03 :PR:COD-RIT                        PIC  X.
              03 :PR:CODCLI                         PIC  9(14).
              03 :PR:NUMPRA                         PIC  9(14).
      *
      *
           02 FILLER                                PIC  X(59).         SL060508
      **** 02 FILLER                                PIC  X(63).
      *
      ************************** EOM FAXC0002 **************************
