      ******************************************************************
      *                        D05223A0                                *
      *                                                                *
      *  VECCHIO NOME : D07214A0 - RINOMINATO                          *
      *                                                                *
      *  PROCEDURA    : DFAX A SERVIZI                                 *
      *  DESCRIZIONE  :                                                *
      *  CREAZIONE    : GENNAIO 2009                                   *
      *  AUTORE       : LANINI SILVIA                                  *
      *  INPUT        : COMMAREA FAXCSERV (DA SUN)                     *
      *  OUTPUT       :                                                *
      *  PSB          : D05223A                                        *
      *  TRANSID      :                                                *
      *  MAPSET       :                                                *
      *  ELABORAZIONE :                                                *
      *                                                                *
      ******************************************************************
      * SL090609 ODS 147/09/MCD DEL 20/05/2009 - REFERENZA FOVE
      ******************************************************************
      * FC260811  SOSTITUZIONE SIMBOLO EURO CON E PER RDZ E
      *           RICOMPILATO PER MODIFICA COPY CTRCARAW
      ******************************************************************
      * RD251111  ODS 02/11/CRD DOPPIO PRODOTTO PER DEALER FINANCING
      * SL121111  IT110001 - PRODOTTO LIBERTA'
      * SL190412  CORREZIONE A SL121111
      * SL240412  ulteriore CORREZIONE A SL121111
      * SL100913  ODS 26/13/MKV - CAMBIO OGGETTO MAIL ESITO
      * IS050614 IT140004 RINOMINATI PGM DFAX
      * IS100615  ODS DFAX - VARIAZIONE AREA CONDIZIONI ACCESSORIE/NOTE
      * NO220715  IT150017 MAXIRATA VFG - CREDIT BALLOON
      * AR060116  RIALLINEAMENTO VERSIONI OGGETTI A LIBRERIA PROD
      * NO261115  IT150075 UNION 50 E 50
      ******************************************************************
      * MD210218  INTERVENTO PER INCIDENT INC000000188570
      * RP300418 IT180025 DCAM PER WIND - LOTTO 1                      *
      ******************************************************************
      * CA310318 - ODS 17/18/FCP - MODIFICA CAMPO CODSTU
      * SL241018 INCIDENT 200426 PER EVOLUTO IN DCAM                   *
      * RP161018 IT1800260 MICROSERVIZI GESTIONE NUOVO NUM PRATICA     *
      * AR311219 IT190040 RE-INGEGNERIZZAZIONE ACCESSI DB2  WI 4348    *
      ******************************************************************
       IDENTIFICATION  DIVISION.
       PROGRAM-ID.     D05223A0
       ENVIRONMENT  DIVISION.
       CONFIGURATION  SECTION.
       SPECIAL-NAMES.
           DECIMAL-POINT IS COMMA.
       INPUT-OUTPUT  SECTION.
       FILE-CONTROL.
       DATA  DIVISION.
       FILE  SECTION.
      *
       WORKING-STORAGE  SECTION.
      *----------------------------------------------------------------*
      *    COPY UTILIZZATE
      *----------------------------------------------------------------*
      *
           COPY CICSK001.
      *
           COPY DFHAID.
           COPY DFHBMSCA.
           COPY AT3278.
           COPY VARIW963.
      *                    ROUTINE IDENTIFICAZIONE PRATICA CL/CP
           COPY VARIW967.
           COPY VARIW968.
      *
      ***** ROUTINE DI CONTROLLO CARATTERI
           COPY CTRCARAW.
      *
           COPY DB2RET.
           COPY FORDATA.
           COPY ROUCDATE.
      *
           COPY FAXK0001.
      *
           COPY FAXCSERV.
      *
      *    CLASSICO / DEFINIZIONE CHIAVE
      *
           COPY CBADODR.
           COPY CBADOD2.
           COPY CBADOD1.
      *
       01  KEY-DODRAC.
           05  DODRAC-NUM-PRATICA   PIC S9(15) COMP-3 VALUE ZERO.
      *
      *    PERMANENTI / DEFINIZIONE CHIAVE
      *
           COPY BASCARTE.
           COPY BASCAR2.
           COPY BASCAR1.
      *
       01  KEY-CPDRAC.
           05  CPDRAC-NUM-PRATICA   PIC S9(15) COMP-3 VALUE ZERO.
      *
      *    CLIENTI / DEFINIZIONE CHIAVE
      *
           COPY CBACLAR.
      *
       01  KEY-CLDRAC.
           05  CLDRAC-NUM-CLIENTE   PIC S9(15) COMP-3 VALUE ZERO.

       01  REC-IN-ELAB-TCAMCAMP.                                        SL241018
           02 FILLER                PIC X(16)  VALUE 'REC. IN ELAB. ->'.SL241018
           02 W-MSG-KEY-TCAMCAMP.                                       SL241018
              03 FILLER             PIC X(10)  VALUE 'COD CAMP->'.      SL241018
              03 W-MSG-COD-CAMP     PIC X(02)  VALUE SPACE.             SL241018
           02 FILLER                PIC X(02)  VALUE '<-'.              SL241018
      *                                                                 SL241018
       01  REC-IN-ELAB-TINFDGL1.                                        SL241018
           02 FILLER                PIC X(16)  VALUE 'REC. IN ELAB. ->'.SL241018
           02 W-MSG-KEY-TINFDGL1.                                       SL241018
              03 FILLER             PIC X(10)  VALUE 'NUM PRA ->'.      SL241018
              03 W-MSG-DGL1-PRA     PIC 9(14)  VALUE ZERO.              SL241018
           02 FILLER                PIC X(02)  VALUE '<-'.              SL241018
       01  WK-DUR1                 PIC S9(3)    COMP-3    VALUE ZERO.   SL241018
       01  WK-DECOU                PIC S9(7)V99 COMP-3    VALUE ZERO.   SL241018
       01  WK-IMP-ASSIC-IF         PIC S9(7)V99 COMP-3    VALUE ZERO.   SL241018
       01  WK-IMP-ASSIC-GAP-RDP    PIC S9(7)V99 COMP-3    VALUE ZERO.   SL241018
      *
      *
      *    COPY PER ROUTINES
      *
      *                    PER VARIABILI TBLO
           COPY WBMSGSPE.
      *
       01  SW-INDIRIZZO            PIC X   VALUE SPACE.
           88 INDIRIZZO-OK         VALUE 'S'.
           88 INDIRIZZO-KO         VALUE 'N'.
      *
       01  SW-PRATICA              PIC  X(01)      VALUE SPACE.
           88  CLASSICO            VALUE 'C'.
           88  CARTA               VALUE 'P'.
      *
       01  SW-PRODOTTO             PIC  X(03)      VALUE SPACE.
           88  PRODOTTO-OK         VALUE 'MOB' 'VEI' 'VAT' 'CA '.
      *
       01  SW-PRODOTTO-NET           PIC  X(03)      VALUE SPACE.
           88  PRODOTTO-NET-OK       VALUE 'VAT' 'MIN' 'CA '.
      *
       01  SW-JOB                    PIC  X(01)      VALUE SPACE.
           88  ERRORE-JOB                            VALUE 'S'.
      *
      *---- COMMAREA PER IL PGM D05220A0 DI SCRITTURA CODA TD
      *
       01  FAXC0002.
           COPY FAXC0002 REPLACING ==:PR:== BY ==DF1X-==.
      *
      *----------------------------------------------------------------*
      *    CODA DI TS
      *----------------------------------------------------------------*
      *
       01  TS-NOME-CODA                 PIC 9(8).
      *
       01  ITEM-TS                      PIC S9(04) COMP VALUE +0.
       01  LEN-TS                       PIC S9(04) COMP VALUE +80.
       01  AREA-MSG                     PIC X(80).
       01  AREA-CODA                    PIC X(80).
       01  WK-DUR-APP                   PIC 9(3).
       01  WK-GRAFFA-OP                 PIC X    VALUE X'C0'.
       01  WK-GRAFFA-CL                 PIC X    VALUE X'D0'.
       01  WK-A-CAPO.
           02  WK-1-CAPO                PIC X VALUE X'0D'.
           02  WK-2-CAPO                PIC X VALUE X'25'.
       01  FLG-A-CAPO                   PIC X.
           88 A-CAPO-OK                 VALUE 'S'.
       01  WK-CHIOCCIOLA                PIC X    VALUE X'7C'.
      *
       01  WK-IND-RISP                  PIC X(35) VALUE SPACE.
      *
      *01  FAX-SERVER                   PIC X(35) VALUE
      *          'FAXSERVER@FINDOMESTIC.COM'.
      *
       01  FAX-SERVER     PIC X(12)  VALUE 'FAXMAKER.COM'.
      *
       01  TAB-INDIRIZZO.
           02 ELE-TAB-IND    PIC X      OCCURS 40 VALUE SPACE.
      *
       01  TAB-TESTO.
      *    02 WK-ELE-TESTO  PIC X(60)  OCCURS 4.                        IS100615
           02 WK-ELE-TESTO  PIC X(60)  OCCURS 8.                        IS100615

       01  WK-APP-TESTO     PIC X(60).
      *01  MAX-CARA         PIC 9(3)  VALUE 246.                        IS100615
       01  MAX-CARA         PIC 9(3)  VALUE 494.                        IS100615
      *01  MAX-TAB-TEST     PIC 9(1)  VALUE   4.                        IS100615
       01  MAX-TAB-TEST     PIC 9(1)  VALUE   8.                        IS100615
      *
       01  TAB-TESTO-TBLO.
      *    02 WK-ELE-TESTO-TBLO  PIC X(40)  OCCURS 6.                   IS100615
           02 WK-ELE-TESTO-TBLO  PIC X(40)  OCCURS 12.                  IS100615
       01  WK-APP-TESTO-TBLO     PIC X(40).
      *
       01  WK-VOLTE         PIC 9(3).
       01  WK-INDICE        PIC 9(4).
       01  WK-VALUE         PIC S9(8) COMP-3.
       01  WK-DATI.
          03  WK-CODCLI                         PIC  9(14).
          03  WK-CODSOC                         PIC  9(03).
          03  WK-SIGLA                          PIC  X(03).
          03  WK-NOMCLI                         PIC  X(25).
          03  WK-NUMPRA                         PIC  9(14).
          03  WK-VDR                            PIC  9(07).
          03  WK-CODSTU                         PIC  9(03).
          03  WK-DECIS                          PIC  XX.
          03  WK-APP-RIF                        PIC  X.
          03  WK-SCELTA                         PIC  X.
             88   WK-FAX                        VALUE 'F'.
          03  WK-SCELTA-MAIL                    PIC  X.
             88   WK-MAIL                       VALUE 'M'.
          03  WK-NUMFAX                         PIC  X(12).
          03  WK-INDMAIL                        PIC  X(35).
          03  WK-BONIF                          PIC  X.
             88   WK-BONIF-OK                   VALUE 'S'.
          03  WK-IMPFIN                         PIC  9(7)V99.
          03  WK-IMSIP                          PIC  9(5)V99.
          03  WK-INTVDR                         PIC  9(7)V99.
          03  WK-IMPASS                         PIC  9(5)V99.
          03  WK-IMPMENS                        PIC  9(7)V99.
          03  WK-NUMDUR                         PIC  9(3).
          03  WK-CODMAXI                        PIC  X.
          03  WK-IMPMAXI                        PIC  9(7)V99.
          03  WK-BANCA                          PIC  X.
          03  WK-PRODOTTO                       PIC  XXX.
          03  WK-ABI                            PIC  9(5).
          03  WK-CAB                            PIC  9(5).
          03  WK-CONTO                          PIC  X(12).
          03  WK-TITOLARE                       PIC  X(30).
          03  WK-INDIR-VDR                      PIC  X(30).
          03  WK-CAP-VDR                        PIC  9(05).
          03  WK-CITTA-VDR                      PIC  X(30).
          03  WK-TIME                           PIC  X(04).
          03  WK-AGE                            PIC  9(03).
          03  WK-IMPEROG                        PIC  9(07)V99.
          03  WK-VDRFIN                         PIC  9(07).
          03  WK-VDR-DRBE                       PIC  X.
             88   WK-DRBE-OK                    VALUE 'S'.
          03  WK-MOD-PAG                        PIC  9.
          03  WK-AGE-STU                        PIC  9(3).
          03  WK-PROROGA                        PIC  9(3).
          03  WK-SCAD                           PIC  9(8).
          03  WK-INDCLI                         PIC  X(30).
          03  WK-CITTACLI                       PIC  X(25).
          03  WK-CAPCLI                         PIC  9(05).
          03  WK-IBAN.
             05  WK-NAZ                         PIC  X(02).
             05  WK-CHECKDIGIT                  PIC  X(02).
             05  WK-CIN                         PIC  X.
             05  WK-ABICLI                      PIC  9(05).
             05  WK-CABCLI                      PIC  9(05).
             05  WK-CONTOCLI                    PIC  X(12).
          03  WK-FOVE                           PIC  X(2).              SL090609

       01  WS-INTVDR                            PIC 9(7)V99.            MD210218
      *
      *----------------------------------------------------------------*
      *    RIGHE PER SCRITTURA CODA TS
      *----------------------------------------------------------------*
      *
      *-- RIGA CONTENENTE AL BYTE 75 IL CODICE MODELLO
      *
       01  RIGA-MODELLO.
           02 FILLER               PIC X(74)      VALUE SPACE.
           02 SOC-ST               PIC XX         VALUE SPACE.
           02 MODELLO-ST           PIC X(4)       VALUE SPACE.
      *
      *-- TESTATA DEL JOB
      *
       01  RIGA-JOB1.
           02 FILLER                 PIC X(6)   VALUE '//FE07'.
           02 RJ1-LETT               PIC X      VALUE SPACE.
           02 RJ1-AGE                PIC 9(3)   VALUE ZERO.
           02 FILLER                 PIC X(45)  VALUE
              ' JOB CLASS=M,MSGCLASS=Z,USER=UDFAXSCA,SCHENV='.
           02 RJ1-SCHENV             PIC X(7)   VALUE SPACE.
           02 FILLER                 PIC X(18)  VALUE SPACE.
      *
       01  RIGA-JOB2                 PIC X(80)  VALUE
              '//EMAIL EXEC AOPPRINT,PRINTER=''PRT2001'',        '.
      *
       01  RIGA-JOB3                 PIC X(80)  VALUE
              '// OPTIONS=''attributes=//DD:MYATTR''             '.
      *
       01  RIGA-JOB4                 PIC X(80)  VALUE
              '//SYSIN DD *                                    '.
      *
       01  RIGA-JOB5                 PIC X(80)  VALUE
              '//MYATTR DD *                                   '.
      *
      *-- CODA DEL JOB
      *
       01  RIGA-JOB6.
           02 FILLER                 PIC X(18)   VALUE
                    'mail-to-addresses='.
           02 RJ6-INDIRIZZO          PIC X(40)   VALUE SPACE.
           02 FILLER                 PIC X(22)   VALUE SPACE.
      *
       01  RIGA-JOB7.
           02 FILLER                 PIC X(16)   VALUE
                    'mail-from-name="'.
           02 RJ7-NAME               PIC X(30)   VALUE SPACE.
           02 FILLER                 PIC X       VALUE '"'.
           02 FILLER                 PIC X(33)   VALUE SPACE.
      *
       01  RIGA-JOB8.
           02 FILLER                 PIC X(20)   VALUE
                    'mail-reply-address='''.
           02 RJ8-IND-RISP           PIC X(40)   VALUE SPACE.
           02 FILLER                 PIC X(20)   VALUE SPACE.
      *
       01  RIGA-JOB9.
           02 FILLER                 PIC X(15)   VALUE
                    'mail-file-name='.
           02 RJ9-FILE-NAME          PIC X(12)   VALUE SPACE.
           02 FILLER                 PIC X(53)   VALUE SPACE.
      *
       01  RIGA-JOB10.
           02 FILLER                 PIC X(11)   VALUE
                    'title-text='.
           02 RJ10-DESCR             PIC X(40)   VALUE SPACE.
           02 FILLER                 PIC X(29)   VALUE SPACE.
      *
       01  RIGA-JOB11.
           02 FILLER                 PIC X(02)   VALUE   '/*'.
           02 FILLER                 PIC X(78)   VALUE SPACE.
      *
       01  RIGA-JOB12                PIC X(80)  VALUE
              '//STDOUT   DD DISP=(NEW,PASS),DSN=&&OUT1        '.
      *
       01  RIGA-JOB13                PIC X(80)  VALUE
              '//STDERR   DD DISP=(NEW,PASS),DSN=&&ERR1        '.
      *
       01  RIGA-JOB14                PIC X(80)  VALUE
              '//*                                             '.
      *
       01  RIGA-JOB15                PIC X(80)  VALUE
              '//IF1      IF (RC>0) THEN                       '.
      *
       01  RIGA-JOB16                PIC X(80)  VALUE
              '//OUT      EXEC PGM=IEBGENER                    '.
      *
       01  RIGA-JOB17                PIC X(80)  VALUE
              '//SYSPRINT DD SYSOUT=Y                          '.
      *
       01  RIGA-JOB18                PIC X(80)  VALUE
              '//SYSUT1   DD DISP=(OLD,DELETE),DSN=&&OUT1      '.
      *
       01  RIGA-JOB19                PIC X(80)  VALUE
              '//SYSUT2   DD SYSOUT=Y                          '.
      *
       01  RIGA-JOB20                PIC X(80)  VALUE
              '//SYSIN    DD DUMMY                             '.
      *
       01  RIGA-JOB21                PIC X(80)  VALUE
              '//ERR      EXEC PGM=IEBGENER                    '.
      *
       01  RIGA-JOB22                PIC X(80)  VALUE
              '//SYSPRINT DD SYSOUT=Y                          '.
      *
       01  RIGA-JOB23                PIC X(80)  VALUE
              '//SYSUT1   DD DISP=(OLD,DELETE),DSN=&&ERR1      '.
      *
       01  RIGA-JOB24                PIC X(80)  VALUE
              '//SYSUT2   DD SYSOUT=Y                          '.
      *
       01  RIGA-JOB25                PIC X(80)  VALUE
              '//SYSIN    DD DUMMY                             '.
      *
       01  RIGA-JOB26                PIC X(80)  VALUE
              '//ENDIF1   ENDIF                                '.
      *
      *-- RIGHE DI INTESTAZIONE PER ESITO E BONIFICO
      *
       01  RJOB-INT1.
           02 FILLER                 PIC X(46)   VALUE SPACE.
           02 RJI1-INSEGNA           PIC X(25).
           02 FILLER                 PIC X(09)    VALUE SPACE.
      *
       01  RJOB-INT2.
           02 FILLER                 PIC X(46)   VALUE SPACE.
           02 RJI2-INDIR             PIC X(30).
           02 FILLER                 PIC X(04)    VALUE SPACE.
      *
       01  RJOB-INT3.
           02 FILLER                 PIC X(46)   VALUE SPACE.
           02 RJI3-CAP               PIC 9(5).
           02 FILLER                 PIC X        VALUE SPACE.
           02 RJI3-CITTA             PIC X(25).
           02 FILLER                 PIC X(03)    VALUE SPACE.
      *
       01  RJOB-INT8.                                                   SL090609
           02 FILLER                 PIC X(46)   VALUE SPACE.           SL090609
           02 RJI8-DESCR             PIC X(5)    VALUE SPACE.           SL090609
           02 RJI8-FOVE              PIC X(2)    VALUE SPACE.           SL090609
           02 FILLER                 PIC X(31)   VALUE SPACE.           SL090609
      *
       01  RJOB-INT4.
           02 FILLER                 PIC X(4)   VALUE SPACE.
           02 RJI4-PROV              PIC X(30).
           02 FILLER                 PIC X(46)    VALUE SPACE.
      *
       01  RJOB-INT5.
           02 FILLER                 PIC X(4)   VALUE SPACE.
           02 RJI5-INDIR             PIC X(30).
           02 FILLER                 PIC X(46)    VALUE SPACE.
      *
       01  RJOB-INT6.
           02 FILLER                 PIC X(4)   VALUE SPACE.
           02 RJI6-CAP               PIC 9(05).
           02 FILLER                 PIC X        VALUE SPACE.
           02 RJI6-CITTA             PIC X(30).
           02 FILLER                 PIC X(40)    VALUE SPACE.
      *
       01  RJOB-INT7.
           02 FILLER                 PIC X(4)   VALUE SPACE.
           02 RJI7-TEL               PIC X(20).
           02 FILLER                 PIC X(56)    VALUE SPACE.
      *
      *-- CORPO LETTERA PER L'ESITO
      *
       01  RJOB-ESITO1.
           02 FILLER                 PIC X(10)   VALUE SPACE.
           02 RJE1-DATA              PIC X(10).
           02 FILLER                 PIC X(18)   VALUE SPACE.
           02 RJE1-NOMCLI            PIC X(25).
           02 FILLER                 PIC X(17)    VALUE SPACE.
      *
       01  RJOB-ESITO2.
           02 FILLER                 PIC X(25)   VALUE SPACE.
           02 RJE2-PRATICA           PIC 9(14).
           02 FILLER                 PIC X(13)   VALUE SPACE.
           02 RJE2-ESITO             PIC X(10).
           02 FILLER                 PIC X(18)    VALUE SPACE.
      *
       01  RJOB-ESITA2.
           02 FILLER                 PIC X(20)
                            VALUE '    MOD PAGAMENTO   '.
           02 RJEA2-MOD-PAG          PIC X(05)   VALUE SPACE.
           02 FILLER                 PIC X(10)   VALUE '  PROROGA '.
           02 RJEA2-PROROGA          PIC ZZZ.
           02 FILLER                 PIC X(07)    VALUE '  SCAD '.
           02 RJEA2-SCAD             PIC ZZZ.
           02 FILLER                 PIC X(32)    VALUE SPACE.
      *
       01  RJOB-ESITO3.
           02 FILLER                 PIC X(04)   VALUE SPACE.
           02 RJE3-DESCR-IMP         PIC X(30).
           02 RJE3-IMPFIN            PIC Z.ZZZ.ZZZ,ZZ.
           02 FILLER                 PIC X(34)    VALUE SPACE.
      *
       01  RJOB-ESITO4.
           02 FILLER                 PIC X(04)   VALUE SPACE.
           02 FILLER                 PIC X       VALUE 'P'.
           02 RJE4-PROG              PIC 9.
           02 FILLER                 PIC X(12)   VALUE ') DA RATA N°'.
           02 RJE4-RATA-DA           PIC ZZZ.
           02 FILLER                 PIC X(10)   VALUE ' A RATA N°'.
           02 RJE4-RATA-A            PIC ZZZ.
           02 FILLER                 PIC X(3)   VALUE '  E'.            FC260811
           02 RJE4-IMPRATA           PIC Z.ZZZ.ZZ9,99.
           02 RJE4-DESCR-MAXI        PIC X(17)   VALUE SPACE.
           02 RJE4-IMPMAXI           PIC Z.ZZZ.ZZZ,ZZ.
           02 FILLER                 PIC X(02)    VALUE SPACE.
      *
       01  RJOB-ESITO4-CLASS.
           02 FILLER                 PIC X(04)   VALUE SPACE.
           02 RJE4-N-RATE-CL         PIC 9(3).
           02 FILLER                 PIC X(19)   VALUE SPACE.
           02 FILLER                 PIC X       VALUE 'E'.             FC260811
           02 RJE4-IMPRATA-CL        PIC Z.ZZZ.ZZ9,99.
           02 FILLER                 PIC X(41)    VALUE SPACE.
      *
       01  RJOB-ESITO4-MAXR1.
           02 FILLER                 PIC X(04)   VALUE SPACE.
           02 RJE4-N-RATE-MX1        PIC 9(3).
           02 FILLER                 PIC X(18)   VALUE SPACE.
           02 FILLER                 PIC X       VALUE 'E'.             FC260811
           02 RJE4-IMPRATA-MX1       PIC Z.ZZZ.ZZ9,99.
           02 FILLER                 PIC X(42)   VALUE SPACE.
      *
       01  RJOB-ESITO4-MAXR1-BIS.
           02 FILLER                 PIC X(04)   VALUE SPACE.
           02 FILLER                 PIC X(28)
                      VALUE ' + IMP. RESIDUO (MAXIRATA) E'.             FC260811
           02 RJE4-IMPRESI-MX1       PIC Z.ZZZ.ZZ9,99.
           02 FILLER                 PIC X(36)   VALUE SPACE.
      *
       01  RJOB-ESITO4-MAXR2.
           02 FILLER                 PIC X(04)   VALUE SPACE.
           02 FILLER                 PIC X(36)
                    VALUE 'II FASE DEL FINANZIAMENTO : N. RATE '.
           02 RJE4-N-RATE-MX2        PIC 9(3).
           02 FILLER                 PIC X(5)   VALUE  ' DA E'.         FC260811
           02 RJE4-IMPRATA-MX2       PIC Z.ZZZ.ZZ9,99.
           02 FILLER                 PIC X(20)   VALUE SPACE.
      *
       01  RJOB-ESITO5.
           02 FILLER                 PIC X(07)   VALUE SPACE.
           02 RJE5-MESSAGGIO         PIC X(60).
           02 FILLER                 PIC X(16)    VALUE SPACE.
      *
       01  RJOB-BONIF1.
           02 FILLER                 PIC X(54)   VALUE SPACE.
           02 RJB1-IMPORTO           PIC Z.ZZZ.ZZZ,ZZ.
           02 FILLER                 PIC X(14)    VALUE SPACE.
      *
       01  RJOB-BONIF2.
           02 FILLER                 PIC X(52)   VALUE SPACE.
           02 RJB2-CONTO             PIC X(12).
           02 FILLER                 PIC X(16)    VALUE SPACE.
      *
       01  RJOB-BONIF3.
           02 FILLER                 PIC X(52)   VALUE SPACE.
           02 RJB3-ABI               PIC ZZZZZ.
           02 FILLER                 PIC X(23)    VALUE SPACE.
      *
       01  RJOB-BONIF4.
           02 FILLER                 PIC X(52)   VALUE SPACE.
           02 RJB4-CAB               PIC ZZZZZ.
           02 FILLER                 PIC X(23)    VALUE SPACE.
      *
       01  RJOB-BONIF5.
           02 FILLER                 PIC X(04)   VALUE SPACE.
           02 FILLER                 PIC X(15)   VALUE
                        'INDIRIZZO CLT  '.
           02 RJB5-IND-CLI           PIC X(30).
           02 FILLER                 PIC X(31)   VALUE SPACE.
      *
       01  RJOB-BONIF6.
           02 FILLER                 PIC X(12)   VALUE  '    CAP     '.
           02 RJB6-CAP-CLI           PIC 9(05).
           02 FILLER                 PIC X(10)   VALUE  '  CITTA''  '.
           02 RJB6-CITTA-CLI         PIC X(25).
           02 FILLER                 PIC X(28)   VALUE SPACE.
      *
       01  RJOB-BONIF7.
           02 FILLER                 PIC X(12)   VALUE '    IBAN    '.
           02 RJB7-IBAN              PIC X(27).
           02 FILLER                 PIC X(41)   VALUE SPACE.
      *
      *
      *----------------------------------------------------------------*
      *    RIGHE PER MESSAGGI IN TBLO
      *----------------------------------------------------------------*
      *
       01  RIGA-TBLO-DRBE.
           02 RDD-P1                 PIC X(20).
           02 RDD-P2                 PIC X(20).
       01  RIGA-TBLO                 PIC X(40)  VALUE SPACE.
       01  RIGA-DESCR-BONIF.
           02 RDB-IMP-FIN            PIC ZZZZZZZ,ZZ.
           02 FILLER                 PIC X      VALUE SPACE.
           02 RDB-IMP-SIP            PIC ZZZZ,ZZ.
           02 FILLER                 PIC X      VALUE SPACE.
           02 RDB-INT-VDR            PIC ZZZZZZZ,ZZ.
           02 FILLER                 PIC X      VALUE SPACE.
           02 RDB-IMP-ASS            PIC ZZZZZ,ZZ.
           02 FILLER                 PIC X      VALUE SPACE.
           02 RDB-BANCA              PIC 9.
       01  RIGA-BONIF-DRBE.
           02 RDB1-IMP-FIN           PIC ZZZZZZZ,ZZ.
           02 FILLER                 PIC X      VALUE SPACE.
           02 RDB1-IMP-SIP           PIC ZZZZ,ZZ.
           02 FILLER                 PIC X      VALUE SPACE.
           02 RDB1-IMP-ASS           PIC ZZZZZ,ZZ.
           02 FILLER                 PIC X(13)  VALUE SPACE.
      *
       01  RIGA-DESCR-ESITO.
           02 RDE-APP-RIF            PIC X.
           02 RDE-IMP-FIN            PIC ZZZZZZZ,ZZ.
           02 FILLER                 PIC X      VALUE SPACE.
           02 RDE-NUM-DUR            PIC ZZZ.
           02 FILLER                 PIC X      VALUE SPACE.
           02 RDE-IMP-MENS           PIC ZZZZZZZ,ZZ.
           02 FILLER                 PIC X      VALUE SPACE.
           02 RDE-IMP-ASS            PIC ZZZZZ,ZZ.
           02 FILLER                 PIC X(5)   VALUE SPACE.
      *
       01  RIGA-DESCR-MAXI.
           02 FILLER                 PIC X(10)  VALUE 'MAXIRATA: '.
           02 RDE-COD-MAXI           PIC X.
           02 FILLER                 PIC X      VALUE SPACE.
           02 RDE-IMP-MAXI           PIC ZZZZZZZ,ZZ.
           02 FILLER                 PIC X(18)  VALUE SPACE.
      *
       01  RIGA-MAXI.
           02 RMX-NUM-DUR            PIC ZZZ.
           02 FILLER                 PIC X      VALUE SPACE.
           02 RMX-IMP-MENS           PIC ZZZZZZZ,ZZ.
           02 FILLER                 PIC X(26)  VALUE SPACE.
      *
       01  W-QUANTI                  PIC S9(04)  COMP-3 VALUE ZERO.
       01  W-RANGE                   PIC S9(05) COMP-3 VALUE ZERO.
      *
       01  NUMPRA                   PIC 9(14)   VALUE   ZERO.
       01  NUMPRAY REDEFINES NUMPRA.
           03  NUMPRA3              PIC 999.
           03  NUMPRA9              PIC X(9).
           03  NUMPRA2              PIC 99.
      *
       01  W-TABNOM.
           05  W-ELENOM              PIC X(01) OCCURS 25 VALUE SPACE.
      *
       01  FILLER.
           03  NUMERO.
               05 FILLER     PIC XXX                 VALUE '100'.
               05 SERIE      PIC XXXX                VALUE ZERO.
               05 FILLER     PIC X(7)                VALUE ZERO.
           03  NUMERO-R REDEFINES NUMERO PIC 9(14).
           03  WK-NUMERO     PIC 9(14)               VALUE ZERO.
           03  WK-QUOZ       PIC 9(14)               VALUE ZERO.
           03  WK-RESTO      PIC 9(14)               VALUE ZERO.
      *
       01  WS-DOS-APP        PIC 9(14)       VALUE ZERO.
      *
       01  W-ABD-SQLCODE             PIC ----9.
       01  W-MSG                     PIC X(5)        VALUE SPACE.
      *
      *
       01  WK-SOC                    PIC 999.
       01  WK-CLIENTE                PIC 9(14).
      *
      *
       01  W-CWADEAT                 PIC 9(8)        VALUE  ZERO.
       01  FILLER  REDEFINES  W-CWADEAT.
           05  W-ADEATA              PIC 9999.
           05  W-MDEATA              PIC 99.
           05  W-JDEATA              PIC 99.
      *
       01 W-TAB-NOME.
          05 W-TAB-CLT PIC X OCCURS 25.
      *
       01  IND-NOME                  PIC 9(2)         VALUE ZERO.
       01  I                         PIC  9(04)      VALUE ZERO.
       01  IND                       PIC  9(04)      VALUE ZERO.
       01  X                         PIC  9(04)      VALUE ZERO.
       01  Y                         PIC  9(04)      VALUE ZERO.
       01  IND-1                     PIC  9(04)      VALUE ZERO.
       01  NUMFAX-APP                PIC  X(12)      VALUE SPACE.
       01  IND1                      PIC  9(04)      VALUE ZERO.
       01  W-RIGA                    PIC X(40).
       01  W-SAVE-RIGA               PIC  9(04)      VALUE ZERO.
       01  W-SAVE-PAG                PIC  9(04)      VALUE ZERO.
       01  WK-COUNT                  PIC S9(15) COMP-3 VALUE ZERO.
      *
       01 WS-STAMPANTE               PIC X(4)         VALUE SPACE.
       01 WS-AGE                     PIC 9(3)         VALUE ZERO.
       01 WS-CONTRATTO               PIC 9(6)         VALUE ZERO.
      *
       01  SW-TROV                   PIC  X(01)      VALUE 'N'.
           88  TROVATO                               VALUE 'S'.
           88  NON-TROVATO                           VALUE 'N'.
      *
       01  SW-ESITO                  PIC  X(01)      VALUE 'N'.
           88  TROV-ESITO                            VALUE 'S'.
      *
       01  SW-CODSTU-OK              PIC  X(01)      VALUE 'N'.
           88  CODSTU-OK                             VALUE 'S'.
      *
       01  SW-CODSTU-RE              PIC  X(01)      VALUE 'N'.
           88  CODSTU-RE                             VALUE 'S'.
      *
       01  SW-PAGMES                 PIC  X(01)      VALUE 'N'.
           88  PAGMES                                VALUE 'S'.
           88  NO-PAGMES                             VALUE 'N'.
      *
       01  SW-VAI                    PIC  X(01)      VALUE 'V'.
           88  VAI                                   VALUE 'V'.
           88  BASTA                                 VALUE 'B'.
      *
       01  SW-PRESENZA               PIC  X(01)      VALUE 'N'.
           88  PRESENTE                              VALUE 'S'.
           88  PRESENTE-NO                           VALUE 'N'.
      *
       01  SW-RICERCA-CLIENTE        PIC  X(01)      VALUE 'N'.
           88  RICERCA-CLIENTE                       VALUE 'S'.
           88  NON-RICERCA-CLIENTE                   VALUE 'N'.
      *
       01  SW-RATAVAR                PIC  X(01)      VALUE 'N'.
           88  FINE-RATAVAR                          VALUE 'S'.
      *
       01  W-DT-ELABORAZIONE.
           05  W-ANNO-ELABORAZIONE   PIC  9(04)      VALUE ZERO.
           05  W-MM-ELABORAZIONE     PIC  9(02)      VALUE ZERO.
           05  W-GG-ELABORAZIONE     PIC  9(02)      VALUE ZERO.
      *
      *
       01  W-SPAC-DATA               PIC  9(08)      VALUE ZERO.
       01  FILLER REDEFINES W-SPAC-DATA.
           05  W-SPAC-ANNO           PIC  9(04).
           05  FILLER REDEFINES W-SPAC-ANNO.
                10  W-SPAC-SS        PIC  9(02).
                10  W-SPAC-AA        PIC  9(02).
           05  W-SPAC-MM             PIC  9(02).
           05  W-SPAC-GG             PIC  9(02).
      *
      *
       01  W-INDLOC                  PIC  9(01)      VALUE ZERO.
       01  W-INDLOCX REDEFINES W-INDLOC PIC X.
      *
       01  W-POSA                    PIC  9(03)          VALUE ZERO.
       01  W-POSA-X REDEFINES W-POSA PIC  X(03).
       01  W-STADIO                  PIC  9(01)          VALUE ZERO.
      *
       01  W-NOME-RIC                PIC X(25)           VALUE SPACE.
       01  W-CLI-RIC                 PIC S9(14) COMP-3   VALUE ZERO.
       01  W-IND-RIC                 PIC S9(03) COMP-3   VALUE ZERO.
       01  W-IND-RIC-CLI             PIC S9(03) COMP-3   VALUE ZERO.
       01  W-IND-RIC-CNG             PIC S9(03) COMP-3   VALUE ZERO.
      *
      *
       01  W-PROV                    PIC X(02)       VALUE SPACE.
       01  W-PROV-NUM-CLT            PIC 9(03)       VALUE ZERO.
       01  W-PROV-NUM-CNG            PIC 9(03)       VALUE ZERO.
       01  W-PROV-NUM-IMMOB          PIC 9(03)       VALUE ZERO.
      *
       01  W-HHR                     PIC 99.
      *
      *
       01  W-CODFIS                      PIC X(16) VALUE SPACE.
       01  W-DATNAS                      PIC X(08) VALUE SPACE.
       01  W-SIG                         PIC X(03) VALUE SPACE.
      *
      *----------------------------------------------------------------*
      *    CAMPI PER GESTIONE MESSAGGI DI ERRORE
      *----------------------------------------------------------------*
      *
      *
       01  REC-IN-ELAB-TCQQDOSS.
           02 FILLER                PIC X(16)  VALUE 'REC. IN ELAB. ->'.
           02 W-MSG-KEY-TCQQDOSS.
              03 FILLER             PIC X(16)  VALUE 'SOCIETA''->'.
              03 W-MSG-DOSSSOC      PIC 9(03)  VALUE ZERO.
              03 FILLER             PIC X(02)  VALUE '<-'.
              03 FILLER             PIC X(16)  VALUE 'PRATICA  ->'.
              03 W-MSG-DOSSPRA      PIC 9(14)  VALUE ZERO.
              03 FILLER             PIC X(02)  VALUE '<-'.
      *
       01  REC-IN-ELAB-TCQQDOST.
           02 FILLER                PIC X(16)  VALUE 'REC. IN ELAB. ->'.
           02 W-MSG-KEY-TCQQDOST.
              03 FILLER             PIC X(16)  VALUE 'SOCIETA''->'.
              03 W-MSG-DOSTSOC      PIC 9(03)  VALUE ZERO.
              03 FILLER             PIC X(02)  VALUE '<-'.
              03 FILLER             PIC X(16)  VALUE 'PRATICA  ->'.
              03 W-MSG-DOSTPRA      PIC 9(14)  VALUE ZERO.
              03 FILLER             PIC X(02)  VALUE '<-'.
      *
       01  REC-IN-ELAB-TVARSOTP.
           02 FILLER                PIC X(16)  VALUE 'REC. IN ELAB. ->'.
           02 W-MSG-KEY-TVARSOTP.
              03 FILLER             PIC X(16)  VALUE 'PRATICA  ->'.
              03 W-MSG-SOTPPRA      PIC 9(14)  VALUE ZERO.
              03 FILLER             PIC X(02)  VALUE '<-'.
      *
       01  REC-IN-ELAB-TVARPRAT.
           02 FILLER                PIC X(16)  VALUE 'REC. IN ELAB. ->'.
           02 W-MSG-KEY-TVARPRAT.
              03 FILLER             PIC X(13)  VALUE 'SOCIETA''  ->'.
              03 W-MSG-VARSOC       PIC 9(03)  VALUE ZERO.
              03 FILLER             PIC X(11)  VALUE 'PRATICA  ->'.
              03 W-MSG-VARPRA       PIC 9(14)  VALUE ZERO.
              03 FILLER             PIC X(02)  VALUE '<-'.
      *
       01  REC-IN-ELAB-TATAAGEN.
           02 FILLER                PIC X(16)  VALUE 'REC. IN ELAB. ->'.
           02 W-MSG-KEY-TATAAGEN.
              03 FILLER             PIC X(16)  VALUE 'AGENZIA  ->'.
              03 W-MSG-AGENAGE      PIC 9(03)  VALUE ZERO.
              03 FILLER             PIC X(02)  VALUE '<-'.
      *
       01  REC-IN-ELAB-TGENSOCI.
           02 FILLER                PIC X(16)  VALUE 'REC. IN ELAB. ->'.
           02 W-MSG-KEY-TGENSOCI.
              03 FILLER             PIC X(16)  VALUE 'SOCIETA''->'.
              03 W-MSG-SOC          PIC 9(03)  VALUE ZERO.
              03 FILLER             PIC X(02)  VALUE '<-'.
      *
       01  REC-IN-ELAB-TFINMAXI.
           02 FILLER                PIC X(16)  VALUE 'REC. IN ELAB. ->'.
           02 W-MSG-KEY-TFINMAXI.
              03 FILLER             PIC X(16)  VALUE 'PRATICA  ->'.
              03 W-MSG-TFXPRA       PIC 9(14)  VALUE ZERO.
              03 FILLER             PIC X(02)  VALUE '<-'.
      *
       01  REC-IN-ELAB-TINFSTUD.
           02 FILLER                PIC X(16)  VALUE 'REC. IN ELAB. ->'.
           02 W-MSG-KEY-TINFSTUD.
              03 FILLER             PIC X(16)  VALUE 'COD STUD ->'.
              03 W-MSG-CODSTUD      PIC 9(03)  VALUE ZERO.
              03 FILLER             PIC X(02)  VALUE '<-'.
      *
       01  REC-IN-ELAB-TBBLOCC.
           02 FILLER                PIC X(16)  VALUE 'REC. IN ELAB. ->'.
           02 W-MSG-KEY-TBBLOCC.
              03 FILLER             PIC X(16)  VALUE 'CLIENTE ->'.
              03 W-MSG-BLOCCLI      PIC 9(14)  VALUE ZERO.
              03 FILLER             PIC X(02)  VALUE '<-'.
      *
       01  REC-IN-ELAB-TBVDVDR.
           02 FILLER                PIC X(16)  VALUE 'REC. IN ELAB. ->'.
           02 W-MSG-KEY-TBVDVDR.
              03 FILLER             PIC X(10)  VALUE 'VDR     ->'.
              03 W-MSG-TVDAGR       PIC 9(03)  VALUE ZERO.
              03 FILLER             PIC X(10)  VALUE 'PROD    ->'.
              03 W-MSG-TVDPRO       PIC X(03)  VALUE SPACE.
              03 FILLER             PIC X(10)  VALUE 'BANCA   ->'.
              03 W-MSG-TVDBQE       PIC 9(01)  VALUE ZERO.
      *
       01  REC-IN-ELAB-TNECORBE.
           02 FILLER                PIC X(16)  VALUE 'REC. IN ELAB. ->'.
           02 W-MSG-KEY-TNECORBE.
              03 FILLER             PIC X(10)  VALUE 'SOC     ->'.
              03 W-MSG-ORBESOC      PIC 9(03)  VALUE ZERO.
              03 FILLER             PIC X(10)  VALUE 'VDR     ->'.
              03 W-MSG-ORBEVDR      PIC 9(03)  VALUE ZERO.
              03 FILLER             PIC X(02)  VALUE '<-'.
      *
      *----------------------------------------------------------------*
      *    INCLUDE SQL
      *----------------------------------------------------------------*
      *
           EXEC SQL INCLUDE SQLCA    END-EXEC.
           EXEC SQL INCLUDE TBBLOCC  END-EXEC.
           EXEC SQL INCLUDE TBVDVDR  END-EXEC.
           EXEC SQL INCLUDE TBVDPRO  END-EXEC.
           EXEC SQL INCLUDE TBVDBQE  END-EXEC.
           EXEC SQL INCLUDE DCQQDOSS END-EXEC.
           EXEC SQL INCLUDE DCQQDOST END-EXEC.
           EXEC SQL INCLUDE DINFSTUD END-EXEC.
           EXEC SQL INCLUDE DNECORBE END-EXEC.
           EXEC SQL INCLUDE DFIMAXI  END-EXEC.
           EXEC SQL INCLUDE DVARSOTP END-EXEC.
           EXEC SQL INCLUDE DATAAGEN END-EXEC.
           EXEC SQL INCLUDE DGENSOCI END-EXEC.
           EXEC SQL INCLUDE ROUWPROV END-EXEC.
           EXEC SQL INCLUDE DVARPRAT END-EXEC.
           EXEC SQL INCLUDE DINFDFAX END-EXEC.
           EXEC SQL INCLUDE DINFDGL1 END-EXEC.                          SL241018
           EXEC SQL INCLUDE DINFASSI END-EXEC.                          SL241018
           EXEC SQL INCLUDE DINFDESC END-EXEC.                          SL241018
           EXEC SQL INCLUDE DGECAMP  END-EXEC.                          SL241018
           EXEC SQL INCLUDE DGESOTC  END-EXEC.                          SL241018
      *
           EXEC SQL DECLARE CURS02 CURSOR FOR
                SELECT SOTP_IMP_MENS
                      ,SOTP_NUM_MENS
                      ,SOTP_NUM_INIZ_MENS
                FROM   T_VAR_SOTP
                WHERE  SOTP_NUM_PRA  = :SOTP-NUM-PRA
                  AND  SOTP_COD_SOC  = :SOTP-COD-SOC                    AR311219
                ORDER BY SOTP_NUM_PROG
           END-EXEC.
      *
      *----------------------------------------------------------------*
       LINKAGE  SECTION.
      *----------------------------------------------------------------*
      *
      *01  DFHCOMMAREA      PIC X(263).                                 IS100615
       01  DFHCOMMAREA      PIC X(511).                                 IS100615
      *    COPY FAXCSERV.
      *
           COPY COPCWA.
      *
      *----------------------------------------------------------------*
       PROCEDURE DIVISION.
      *----------------------------------------------------------------*
      *
           PERFORM 010-INIZIO THRU 010-INIZIO-X
      *
           PERFORM 020-ELABORAZIONE THRU 020-ELABORAZIONE-X
      *
           PERFORM 030-FINE   THRU 030-FINE-X.
      *
       010-INIZIO.
      *----------------------------------------------------------------*
      *
           IF   EIBCALEN = ZERO
           THEN
               INITIALIZE DCLT-INF-DFAX
               MOVE    'COMMAREA VUOTA ' TO DFAX-ERRORE
               PERFORM 800-INSERT-TINFDFAX  THRU 800-INSERT-TINFDFAX-X
               PERFORM 030-FINE             THRU 030-FINE-X
           ELSE
                IF   EIBCALEN = LENGTH OF FAXCSERV
                THEN
                     MOVE DFHCOMMAREA TO FAXCSERV
                ELSE
                   INITIALIZE DCLT-INF-DFAX
                   MOVE    'LUNGHEZZA COMMAREA ERRATA' TO DFAX-ERRORE
                   PERFORM 800-INSERT-TINFDFAX
                      THRU 800-INSERT-TINFDFAX-X
                   PERFORM 030-FINE             THRU 030-FINE-X
                END-IF
           END-IF
      *
           EXEC CICS ASSIGN SYSID(K001-CICS-TEST-PROD) END-EXEC
      *
           EXEC CICS ADDRESS CWA(ADDRESS OF CWAZONE)   END-EXEC
      *
           EXEC DLI SCHD PSB (D05223A) END-EXEC
      *
           IF   DIBSTAT NOT = SPACE
           THEN
              INITIALIZE DCLT-INF-DFAX
              STRING  'ERRORE SCHEDULAZIONE PSB ' DIBSTAT
                       DELIMITED BY SIZE
                       INTO DFAX-ERRORE
              END-STRING
              PERFORM 800-INSERT-TINFDFAX  THRU 800-INSERT-TINFDFAX-X
              PERFORM 030-FINE THRU 030-FINE-X
           END-IF
      *
           PERFORM 090-FORMATTIME    THRU 090-FORMATTIME-X.
      *
      *----------------------------------------------------------------*
       010-INIZIO-X.
           EXIT.
      *
       020-ELABORAZIONE.
      *----------------------------------------------------------------*
      *
           INITIALIZE WK-DATI
      *
           PERFORM 072-CHECK-DATI
              THRU 072-CHECK-DATI-X
      *
           IF  FAX-FLG-FAX = 'S'
           THEN
               IF  WK-NUMFAX = SPACE OR LOW-VALUE
               THEN
                   INITIALIZE DCLT-INF-DFAX
                   MOVE FAX-NUM-PRA    TO DFAX-NUM-PRA
                   STRING  'MANCA NUMERO DI FAX SU TVEI'
                        DELIMITED BY SIZE
                        INTO DFAX-ERRORE
                   END-STRING
                   PERFORM 800-INSERT-TINFDFAX
                      THRU 800-INSERT-TINFDFAX-X
                   PERFORM 030-FINE THRU 030-FINE-X
               ELSE
                   INITIALIZE        ITEM-TS
                   SET  WK-FAX       TO TRUE
      *
                   INITIALIZE SW-INDIRIZZO
                   SET   INDIRIZZO-OK  TO TRUE
      *
                   IF  K001-CICS-TEST
                   THEN
                      PERFORM CONTROLLO-INDIRIZZI
                         THRU CONTROLLO-INDIRIZZI-X
                   END-IF
      *
                   IF  INDIRIZZO-KO
                   THEN
                      INITIALIZE DCLT-INF-DFAX
                      MOVE FAX-NUM-PRA    TO DFAX-NUM-PRA
                      STRING  'INDIRIZZO MAIL O N.FAX ERRATO SU TEST'
                         DELIMITED BY SIZE
                         INTO DFAX-ERRORE
                      END-STRING
                      PERFORM 800-INSERT-TINFDFAX
                         THRU 800-INSERT-TINFDFAX-X
                      PERFORM 030-FINE THRU 030-FINE-X
                   END-IF
      *
                   PERFORM PREPARA-ESITO
                      THRU PREPARA-ESITO-X
      *
                   INITIALIZE WK-SCELTA
               END-IF
           END-IF
      *
           IF  FAX-FLG-MAIL = 'S'
           THEN
               IF  WK-INDMAIL = SPACE OR LOW-VALUE
               THEN
                   INITIALIZE DCLT-INF-DFAX
                   MOVE FAX-NUM-PRA    TO DFAX-NUM-PRA
                   STRING  'MANCA INDIRIZZO MAIL SU TVEI'
                        DELIMITED BY SIZE
                        INTO DFAX-ERRORE
                   END-STRING
                   PERFORM 800-INSERT-TINFDFAX
                      THRU 800-INSERT-TINFDFAX-X
                   PERFORM 030-FINE THRU 030-FINE-X
               ELSE
                   INITIALIZE        ITEM-TS
                   SET  WK-MAIL      TO TRUE
      *
                   INITIALIZE SW-INDIRIZZO
                   SET   INDIRIZZO-OK  TO TRUE
      *
                   IF  K001-CICS-TEST
                   THEN
                      PERFORM CONTROLLO-INDIRIZZI
                         THRU CONTROLLO-INDIRIZZI-X
                   END-IF
      *
                   IF  INDIRIZZO-KO
                   THEN
                      INITIALIZE DCLT-INF-DFAX
                      MOVE FAX-NUM-PRA    TO DFAX-NUM-PRA
                      STRING  'INDIRIZZO MAIL O N.FAX ERRATO SU TEST'
                         DELIMITED BY SIZE
                         INTO DFAX-ERRORE
                      END-STRING
                      PERFORM 800-INSERT-TINFDFAX
                         THRU 800-INSERT-TINFDFAX-X
                      PERFORM 030-FINE THRU 030-FINE-X
                   END-IF
      *
                   PERFORM PREPARA-ESITO
                      THRU PREPARA-ESITO-X
      *
                   INITIALIZE WK-SCELTA-MAIL
               END-IF
           END-IF.
      *
      *----------------------------------------------------------------*
       020-ELABORAZIONE-X.
           EXIT.
      *
       030-FINE.
      *----------------------------------------------------------------*
      *
           EXEC DLI TERM END-EXEC
      *
           EXEC CICS RETURN END-EXEC
      *
           GOBACK.
      *
      *----------------------------------------------------------------*
       030-FINE-X.
           EXIT.
      *
      *
       072-CHECK-DATI.
      *----------------------------------------------------------------*
      *
           INITIALIZE SW-PRATICA
      *
           MOVE FAX-NUM-PRA      TO PRZ-PART-BYTE
           MOVE 14               TO NUM-MAX-CIFRE-INT
           MOVE 0                TO NUM-MAX-CIFRE-DEC

           PERFORM 968-JCK-PRZ THRU 968-JCK-PRZ-X

           IF   MSG-CHECK-OK
           THEN
                MOVE PRZ-INT15     TO W-NUM-PRA-967
      *         PERFORM 967-CHK-PRAX THRU 967-CHK-PRAX-X                RP161018
                PERFORM 967-CHK-PRA THRU 967-CHK-PRA-X                  RP161018
                IF  W-PRA-CL-967
                THEN
                    SET  CLASSICO TO TRUE
                ELSE
                    IF  W-PRA-CP-967
                    THEN
                        SET  CARTA   TO TRUE
                    END-IF
                END-IF
           END-IF
      *
           IF  CLASSICO OR CARTA
           THEN
               CONTINUE
           ELSE
               INITIALIZE DCLT-INF-DFAX
               MOVE FAX-NUM-PRA    TO DFAX-NUM-PRA
               STRING  'NUMERO PRATICA ERRATO '
                        DELIMITED BY SIZE
                        INTO DFAX-ERRORE
               END-STRING
               PERFORM 800-INSERT-TINFDFAX  THRU 800-INSERT-TINFDFAX-X
               PERFORM 030-FINE THRU 030-FINE-X
           END-IF
      *
           IF  CLASSICO
           THEN
               MOVE FAX-NUM-PRA      TO DODRAC-NUM-PRATICA
               PERFORM 860-GU-DODRAC
                  THRU 860-GU-DODRAC-X
               IF  DIBSTAT = SPACE
               THEN
                   MOVE SPACE   TO WK-IBAN
                   IF  DJCMODP NOT = 0
                   THEN
                       PERFORM 852-GNP-DODBQE
                          THRU 852-GNP-DODBQE-X
                   END-IF
                   IF  DJDFIN  = ZERO
                   OR  DJDFIN  = WAAMMJJ
                   THEN
                       MOVE DJNDOS       TO WK-NUMPRA
                       MOVE DJCSTE       TO WK-CODSOC
                       MOVE DJNVDR       TO WK-VDR
                       MOVE DJNCLI       TO WK-CODCLI
                       MOVE DJCMODP      TO WK-MOD-PAG
      *
                       PERFORM 850-GNP-DODCOM
                          THRU 850-GNP-DODCOM-X
                       MOVE DLMOTDAC     TO WK-CODSTU                   CA310318
                       MOVE DLCETUD      TO WK-DECIS
                       MOVE DJMDECO      TO WK-IMPFIN
                       MOVE DLIMPIST     TO WK-IMSIP
                       MOVE DLRIPORTI    TO WK-PROROGA
                       MOVE DJDECH1      TO WK-SCAD
                       IF  DJMAXI NOT = '9'
                       THEN
                           IF  DJCGRAT = '0'
                               MOVE ZERO     TO WK-INTVDR
                               COMPUTE WK-IMPEROG = DJMDECO - DLIMPIST -
                                                    DJIMPASSIC
                           ELSE
                               COMPUTE WK-INTVDR =  DJMDECO - DLMFIN
                                                            - DLIMPIST
                                                            - DJIMPASSIC
                               IF WK-INTVDR <= 0,5                      MD210218
                                  MOVE WK-INTVDR TO WS-INTVDR           MD210218
                                  MOVE 0         TO WK-INTVDR           MD210218
                               ELSE                                     MD210218
                                  MOVE 0         TO WS-INTVDR           MD210218
                               END-IF                                   MD210218
      *                         MOVE DLMFIN       TO WK-IMPEROG         MD210218
                               COMPUTE WK-IMPEROG = DLMFIN + WS-INTVDR  MD210218
                           END-IF
                       ELSE
                           MOVE DJNDOS    TO PRAT-NUM-PRA
                           MOVE DJCSTE    TO PRAT-COD-SOC
                           PERFORM SELECT-TVARPRAT
                              THRU SELECT-TVARPRAT-X
                           IF  OK-ON-REC
                           THEN
      *                        MOVE PRAT-IMP-INT-VDR   TO WK-INTVDR     RP300418
                               IF DJIDEN NOT = SPACES                   RP300418
                               AND  DJCGRAT = 'P'                       SL241018
                                  PERFORM CALCOLA-DLCORSERFIN           SL241018
                                     THRU CALCOLA-DLCORSERFIN-x         SL241018
                                  COMPUTE WK-INTVDR =                   RP300418
                                       PRAT-IMP-INT-VDR - DLCORSERFIN   RP300418
                               ELSE                                     RP300418
                                  MOVE PRAT-IMP-INT-VDR TO WK-INTVDR    RP300418
                               END-IF                                   RP300418
                               IF WK-INTVDR <= 0,5                      MD210218
                                  MOVE 0               TO WK-INTVDR     MD210218
                               END-IF                                   MD210218
                               COMPUTE WK-IMPEROG = DJMDECO
                                                  - WK-INTVDR
                                                  - DLIMPIST
                                                  - DJIMPASSIC
                           ELSE
                               INITIALIZE DCLT-INF-DFAX
                               MOVE FAX-NUM-PRA    TO DFAX-NUM-PRA
                               STRING
                               'PRATICA DI RATA VAR. NON IN TAB. '
                                       DELIMITED BY SIZE
                                       INTO DFAX-ERRORE
                               END-STRING
                               PERFORM 800-INSERT-TINFDFAX
                                  THRU 800-INSERT-TINFDFAX-X
                               PERFORM 030-FINE THRU 030-FINE-X
                           END-IF
                       END-IF
                       MOVE DJIMPASSIC   TO WK-IMPASS
                       MOVE DJLPROD      TO WK-PRODOTTO
                       MOVE DJBMENS      TO WK-NUMDUR
                       MOVE DJMMENS      TO WK-IMPMENS
                       MOVE DJMAXI       TO WK-CODMAXI
                       MOVE DJIMPMAXI    TO WK-IMPMAXI
                       MOVE DJCFINB      TO WK-AGE
                       MOVE DJCIRR       TO WK-AGE-STU
                       MOVE DJCODFVE     TO WK-FOVE                     SL090609
                   ELSE
                       INITIALIZE DCLT-INF-DFAX
                       MOVE FAX-NUM-PRA    TO DFAX-NUM-PRA
                       STRING
                               'PRATICA NON FINANZIATA OGGI'
                                       DELIMITED BY SIZE
                                       INTO DFAX-ERRORE
                       END-STRING
                       PERFORM 800-INSERT-TINFDFAX
                          THRU 800-INSERT-TINFDFAX-X
                       PERFORM 030-FINE THRU 030-FINE-X
                   END-IF
      *
               ELSE
                       INITIALIZE DCLT-INF-DFAX
                       MOVE FAX-NUM-PRA    TO DFAX-NUM-PRA
                       STRING
                               'PRATICA NON TROVATA'
                                       DELIMITED BY SIZE
                                       INTO DFAX-ERRORE
                       END-STRING
                       PERFORM 800-INSERT-TINFDFAX
                          THRU 800-INSERT-TINFDFAX-X
                       PERFORM 030-FINE THRU 030-FINE-X
               END-IF
           END-IF
      *
           IF  CARTA
           THEN
               MOVE FAX-NUM-PRA      TO CPDRAC-NUM-PRATICA
               PERFORM 861-GU-CPDRAC
                  THRU 861-GU-CPDRAC-X
               IF  DIBSTAT = SPACE
               THEN
                   MOVE SPACE   TO WK-IBAN
                   IF  BCCMODP NOT = 0
                   THEN
                       PERFORM 862-GNP-CPDBQE
                          THRU 862-GNP-CPDBQE-X
                   END-IF
                   IF  BCDDFIN = ZERO
                   OR  BCDDFIN = WAAMMJJ
                       MOVE BCNDOS       TO WK-NUMPRA
                       MOVE BCCSTE       TO WK-CODSOC
                       MOVE BCNVDR       TO WK-VDR
                       MOVE BCNCLI       TO WK-CODCLI
                       MOVE BCCMODP      TO WK-MOD-PAG
      *
                       PERFORM 851-GNP-CPDCOM
                          THRU 851-GNP-CPDCOM-X
                       MOVE BC2MOTDAC    TO WK-CODSTU                   CA310318
                       MOVE BC2CETUD     TO WK-DECIS
                       MOVE BCMCMA       TO WK-IMPFIN
                       MOVE ZERO         TO WK-IMSIP
                       MOVE ZERO         TO WK-INTVDR
                       MOVE BCMPRAS      TO WK-IMPASS
                       MOVE BCLPROD      TO WK-PRODOTTO
                       MOVE ZERO         TO WK-NUMDUR
                       MOVE ZERO         TO WK-IMPMENS
                       MOVE SPACE        TO WK-CODMAXI
                       MOVE ZERO         TO WK-IMPMAXI
                       MOVE BCCFINB      TO WK-AGE
                       MOVE BC2MFIN      TO WK-IMPEROG
                       MOVE BCCBUVD      TO WK-AGE-STU
                       MOVE ZERO         TO WK-PROROGA
                       MOVE BCDEAT       TO WK-SCAD
                       MOVE BCFORVEN     TO WK-FOVE                     SL090609
                   ELSE
                       INITIALIZE DCLT-INF-DFAX
                       MOVE FAX-NUM-PRA    TO DFAX-NUM-PRA
                       STRING  'PRATICA NON FINANZIATA OGGI'
                          DELIMITED BY SIZE
                          INTO DFAX-ERRORE
                       END-STRING
                       PERFORM 800-INSERT-TINFDFAX
                          THRU 800-INSERT-TINFDFAX-X
                       PERFORM 030-FINE THRU 030-FINE-X
                   END-IF
      *
               ELSE
                       INITIALIZE DCLT-INF-DFAX
                       MOVE FAX-NUM-PRA    TO DFAX-NUM-PRA
                       STRING  'PRATICA NON TROVATA'
                          DELIMITED BY SIZE
                          INTO DFAX-ERRORE
                       END-STRING
                       PERFORM 800-INSERT-TINFDFAX
                          THRU 800-INSERT-TINFDFAX-X
                       PERFORM 030-FINE THRU 030-FINE-X
               END-IF
           END-IF
      *
           IF  WK-VDR > 8900000
           THEN
               INITIALIZE DCLT-INF-DFAX
               MOVE FAX-NUM-PRA    TO DFAX-NUM-PRA
               STRING  'PRATICA DI DIRETTO - KO '
                          DELIMITED BY SIZE
                          INTO DFAX-ERRORE
               END-STRING
               PERFORM 800-INSERT-TINFDFAX
                  THRU 800-INSERT-TINFDFAX-X
               PERFORM 030-FINE THRU 030-FINE-X
           END-IF
      *
      * SONO ACCETTATI SOLO I VDR IN DRBE CHE SONO AGENTI
      * e i vdr banca/assicurazione
      *
           INITIALIZE WK-VDR-DRBE
           MOVE WK-VDR       TO ORBE-COD-VDR
                                TVDAGR
           MOVE WK-CODSOC    TO ORBE-COD-SOC
           PERFORM CERCA-TIPVDR       THRU CERCA-TIPVDR-X
           IF  TVDTIPVDR = 'A'  OR 'B'
           THEN
               SET WK-DRBE-OK    TO TRUE
      *
           ELSE
      *
               PERFORM SELECT-TNECORBE    THRU SELECT-TNECORBE-X
               IF  OK-ON-REC
               THEN
                   IF  TVDTIPVDR = 'G'
                   THEN
                        SET WK-DRBE-OK    TO TRUE
                   ELSE
                       INITIALIZE DCLT-INF-DFAX
                       MOVE FAX-NUM-PRA    TO DFAX-NUM-PRA
                       STRING  'VDR NON ACCETTATO'
                          DELIMITED BY SIZE
                          INTO DFAX-ERRORE
                       END-STRING
                       PERFORM 800-INSERT-TINFDFAX
                          THRU 800-INSERT-TINFDFAX-X
                       PERFORM 030-FINE THRU 030-FINE-X
                   END-IF
               END-IF
           END-IF
      *
           IF  WK-DRBE-OK
           AND CLASSICO
           THEN
               MOVE ZERO     TO WK-INTVDR
               COMPUTE WK-IMPEROG = DJMDECO - DLIMPIST -
                                         DJIMPASSIC
           END-IF
      *
      *-- CONTROLLO PRODOTTI ACCETTATI
      *
           MOVE WK-PRODOTTO    TO SW-PRODOTTO
                                  SW-PRODOTTO-NET
      *
           IF (PRODOTTO-OK      AND (NOT WK-DRBE-OK))
           OR (PRODOTTO-NET-OK  AND WK-DRBE-OK)
           THEN
                CONTINUE
           ELSE
                INITIALIZE DCLT-INF-DFAX
                MOVE FAX-NUM-PRA    TO DFAX-NUM-PRA
                STRING  'PRODOTTO NON ACCETTATO '
                          DELIMITED BY SIZE
                          INTO DFAX-ERRORE
                END-STRING
                PERFORM 800-INSERT-TINFDFAX
                   THRU 800-INSERT-TINFDFAX-X
                PERFORM 030-FINE THRU 030-FINE-X
           END-IF
      *
      *    MOVE WK-NUMPRA       TO DOST-NUM-PRA                         CA310318
      *                            DOSS-NUM-PRA                         CA310318
      *    MOVE WK-CODSOC       TO DOST-COD-SOC                         CA310318
      *                            DOSS-COD-SOC                         CA310318
      *    INITIALIZE           WK-CODSTU                               CA310318
      *    PERFORM 801-SELECT-TCQQDOST                                  CA310318
      *       THRU 801-SELECT-TCQQDOST-X                                CA310318
      *    IF  OK-ON-REC                                                CA310318
      *    THEN                                                         CA310318
      *        IF  DOST-COD-ESI  NUMERIC                                CA310318
      *        THEN                                                     CA310318
      *            MOVE DOST-COD-ESI    TO WK-CODSTU                    CA310318
      *        END-IF                                                   CA310318
      *    ELSE                                                         CA310318
      *        PERFORM 800-SELECT-TCQQDOSS                              CA310318
      *           THRU 800-SELECT-TCQQDOSS-X                            CA310318
      *        IF  OK-ON-REC                                            CA310318
      *        THEN                                                     CA310318
      *            IF  DOSS-COD-ESI  NUMERIC                            CA310318
      *            THEN                                                 CA310318
      *                MOVE DOSS-COD-ESI    TO WK-CODSTU                CA310318
      *            END-IF                                               CA310318
      *        END-IF                                                   CA310318
      *    END-IF                                                       CA310318
      *
           PERFORM 325-COMPILA-CLDRAC THRU 325-COMPILA-CLDRAC-X
      *
           PERFORM 320-COMPILA-VDR    THRU 320-COMPILA-VDR-X
      *
           PERFORM 340-COMPILA-ESITO  THRU 340-COMPILA-ESITO-X.
      *
           PERFORM 345-COMPILA-MESS   THRU 345-COMPILA-MESS-X.
      *
      *----------------------------------------------------------------*
       072-CHECK-DATI-X.
           EXIT.
      *
       090-FORMATTIME.
      *----------------------------------------------------------------*
      *
           EXEC CICS ASKTIME ABSTIME (ABS-DATA) END-EXEC
      *
           EXEC CICS FORMATTIME ABSTIME (ABS-DATA)
                                DDMMYY  (FORDATE)
                                YEAR    (SECOLO)
                                DATESEP ('.')
                                TIME    (FORTIME)
                                TIMESEP (':')
           END-EXEC
      *
           MOVE WAAAAMMJJ         TO W-DT-ELABORAZIONE
                                     K001-DATA-8.
           MOVE K001-DATA8-GG     TO K001-DATA10-GG.
           MOVE K001-DATA8-MM     TO K001-DATA10-MM.
           MOVE K001-DATA8-ANNO   TO K001-DATA10-ANNO.
           MOVE K001-DATA-10      TO FORDATE.
      *
           IF  WK-TIME = SPACE
           THEN
               MOVE TIME-MM       TO WK-TIME(1:2)
               MOVE TIME-SS       TO WK-TIME(3:2)
           END-IF.
      *
      *----------------------------------------------------------------*
       090-FORMATTIME-X.
           EXIT.
      *
      *
       320-COMPILA-VDR.
      *----------------------------------------------------------------*
      *
           MOVE WK-VDR          TO TVDAGR
      *
           PERFORM 783-SELECT-TBVDVDR  THRU 783-SELECT-TBVDVDR-X.
      *
           MOVE TVDNOMMAG    TO WK-TITOLARE
           MOVE TVDADRMAG    TO WK-INDIR-VDR
           MOVE TVDCPTTMAG   TO WK-CAP-VDR
           MOVE TVDVILMAG    TO WK-CITTA-VDR

      **** TOGLI GLI SPAZI INIZIALI DAL NUMERO DI FAX
           INITIALIZE NUMFAX-APP
           MOVE 1   TO IND-1
           PERFORM VARYING IND FROM 1 BY 1
                   UNTIL IND > 12
               IF  TVDFAXMAG (IND:1) NOT = SPACE AND LOW-VALUE
               THEN
                   MOVE TVDFAXMAG (IND:1) TO NUMFAX-APP(IND-1:1)
                   ADD  1   TO IND-1
               END-IF
           END-PERFORM
           MOVE NUMFAX-APP   TO TVDFAXMAG
      *
           MOVE TVDFAXMAG    TO WK-NUMFAX
      *
           MOVE TVDEMAILMAG  TO WK-INDMAIL
           MOVE TVDVENDFIN   TO WK-VDRFIN
      *
           MOVE WK-PRODOTTO     TO TPRLPROD
           MOVE WK-VDR          TO TPRAGR
      *
           PERFORM 784-SELECT-TBVDPRO  THRU 784-SELECT-TBVDPRO-X.
      *
           MOVE  TPRCBQR        TO WK-BANCA
           INITIALIZE   WK-ABI
                        WK-CAB
                        WK-CONTO
      *
           IF  TPRMODFIN = 'V'
           THEN
               MOVE  TPRCBQR    TO TBVRANG
               MOVE  WK-VDR     TO TBVAGR
      *
               PERFORM 785-SELECT-TBVDBQE  THRU 785-SELECT-TBVDBQE-X
      *
               MOVE TBVCBQE       TO WK-ABI
               MOVE TBVCGUIC      TO WK-CAB
               MOVE TBVNCPTE      TO WK-CONTO
      *
           END-IF.
      *
      *----------------------------------------------------------------*
       320-COMPILA-VDR-X.
           EXIT.
      *
      *
       325-COMPILA-CLDRAC.
      *----------------------------------------------------------------*
      *
           MOVE WK-CODCLI                TO CLDRAC-NUM-CLIENTE.
           PERFORM 862-GU-CLDRAC THRU 862-GU-CLDRAC-X.
      *
           IF   DIBSTAT = 'GE'
           THEN
               INITIALIZE DCLT-INF-DFAX
               MOVE FAX-NUM-PRA    TO DFAX-NUM-PRA
               STRING  'CLIENTE NON TROV IN CLDRAC '
                        DELIMITED BY SIZE
                        INTO DFAX-ERRORE
               END-STRING
               PERFORM 800-INSERT-TINFDFAX  THRU 800-INSERT-TINFDFAX-X
               PERFORM 030-FINE THRU 030-FINE-X
           END-IF.
           MOVE CRLNOMP         TO W-TABNOM
                                   WK-NOMCLI
           IF   CRBINDP > ZERO
           THEN
                IF   CRBINDP > 25
                THEN
                     MOVE 25    TO CRBINDP
                END-IF
                MOVE CRBINDP    TO W-IND-RIC-CLI
                MOVE '*'        TO W-ELENOM(CRBINDP)
           END-IF.
           MOVE W-TABNOM        TO WK-NOMCLI
      *
           MOVE CRLADRE         TO WK-INDCLI.
           MOVE CRCPTT          TO WK-CAPCLI.
           MOVE CRLVILL         TO WK-CITTACLI.
      *
      *
      *----------------------------------------------------------------*
       325-COMPILA-CLDRAC-X.
           EXIT.
      *
      *
       340-COMPILA-ESITO.
      *----------------------------------------------------------------*
      *
           INITIALIZE  WK-BONIF
      *
           IF  WK-CODSTU NOT = ZERO
                         AND 23
           THEN

               MOVE WK-CODSTU       TO STUD-COD-STUD
      *
               PERFORM 802-SELECT-TINFSTUD   THRU 802-SELECT-TINFSTUD-X

               IF  TROV-ESITO
               THEN
                   IF  CODSTU-OK
                   THEN
                       MOVE 'A'            TO WK-APP-RIF
                       IF  WK-DECIS = 'OK'
                       THEN
                           SET  WK-BONIF-OK   TO TRUE
                       END-IF
                   END-IF
                   IF  CODSTU-RE
                   THEN
                       MOVE 'R'            TO WK-APP-RIF
                   END-IF
               END-IF
           ELSE
               MOVE 'S'            TO WK-APP-RIF
           END-IF.
      *
      *----------------------------------------------------------------*
       340-COMPILA-ESITO-X.
           EXIT.
      *
       345-COMPILA-MESS.
      *----------------------------------------------------------------*
      *
           MOVE 1    TO X
           MOVE 1    TO Y
           MOVE 1    TO IND
           INITIALIZE  WK-APP-TESTO
                       TAB-TESTO
                       TAB-TESTO-TBLO
                       FLG-A-CAPO
      *
           PERFORM UNTIL IND > MAX-CARA
                OR Y > MAX-TAB-TEST
                  IF  FAX-TESTO-COND (IND : 2)  =  WK-A-CAPO
                  THEN
                      MOVE  WK-APP-TESTO    TO WK-ELE-TESTO (Y)
                      INITIALIZE WK-APP-TESTO
                      ADD  1    TO Y
                      MOVE 1    TO X
                      ADD  2    TO IND
                      SET A-CAPO-OK TO TRUE
                  ELSE
                      IF X NOT > LENGTH OF WK-APP-TESTO
                      THEN
                        MOVE FAX-TESTO-COND(IND:1)
                                              TO WK-APP-TESTO (X:1)
                        ADD  1    TO X
                        ADD  1    TO IND
                      ELSE
                        MOVE  WK-APP-TESTO    TO WK-ELE-TESTO (Y)
                        INITIALIZE WK-APP-TESTO
                        ADD  1    TO Y
                        MOVE 1    TO X
                        MOVE FAX-TESTO-COND(IND:1)
                                              TO WK-APP-TESTO (X:1)
                        ADD  1    TO X
                        ADD  1    TO IND
                      END-IF
                  END-IF
           END-PERFORM
      *
           IF NOT A-CAPO-OK
           THEN
               INSPECT FAX-TESTO-COND REPLACING ALL LOW-VALUE
                    BY SPACE
               MOVE FAX-TESTO-COND(1:60)    TO  WK-ELE-TESTO (1)
               MOVE FAX-TESTO-COND(61:60)   TO  WK-ELE-TESTO (2)
               MOVE FAX-TESTO-COND(121:60)  TO  WK-ELE-TESTO (3)
               MOVE FAX-TESTO-COND(181:60)  TO  WK-ELE-TESTO (4)
               MOVE FAX-TESTO-COND(241:60)  TO  WK-ELE-TESTO (5)        IS100615
               MOVE FAX-TESTO-COND(301:60)  TO  WK-ELE-TESTO (6)        IS100615
               MOVE FAX-TESTO-COND(361:60)  TO  WK-ELE-TESTO (7)        IS100615
               MOVE FAX-TESTO-COND(421:60)  TO  WK-ELE-TESTO (8)        IS100615
           END-IF
      *
           PERFORM VARYING  IND FROM 1 BY 1
      *             UNTIL IND > 4                                       IS100615
                    UNTIL IND > 8                                       IS100615
               MOVE WK-ELE-TESTO(IND)              TO CARA-STRINGA
               MOVE LENGTH OF WK-ELE-TESTO(IND)    TO CARA-LUN-STRINGA
      *
               PERFORM CTR-STRINGA
                  THRU CTR-STRINGA-X
      *
               MOVE CARA-STRINGA                   TO WK-ELE-TESTO(IND)
           END-PERFORM.
      *
           MOVE TAB-TESTO    TO TAB-TESTO-TBLO.
      *
      *----------------------------------------------------------------*
       345-COMPILA-MESS-X.
           EXIT.
      *
       460-TBLO-MESS-ESITO.
      *----------------------------------------------------------------*
      *
           MOVE WK-CODCLI           TO TBCCNCLI
      *
           PERFORM 792-SELECT-MINRANGE THRU 792-SELECT-MINRANGE-X
      *
           INITIALIZE DCLTBBLOCC
           MOVE WK-CODCLI              TO TBCCNCLI
      *
           MOVE WK-NUMPRA              TO TBCCNDOS
      *
           MOVE W-GG-ELABORAZIONE      TO K001-DATA10-GG
           MOVE W-MM-ELABORAZIONE      TO K001-DATA10-MM
           MOVE W-ANNO-ELABORAZIONE    TO K001-DATA10-ANNO
           MOVE K001-DATA-10           TO TBCCDENT
           MOVE 'DFAX'                 TO TBCCIDAR
           MOVE 'T'                    TO TBCCDOM
           MOVE 80080                  TO TBCCNAT
           MOVE W-RANGE                TO TBCCRANG
           SET  VAI                    TO TRUE
      *
      * SE CI SONO MESSAGGI IN COMMAREA  LI SCRIVO
      *
           IF   FAX-TESTO-COND NOT = SPACE AND LOW-VALUE
           THEN
             PERFORM VARYING  IND FROM 1 BY 1
      *              UNTIL IND > 6                                      IS100615
                     UNTIL IND > 12                                     IS100615
                COMPUTE TBCCRANG = TBCCRANG - 1
      *
                IF   TBCCRANG = ZERO
                THEN
                     INITIALIZE DCLT-INF-DFAX
                     MOVE FAX-NUM-PRA    TO DFAX-NUM-PRA
                     STRING  'ERRORE NUMERAZIONE TBLO'
                        DELIMITED BY SIZE
                        INTO DFAX-ERRORE
                     END-STRING
                     PERFORM 800-INSERT-TINFDFAX
                        THRU 800-INSERT-TINFDFAX-X
                     PERFORM 030-FINE THRU 030-FINE-X
                ELSE
      *
                  IF   WK-ELE-TESTO-TBLO(IND) NOT = SPACE
                  AND  WK-ELE-TESTO-TBLO(IND) NOT = LOW-VALUE
                  THEN
                     MOVE LENGTH OF WK-ELE-TESTO-TBLO(IND)
                                  TO TBCCMSG-LEN
      *
                     MOVE WK-ELE-TESTO-TBLO(IND)
                                  TO TBCCMSG-TEXT
      *
                     PERFORM 793-INSERT-TBBLOCC
                        THRU 793-INSERT-TBBLOCC-X
                  END-IF
                END-IF
             END-PERFORM
           END-IF
      *
      * RIGA PER INDIVIDUARE SE FAX O MAIL
      *
           MOVE 80066                 TO TBCCNAT
           COMPUTE TBCCRANG = TBCCRANG - 1
      *
           IF   TBCCRANG = ZERO
           THEN
                INITIALIZE DCLT-INF-DFAX
                MOVE FAX-NUM-PRA    TO DFAX-NUM-PRA
                STRING  'ERRORE NUMERAZIONE TBLO'
                        DELIMITED BY SIZE
                        INTO DFAX-ERRORE
                END-STRING
                PERFORM 800-INSERT-TINFDFAX
                   THRU 800-INSERT-TINFDFAX-X
                PERFORM 030-FINE THRU 030-FINE-X
           ELSE
      *
                MOVE LENGTH OF RIGA-TBLO
                                  TO TBCCMSG-LEN
      *
                IF  WK-FAX
                THEN
                        MOVE 'ESITO FAX             '    TO RIGA-TBLO
                        MOVE RIGA-TBLO                   TO TBCCMSG-TEXT
                ELSE
                        MOVE 'ESITO E-MAIL          '    TO RIGA-TBLO
                        MOVE RIGA-TBLO                   TO TBCCMSG-TEXT
                END-IF
      *
                PERFORM 793-INSERT-TBBLOCC
                   THRU 793-INSERT-TBBLOCC-X
           END-IF
      *
      * RIGA DI DESCRIZIONE DELLA PRATICA
      *
           COMPUTE TBCCRANG = TBCCRANG - 1
      *
           IF   TBCCRANG = ZERO
           THEN
                INITIALIZE DCLT-INF-DFAX
                MOVE FAX-NUM-PRA    TO DFAX-NUM-PRA
                STRING  'ERRORE NUMERAZIONE TBLO'
                        DELIMITED BY SIZE
                        INTO DFAX-ERRORE
                END-STRING
                PERFORM 800-INSERT-TINFDFAX
                   THRU 800-INSERT-TINFDFAX-X
                PERFORM 030-FINE THRU 030-FINE-X
           ELSE
      *
                MOVE LENGTH OF RIGA-TBLO             TO TBCCMSG-LEN
      *
                MOVE WK-APP-RIF                  TO RDE-APP-RIF
                MOVE WK-IMPFIN                   TO RDE-IMP-FIN
                MOVE WK-NUMDUR                   TO RDE-NUM-DUR
                MOVE WK-IMPMENS                  TO RDE-IMP-MENS
                MOVE WK-IMPASS                   TO RDE-IMP-ASS
                MOVE WK-CODMAXI                  TO RDE-COD-MAXI
                IF WK-CODMAXI NOT = SPACE AND LOW-VALUE AND '9'
                                                   AND '7'              SL121111
                THEN
                     MOVE TFXFL-MAXI               TO RDE-COD-MAXI
                     MOVE TFXIMPMAXI               TO WK-IMPMAXI
                                                      RDE-IMP-MAXI
                END-IF
      *
                MOVE RIGA-DESCR-ESITO            TO RIGA-TBLO
                MOVE RIGA-TBLO                   TO TBCCMSG-TEXT
      *
                PERFORM 793-INSERT-TBBLOCC
                   THRU 793-INSERT-TBBLOCC-X
           END-IF
      *
      * RIGA DI DESCRIZIONE DELLA MAXIRATA
      *    CODICE E IMPORTO MAXIRATA
      *
           IF    CLASSICO
      ***  AND  (WK-CODMAXI NOT = SPACE AND LOW-VALUE AND '9')
           AND  (WK-CODMAXI NOT = SPACE AND LOW-VALUE AND '9' AND '7')  SL190412
           THEN
               COMPUTE TBCCRANG = TBCCRANG - 1
      *
               IF   TBCCRANG = ZERO
               THEN
                    INITIALIZE DCLT-INF-DFAX
                    MOVE FAX-NUM-PRA    TO DFAX-NUM-PRA
                    STRING  'ERRORE NUMERAZIONE TBLO'
                        DELIMITED BY SIZE
                        INTO DFAX-ERRORE
                    END-STRING
                    PERFORM 800-INSERT-TINFDFAX
                       THRU 800-INSERT-TINFDFAX-X
                    PERFORM 030-FINE THRU 030-FINE-X
               ELSE
      *
                    MOVE LENGTH OF RIGA-TBLO             TO TBCCMSG-LEN
      *
                    MOVE RIGA-DESCR-MAXI             TO RIGA-TBLO
                    MOVE RIGA-TBLO                   TO TBCCMSG-TEXT
      *
                    PERFORM 793-INSERT-TBBLOCC
                       THRU 793-INSERT-TBBLOCC-X
               END-IF
           END-IF
      *
      * RIGA PER MAXIRATA (2° FASE)
      *
           IF    CLASSICO
      ***  AND  (WK-CODMAXI NOT = SPACE AND LOW-VALUE AND '9')
           AND  (WK-CODMAXI NOT = SPACE AND LOW-VALUE AND '9' AND '7'   SL190412
           AND   WK-CODMAXI NOT = 'B'                                   NO220715
           AND   WK-CODMAXI NOT = 'E')                                  NO261115
           THEN
               COMPUTE TBCCRANG = TBCCRANG - 1
      *
               IF   TBCCRANG = ZERO
               THEN
                    INITIALIZE DCLT-INF-DFAX
                    MOVE FAX-NUM-PRA    TO DFAX-NUM-PRA
                    STRING  'ERRORE NUMERAZIONE TBLO'
                        DELIMITED BY SIZE
                        INTO DFAX-ERRORE
                    END-STRING
                    PERFORM 800-INSERT-TINFDFAX
                       THRU 800-INSERT-TINFDFAX-X
                    PERFORM 030-FINE THRU 030-FINE-X
               ELSE
      *
                    MOVE LENGTH OF RIGA-TBLO         TO TBCCMSG-LEN
      *
                    MOVE TFXDUR                      TO RMX-NUM-DUR
                    MOVE TFXMENS                     TO RMX-IMP-MENS
      *
                    MOVE RIGA-MAXI                   TO RIGA-TBLO
                    MOVE RIGA-TBLO                   TO TBCCMSG-TEXT
      *
                    PERFORM 793-INSERT-TBBLOCC
                       THRU 793-INSERT-TBBLOCC-X
               END-IF
           END-IF
      *
      * RIGHE PER RATA VARIABILE
      *
           IF    CLASSICO
           AND   WK-CODMAXI = '9'
           THEN
               INITIALIZE SW-RATAVAR
      *
               MOVE WK-NUMPRA    TO SOTP-NUM-PRA
               MOVE WK-CODSOC    TO SOTP-COD-SOC                        AR311219
               PERFORM OPEN-CURS02
                  THRU OPEN-CURS02-X
      *
               PERFORM UNTIL FINE-RATAVAR
                  COMPUTE TBCCRANG = TBCCRANG - 1
      *
                  IF   TBCCRANG = ZERO
                  THEN
                       INITIALIZE DCLT-INF-DFAX
                       MOVE FAX-NUM-PRA    TO DFAX-NUM-PRA
                       STRING  'ERRORE NUMERAZIONE TBLO'
                               DELIMITED BY SIZE
                               INTO DFAX-ERRORE
                       END-STRING
                       PERFORM 800-INSERT-TINFDFAX
                          THRU 800-INSERT-TINFDFAX-X
                       PERFORM 030-FINE THRU 030-FINE-X
                  ELSE
      *
                       MOVE LENGTH OF RIGA-TBLO        TO TBCCMSG-LEN
      *
                       PERFORM FETCH-CURS02
                          THRU FETCH-CURS02-X
      *
                       IF  OK-ON-REC
                       THEN
                           MOVE SOTP-NUM-MENS         TO RMX-NUM-DUR
                           MOVE SOTP-IMP-MENS         TO RMX-IMP-MENS
      *
                           MOVE RIGA-MAXI              TO RIGA-TBLO
                           MOVE RIGA-TBLO              TO TBCCMSG-TEXT
      *
                           PERFORM 793-INSERT-TBBLOCC
                              THRU 793-INSERT-TBBLOCC-X
                       END-IF
                  END-IF
               END-PERFORM
      *
               PERFORM CLOSE-CURS02
                  THRU CLOSE-CURS02-X
           END-IF.
      *
      *----------------------------------------------------------------*
       460-TBLO-MESS-ESITO-X.
           EXIT.
      *
       460-TBLO-MESS-BONIF.
      *----------------------------------------------------------------*
      *
           MOVE WK-CODCLI           TO TBCCNCLI
      *
           PERFORM 792-SELECT-MINRANGE THRU 792-SELECT-MINRANGE-X
      *
           INITIALIZE DCLTBBLOCC
           MOVE WK-CODCLI              TO TBCCNCLI
      *
           MOVE WK-NUMPRA              TO TBCCNDOS
      *
           MOVE W-GG-ELABORAZIONE      TO K001-DATA10-GG
           MOVE W-MM-ELABORAZIONE      TO K001-DATA10-MM
           MOVE W-ANNO-ELABORAZIONE    TO K001-DATA10-ANNO
           MOVE K001-DATA-10           TO TBCCDENT
           MOVE 'DFAX'                 TO TBCCIDAR
           MOVE 'T'                    TO TBCCDOM
           MOVE 80080                  TO TBCCNAT
           MOVE W-RANGE                TO TBCCRANG
           SET  VAI                    TO TRUE
      *
      * RIGA PER INDIVIDUARE SE FAX O MAIL
      *
           MOVE 80067                  TO TBCCNAT
           COMPUTE TBCCRANG = TBCCRANG - 1
      *
           IF   TBCCRANG = ZERO
           THEN
                INITIALIZE DCLT-INF-DFAX
                MOVE FAX-NUM-PRA    TO DFAX-NUM-PRA
                STRING  'ERRORE NUMERAZIONE TBLO'
                        DELIMITED BY SIZE
                        INTO DFAX-ERRORE
                END-STRING
                PERFORM 800-INSERT-TINFDFAX
                   THRU 800-INSERT-TINFDFAX-X
                PERFORM 030-FINE THRU 030-FINE-X
           ELSE
      *
                    MOVE LENGTH OF RIGA-TBLO             TO TBCCMSG-LEN
      *
                    IF  WK-FAX
                    THEN
                        MOVE 'EROGAZ FAX            '    TO RIGA-TBLO
                        MOVE RIGA-TBLO                   TO TBCCMSG-TEXT
                    ELSE
                        MOVE 'EROGAZ E-MAIL         '    TO RIGA-TBLO
                        MOVE RIGA-TBLO                   TO TBCCMSG-TEXT
                    END-IF
                    IF WK-DRBE-OK
                       MOVE RIGA-TBLO                    TO RDD-P1
                       IF WK-MOD-PAG = 0
                          MOVE 'ASSEGNO '                TO RDD-P2
                       ELSE
                          MOVE 'BONIFICO '               TO RDD-P2
                       END-IF
                       MOVE RIGA-TBLO-DRBE               TO TBCCMSG-TEXT
                    END-IF
      *
                    PERFORM 793-INSERT-TBBLOCC
                       THRU 793-INSERT-TBBLOCC-X
           END-IF
      *
      * RIGA DI DESCRIZIONE DELLA PRATICA
      *
           COMPUTE TBCCRANG = TBCCRANG - 1
      *
           IF   TBCCRANG = ZERO
           THEN
                INITIALIZE DCLT-INF-DFAX
                MOVE FAX-NUM-PRA    TO DFAX-NUM-PRA
                STRING  'ERRORE NUMERAZIONE TBLO'
                        DELIMITED BY SIZE
                        INTO DFAX-ERRORE
                END-STRING
                PERFORM 800-INSERT-TINFDFAX
                   THRU 800-INSERT-TINFDFAX-X
                PERFORM 030-FINE THRU 030-FINE-X
           ELSE
      *
                    MOVE LENGTH OF RIGA-TBLO             TO TBCCMSG-LEN
      *
                    IF WK-DRBE-OK
                       MOVE WK-IMPEROG                  TO RDB1-IMP-FIN
                       MOVE WK-IMSIP                    TO RDB1-IMP-SIP
                       MOVE WK-IMPASS                   TO RDB1-IMP-ASS
      *
                       MOVE RIGA-BONIF-DRBE             TO RIGA-TBLO
                    ELSE
                       MOVE WK-IMPEROG                  TO RDB-IMP-FIN
                       MOVE WK-IMSIP                    TO RDB-IMP-SIP
                       MOVE WK-INTVDR                   TO RDB-INT-VDR
                       MOVE WK-IMPASS                   TO RDB-IMP-ASS
                       MOVE WK-BANCA                    TO RDB-BANCA
      *
                       MOVE RIGA-DESCR-BONIF            TO RIGA-TBLO
                    END-IF
                    MOVE RIGA-TBLO                   TO TBCCMSG-TEXT
      *
                    PERFORM 793-INSERT-TBBLOCC
                       THRU 793-INSERT-TBBLOCC-X
           END-IF.
      *
      *----------------------------------------------------------------*
       460-TBLO-MESS-BONIF-X.
           EXIT.
      *
      *
      ******************************************************************
      * OPERAZIONI DB2
      ******************************************************************
      *
      *
       OPEN-CURS02.
      *----------------------------------------------------------------*
      *
           MOVE SOTP-NUM-PRA      TO W-MSG-SOTPPRA.
      *
           EXEC SQL OPEN CURS02 END-EXEC
      *
           MOVE SQLCODE TO DB2-RETURN K001-ABD-SQLCODE
      *
           IF   NOT OK-ON-REC
           THEN
                INITIALIZE DCLT-INF-DFAX
                MOVE FAX-NUM-PRA    TO DFAX-NUM-PRA
                STRING  ' ERRORE OPEN CURS02 '
                        K001-ABD-SQLCODE
                        DELIMITED BY SIZE
                        INTO DFAX-ERRORE
                END-STRING
                PERFORM 800-INSERT-TINFDFAX
                   THRU 800-INSERT-TINFDFAX-X
                PERFORM 030-FINE THRU 030-FINE-X
           END-IF.
      *
      *----------------------------------------------------------------*
       OPEN-CURS02-X.
           EXIT.
      *
       FETCH-CURS02.
      *----------------------------------------------------------------*
      *
           EXEC SQL FETCH CURS02
                    INTO  :SOTP-IMP-MENS
                         ,:SOTP-NUM-MENS
                         ,:SOTP-NUM-INIZ-MENS
           END-EXEC
      *
           MOVE SQLCODE TO DB2-RETURN K001-ABD-SQLCODE
      *
           IF   NOT OK-ON-REC
           AND  NOT NTF-ON-REC
           THEN
                INITIALIZE DCLT-INF-DFAX
                MOVE FAX-NUM-PRA    TO DFAX-NUM-PRA
                STRING  ' ERRORE FETCH CURS02 '
                        K001-ABD-SQLCODE
                        DELIMITED BY SIZE
                        INTO DFAX-ERRORE
                END-STRING
                PERFORM 800-INSERT-TINFDFAX
                   THRU 800-INSERT-TINFDFAX-X
                PERFORM 030-FINE THRU 030-FINE-X
           END-IF
      *
           IF   NTF-ON-REC
           THEN
                SET FINE-RATAVAR    TO TRUE
           END-IF.
      *
      *----------------------------------------------------------------*
       FETCH-CURS02-X.
           EXIT.
      *
       CLOSE-CURS02.
      *----------------------------------------------------------------*
      *
           EXEC SQL CLOSE CURS02 END-EXEC.
      *
           MOVE SQLCODE TO DB2-RETURN K001-ABD-SQLCODE
      *
           IF   NOT OK-ON-REC
           THEN
                INITIALIZE DCLT-INF-DFAX
                MOVE FAX-NUM-PRA    TO DFAX-NUM-PRA
                STRING  ' ERRORE CLOSE CURS02 '
                        K001-ABD-SQLCODE
                        DELIMITED BY SIZE
                        INTO DFAX-ERRORE
                END-STRING
                PERFORM 800-INSERT-TINFDFAX
                   THRU 800-INSERT-TINFDFAX-X
                PERFORM 030-FINE THRU 030-FINE-X
           END-IF.
      *
      *----------------------------------------------------------------*
       CLOSE-CURS02-X.
           EXIT.
      *
       783-SELECT-TBVDVDR.
      *----------------------------------------------------------------*
      *
           INITIALIZE W-MSG-KEY-TBVDVDR.
           MOVE TVDAGR     TO W-MSG-TVDAGR.
      *
           EXEC SQL
                SELECT  TVDNOMMAG
                       ,TVDFAXMAG
                       ,TVDEMAILMAG
                       ,TVDADRMAG
                       ,TVDCPTTMAG
                       ,TVDVILMAG
                       ,TVDVENDFIN
                       ,TVDFLGFAX
                       ,TVDFLGMAIL
                INTO   :TVDNOMMAG
                      ,:TVDFAXMAG
                      ,:TVDEMAILMAG
                      ,:TVDADRMAG
                      ,:TVDCPTTMAG
                      ,:TVDVILMAG
                      ,:TVDVENDFIN
                      ,:TVDFLGFAX
                      ,:TVDFLGMAIL
                FROM    TBVDVDR
                WHERE   TVDAGR = :TVDAGR
           END-EXEC.
      *
           MOVE SQLCODE TO DB2-RETURN K001-ABD-SQLCODE
      *
           IF   NOT OK-ON-REC
           THEN
               INITIALIZE DCLT-INF-DFAX
               MOVE FAX-NUM-PRA    TO DFAX-NUM-PRA
               STRING  'ERRORE SELECT TBVDVDR '
                        K001-ABD-SQLCODE
                        DELIMITED BY SIZE
                        INTO DFAX-ERRORE
               END-STRING
               PERFORM 800-INSERT-TINFDFAX  THRU 800-INSERT-TINFDFAX-X
               PERFORM 030-FINE THRU 030-FINE-X
           END-IF.
      *
      *----------------------------------------------------------------*
       783-SELECT-TBVDVDR-X.
           EXIT.
      *
       784-SELECT-TBVDPRO.
      *----------------------------------------------------------------*
      *
           MOVE TPRLPROD   TO W-MSG-TVDPRO.
      *
           EXEC SQL
                SELECT  TPRMODFIN
                       ,TPRCBQR
                INTO   :TPRMODFIN
                      ,:TPRCBQR
                FROM    TBVDPRO
                WHERE   TPRAGR     = :TPRAGR
                AND     TPRLPROD   = :TPRLPROD
           END-EXEC.
      *
           MOVE SQLCODE TO DB2-RETURN K001-ABD-SQLCODE
      *
           IF   NOT OK-ON-REC
           THEN
                INITIALIZE DCLT-INF-DFAX
                MOVE FAX-NUM-PRA    TO DFAX-NUM-PRA
                STRING  'ERRORE SELECT TBVDPRO '
                        K001-ABD-SQLCODE
                        DELIMITED BY SIZE
                        INTO DFAX-ERRORE
                END-STRING
                PERFORM 800-INSERT-TINFDFAX
                   THRU 800-INSERT-TINFDFAX-X
                PERFORM 030-FINE THRU 030-FINE-X
           END-IF.
      *
      *----------------------------------------------------------------*
       784-SELECT-TBVDPRO-X.
           EXIT.
      *
       785-SELECT-TBVDBQE.
      *----------------------------------------------------------------*
      *
           MOVE TBVRANG    TO W-MSG-TVDBQE.
      *
           EXEC SQL
                SELECT  TBVCBQE
                       ,TBVCGUIC
                       ,TBVNCPTE
                       ,TBVTITU
                INTO   :TBVCBQE
                      ,:TBVCGUIC
                      ,:TBVNCPTE
                      ,:TBVTITU
                FROM    TBVDBQE
                WHERE   TBVAGR     = :TBVAGR
                AND     TBVRANG    = :TBVRANG
           END-EXEC.
      *
           MOVE SQLCODE TO DB2-RETURN K001-ABD-SQLCODE
      *
           IF   NOT OK-ON-REC
           THEN
                INITIALIZE DCLT-INF-DFAX
                MOVE FAX-NUM-PRA    TO DFAX-NUM-PRA
                STRING  'ERRORE SELECT TBVDBQE '
                        K001-ABD-SQLCODE
                        DELIMITED BY SIZE
                        INTO DFAX-ERRORE
                END-STRING
                PERFORM 800-INSERT-TINFDFAX
                   THRU 800-INSERT-TINFDFAX-X
                PERFORM 030-FINE THRU 030-FINE-X
           END-IF.
      *
      *----------------------------------------------------------------*
       785-SELECT-TBVDBQE-X.
           EXIT.
      *
       792-SELECT-MINRANGE.
      *----------------------------------------------------------------*
      *
           INITIALIZE W-MSG-KEY-TBBLOCC.
           MOVE TBCCNCLI          TO W-MSG-BLOCCLI.
      *
           EXEC SQL
                SELECT  VALUE(MIN (TBCCRANG), 99900)
                INTO   :W-RANGE
                FROM    TBBLOCC
                WHERE   TBCCNCLI = :TBCCNCLI
                AND     TBCCRANG < 99900
           END-EXEC.
      *
           MOVE SQLCODE    TO DB2-RETURN
                              K001-ABD-SQLCODE
      *
           IF   NOT OK-ON-REC
           AND  NOT NTF-ON-REC
           THEN
                INITIALIZE DCLT-INF-DFAX
                MOVE FAX-NUM-PRA    TO DFAX-NUM-PRA
                STRING  'ERRORE SELECT MAX TBBBLOCC '
                        K001-ABD-SQLCODE
                        DELIMITED BY SIZE
                        INTO DFAX-ERRORE
                END-STRING
                PERFORM 800-INSERT-TINFDFAX
                   THRU 800-INSERT-TINFDFAX-X
                PERFORM 030-FINE THRU 030-FINE-X
           END-IF.
      *
      *----------------------------------------------------------------*
       792-SELECT-MINRANGE-X.
           EXIT.
      *
       793-INSERT-TBBLOCC.
      *----------------------------------------------------------------*
      *
           INITIALIZE W-MSG-KEY-TBBLOCC.
           MOVE TBCCNCLI          TO W-MSG-BLOCCLI.
      *
           EXEC SQL INSERT
                INTO     TBBLOCC
                        (TBCCNCLI,
                         TBCCRANG,
                         TBCCNDOS,
                         TBCCDENT,
                         TBCCIDAR,
                         TBCCDOM,
                         TBCCNAT,
                         TBCCMSG)
                VALUES (:TBCCNCLI,
                        :TBCCRANG,
                        :TBCCNDOS,
                        :TBCCDENT,
                        :TBCCIDAR,
                        :TBCCDOM,
                        :TBCCNAT,
                        :TBCCMSG)
           END-EXEC
      *
           MOVE SQLCODE    TO DB2-RETURN
                              K001-ABD-SQLCODE
      *
           IF   NOT OK-ON-REC
           THEN
                INITIALIZE DCLT-INF-DFAX
                MOVE FAX-NUM-PRA    TO DFAX-NUM-PRA
                STRING  'ERRORE INSERT TBBBLOCC '
                        K001-ABD-SQLCODE
                        DELIMITED BY SIZE
                        INTO DFAX-ERRORE
                END-STRING
                PERFORM 800-INSERT-TINFDFAX
                   THRU 800-INSERT-TINFDFAX-X
                PERFORM 030-FINE THRU 030-FINE-X
           END-IF.
      *
      *----------------------------------------------------------------*
       793-INSERT-TBBLOCC-X.
           EXIT.
      *
       800-SELECT-TCQQDOSS.
      *----------------------------------------------------------------*
      *
           INITIALIZE W-MSG-KEY-TCQQDOSS.
           MOVE DOSS-COD-SOC      TO W-MSG-DOSSSOC.
           MOVE DOSS-NUM-PRA      TO W-MSG-DOSSPRA.
      *
           EXEC SQL SELECT DOSS_COD_ESI
                      INTO :DOSS-COD-ESI
                      FROM T_CQQ_DOSS
                     WHERE DOSS_NUM_PRA   = :DOSS-NUM-PRA
                     AND   DOSS_TIPO_STO  = 'S'
                     AND   DOSS_COD_SOC   = :DOSS-COD-SOC
           END-EXEC.
      *
           MOVE SQLCODE TO DB2-RETURN K001-ABD-SQLCODE
      *
           IF   NOT OK-ON-REC
           AND  NOT NTF-ON-REC
           THEN
                INITIALIZE DCLT-INF-DFAX
                MOVE FAX-NUM-PRA    TO DFAX-NUM-PRA
                STRING  'ERRORE SELECT T_CQQ-DOSS '
                        K001-ABD-SQLCODE
                        DELIMITED BY SIZE
                        INTO DFAX-ERRORE
                END-STRING
                PERFORM 800-INSERT-TINFDFAX
                   THRU 800-INSERT-TINFDFAX-X
                PERFORM 030-FINE THRU 030-FINE-X
           END-IF.
      *
      *----------------------------------------------------------------*
       800-SELECT-TCQQDOSS-X.
           EXIT.
      *
       801-SELECT-TCQQDOST.
      *----------------------------------------------------------------*
      *
           INITIALIZE W-MSG-KEY-TCQQDOST.
           MOVE DOST-COD-SOC      TO W-MSG-DOSTSOC.
           MOVE DOST-NUM-PRA      TO W-MSG-DOSTPRA.
      *
           EXEC SQL SELECT DOST_COD_ESI
                      INTO :DOST-COD-ESI
                      FROM T_CQQ_DOST
                     WHERE DOST_NUM_PRA   = :DOST-NUM-PRA
                     AND   DOST_TIP_PROV = 'S'
                     AND   DOST_COD_SOC   = :DOST-COD-SOC
           END-EXEC.
      *
           MOVE SQLCODE TO DB2-RETURN K001-ABD-SQLCODE
      *
           IF   NOT OK-ON-REC
           AND  NOT NTF-ON-REC
           THEN
                INITIALIZE DCLT-INF-DFAX
                MOVE FAX-NUM-PRA    TO DFAX-NUM-PRA
                STRING  'ERRORE SELECT T_CQQ_DOST '
                        K001-ABD-SQLCODE
                        DELIMITED BY SIZE
                        INTO DFAX-ERRORE
                END-STRING
                PERFORM 800-INSERT-TINFDFAX
                   THRU 800-INSERT-TINFDFAX-X
                PERFORM 030-FINE THRU 030-FINE-X
           END-IF.
      *
      *----------------------------------------------------------------*
       801-SELECT-TCQQDOST-X.
           EXIT.
      *
       802-SELECT-TINFSTUD.
      *----------------------------------------------------------------*
      *
           INITIALIZE SW-CODSTU-RE
           INITIALIZE SW-CODSTU-OK
           INITIALIZE SW-ESITO
           INITIALIZE W-MSG-KEY-TINFSTUD.
           MOVE STUD-COD-STUD     TO W-MSG-CODSTUD.
      *
      *
           EXEC SQL SELECT STUD_COD_DECI
                      INTO :STUD-COD-DECI
                      FROM T_INF_STUD
                     WHERE STUD_COD_STUD  = :STUD-COD-STUD
           END-EXEC.

           MOVE SQLCODE TO DB2-RETURN K001-ABD-SQLCODE

           IF   NOT OK-ON-REC
           AND  NOT NTF-ON-REC
           THEN
                INITIALIZE DCLT-INF-DFAX
                MOVE FAX-NUM-PRA    TO DFAX-NUM-PRA
                STRING  'ERRORE SELECT T_INF_STUD '
                        K001-ABD-SQLCODE
                        DELIMITED BY SIZE
                        INTO DFAX-ERRORE
                END-STRING
                PERFORM 800-INSERT-TINFDFAX
                   THRU 800-INSERT-TINFDFAX-X
                PERFORM 030-FINE THRU 030-FINE-X
           END-IF.
      *
           IF  OK-ON-REC
           AND STUD-COD-DECI = 'OK'
           THEN
               SET  TROV-ESITO   TO TRUE
               SET  CODSTU-OK    TO TRUE
           END-IF.
      *
           IF  OK-ON-REC
           AND STUD-COD-DECI = 'RE'
           THEN
               SET  TROV-ESITO   TO TRUE
               SET  CODSTU-RE    TO TRUE
           END-IF.
      *
      *----------------------------------------------------------------*
       802-SELECT-TINFSTUD-X.
           EXIT.
      *
       SELECT-TFINMAXI.
      *----------------------------------------------------------------*
      *
           INITIALIZE W-MSG-KEY-TFINMAXI.
           MOVE TFXNUMPRA         TO W-MSG-TFXPRA.
      *
           EXEC SQL SELECT TFXDUR
                          ,TFXMENS
                          ,TFXFL_MAXI
                          ,TFXIMPMAXI
                          ,TFXBMENS_OLD
                          ,TFXMMENS_OLD
                          ,TFXFL_RIFI
                      INTO :TFXDUR
                          ,:TFXMENS
                          ,:TFXFL-MAXI
                          ,:TFXIMPMAXI
                          ,:TFXBMENS-OLD
                          ,:TFXMMENS-OLD
                          ,:TFXFL-RIFI
                      FROM T_FIN_MAXI
                     WHERE TFXNUMPRA = :TFXNUMPRA
           END-EXEC.
      *
           MOVE SQLCODE TO DB2-RETURN K001-ABD-SQLCODE
      *
           IF   NOT OK-ON-REC
           AND  NOT NTF-ON-REC
           THEN
                INITIALIZE DCLT-INF-DFAX
                MOVE FAX-NUM-PRA    TO DFAX-NUM-PRA
                STRING  'ERRORE SELECT T_FIN_MAXI '
                        K001-ABD-SQLCODE
                        DELIMITED BY SIZE
                        INTO DFAX-ERRORE
                END-STRING
                PERFORM 800-INSERT-TINFDFAX
                   THRU 800-INSERT-TINFDFAX-X
                PERFORM 030-FINE THRU 030-FINE-X
           END-IF.
      *
      *----------------------------------------------------------------*
       SELECT-TFINMAXI-X.
           EXIT.
      *
       SELECT-TNECORBE.
      *----------------------------------------------------------------*
      *
           INITIALIZE W-MSG-KEY-TNECORBE.
           MOVE ORBE-COD-VDR      TO W-MSG-ORBEVDR
           MOVE ORBE-COD-SOC      TO W-MSG-ORBESOC
      *
           EXEC SQL SELECT ORBE_COD_VDR
                      INTO :ORBE-COD-VDR
                      FROM T_NEC_ORBE
                     WHERE ORBE_COD_VDR  = :ORBE-COD-VDR
                     AND   ORBE_COD_SOC  = :ORBE-COD-SOC
           END-EXEC.
      *
           MOVE SQLCODE TO DB2-RETURN K001-ABD-SQLCODE
      *
           IF   NOT OK-ON-REC
           AND  NOT NTF-ON-REC
           THEN
                INITIALIZE DCLT-INF-DFAX
                MOVE FAX-NUM-PRA    TO DFAX-NUM-PRA
                STRING  'ERRORE SELECT T_NEC_ORBE '
                        K001-ABD-SQLCODE
                        DELIMITED BY SIZE
                        INTO DFAX-ERRORE
                END-STRING
                PERFORM 800-INSERT-TINFDFAX
                   THRU 800-INSERT-TINFDFAX-X
                PERFORM 030-FINE THRU 030-FINE-X
           END-IF.
      *
      *----------------------------------------------------------------*
       SELECT-TNECORBE-X.
           EXIT.
      *
       CERCA-TIPVDR.
      *----------------------------------------------------------------*
      *
           EXEC SQL SELECT TVDTIPVDR
                      INTO :TVDTIPVDR
                      FROM TBVDVDR
                     WHERE TVDAGR = :TVDAGR
           END-EXEC.
      *
           MOVE SQLCODE TO DB2-RETURN K001-ABD-SQLCODE
      *
           IF   NOT OK-ON-REC
           THEN
                INITIALIZE DCLT-INF-DFAX
                MOVE FAX-NUM-PRA    TO DFAX-NUM-PRA
                STRING  'ERRORE SELECT TBVDVDR    '
                        K001-ABD-SQLCODE
                        DELIMITED BY SIZE
                        INTO DFAX-ERRORE
                END-STRING
                PERFORM 800-INSERT-TINFDFAX
                   THRU 800-INSERT-TINFDFAX-X
                PERFORM 030-FINE THRU 030-FINE-X
           END-IF.
      *
      *----------------------------------------------------------------*
       CERCA-TIPVDR-X.
           EXIT.
      *
       SELECT-TATAAGEN.
      *----------------------------------------------------------------*
      *
           INITIALIZE W-MSG-KEY-TATAAGEN.
           MOVE AGEN-COD-AGE      TO W-MSG-AGENAGE
      *
           EXEC SQL SELECT AGEN_DES_CITTA
                          ,AGEN_COD_CAP
                          ,AGEN_DES_IND
                          ,AGEN_NUM_TEL
                          ,AGEN_DES_AGE
                      INTO :AGEN-DES-CITTA
                          ,:AGEN-COD-CAP
                          ,:AGEN-DES-IND
                          ,:AGEN-NUM-TEL
                          ,:AGEN-DES-AGE
                      FROM T_ATA_AGEN
                     WHERE AGEN_COD_AGE  = :AGEN-COD-AGE
           END-EXEC.
      *
           MOVE SQLCODE TO DB2-RETURN K001-ABD-SQLCODE
      *
           IF   NOT OK-ON-REC
           THEN
                INITIALIZE DCLT-INF-DFAX
                MOVE FAX-NUM-PRA    TO DFAX-NUM-PRA
                STRING  'ERRORE SELECT T_ATA_AGEN '
                        K001-ABD-SQLCODE
                        DELIMITED BY SIZE
                        INTO DFAX-ERRORE
                END-STRING
                PERFORM 800-INSERT-TINFDFAX
                   THRU 800-INSERT-TINFDFAX-X
                PERFORM 030-FINE THRU 030-FINE-X
           END-IF.
      *
      *----------------------------------------------------------------*
       SELECT-TATAAGEN-X.
           EXIT.
      *
       SELECT-TGENSOCI.
      *----------------------------------------------------------------*
      *
           INITIALIZE W-MSG-KEY-TGENSOCI.
           MOVE SOCI-CODSOC       TO W-MSG-SOC
      *
           EXEC SQL SELECT SOCI_DESCRIZIONE
                          ,SOCI_COD_FOB
                      INTO :SOCI-DESCRIZIONE
                          ,:SOCI-COD-FOB
                      FROM T_GEN_SOCI
                     WHERE SOCI_CODSOC   = :SOCI-CODSOC
           END-EXEC.
      *
           MOVE SQLCODE TO DB2-RETURN K001-ABD-SQLCODE
      *
           IF   NOT OK-ON-REC
           THEN
                INITIALIZE DCLT-INF-DFAX
                MOVE FAX-NUM-PRA    TO DFAX-NUM-PRA
                STRING  'ERRORE SELECT T_GEN_SOCI SQLCODE: '
                        K001-ABD-SQLCODE '  SOC: '
                        W-MSG-SOC
                        DELIMITED BY SIZE
                        INTO DFAX-ERRORE
                END-STRING
                PERFORM 800-INSERT-TINFDFAX
                   THRU 800-INSERT-TINFDFAX-X
                PERFORM 030-FINE THRU 030-FINE-X
           END-IF.
      *
      *----------------------------------------------------------------*
       SELECT-TGENSOCI-X.
           EXIT.
      *
       SELECT-TVARPRAT.
      *----------------------------------------------------------------*
      *
           INITIALIZE W-MSG-KEY-TVARPRAT.
           MOVE PRAT-COD-SOC      TO W-MSG-VARSOC
           MOVE PRAT-NUM-PRA      TO W-MSG-VARPRA
      *
           EXEC SQL SELECT PRAT_IMP_INT_VDR
                      INTO :PRAT-IMP-INT-VDR
                      FROM T_VAR_PRAT
                     WHERE PRAT_COD_SOC  = :PRAT-COD-SOC
                     AND   PRAT_NUM_PRA  = :PRAT-NUM-PRA
           END-EXEC.
      *
           MOVE SQLCODE TO DB2-RETURN K001-ABD-SQLCODE
      *
           IF   NOT OK-ON-REC
           THEN
                INITIALIZE DCLT-INF-DFAX
                MOVE FAX-NUM-PRA    TO DFAX-NUM-PRA
                STRING  'ERRORE SELECT T_VAR_PRAT '
                        K001-ABD-SQLCODE
                        DELIMITED BY SIZE
                        INTO DFAX-ERRORE
                END-STRING
                PERFORM 800-INSERT-TINFDFAX
                   THRU 800-INSERT-TINFDFAX-X
                PERFORM 030-FINE THRU 030-FINE-X
           END-IF.
      *
      *----------------------------------------------------------------*
       SELECT-TVARPRAT-X.
           EXIT.
      *
       SELECT-SNUMDFAX.
      *----------------------------------------------------------------*
      *
           EXEC SQL SELECT NEXT VALUE FOR S_NUM_DFAX
                      INTO :WK-VALUE
                      FROM T_GEN_SOCI
                     WHERE SOCI_CODSOC = 100
           END-EXEC
      *
           MOVE SQLCODE TO DB2-RETURN K001-ABD-SQLCODE
      *
           IF   NOT OK-ON-REC
           THEN
                INITIALIZE DCLT-INF-DFAX
                MOVE FAX-NUM-PRA    TO DFAX-NUM-PRA
                STRING  'ERRORE SELECT S_NUM_DFAX '
                        K001-ABD-SQLCODE
                        DELIMITED BY SIZE
                        INTO DFAX-ERRORE
                END-STRING
                PERFORM 800-INSERT-TINFDFAX
                   THRU 800-INSERT-TINFDFAX-X
                PERFORM 030-FINE THRU 030-FINE-X
           END-IF.
      *
      *----------------------------------------------------------------*
       SELECT-SNUMDFAX-X.
           EXIT.
      *
       800-INSERT-TINFDFAX.
      *----------------------------------------------------------------*
      *
           EXEC SQL INSERT  INTO T_INF_DFAX
                            (DFAX_NUM_PRA
                            ,DFAX_DATA_INS
                            ,DFAX_NUM_FAX
                            ,DFAX_DES_MAIL
                            ,DFAX_ERRORE)
                    VALUES
                           (:DFAX-NUM-PRA
                           ,CURRENT TIMESTAMP
                           ,:DFAX-NUM-FAX
                           ,:DFAX-DES-MAIL
                           ,:DFAX-ERRORE)
           END-EXEC.
      *
           MOVE SQLCODE TO DB2-RETURN K001-ABD-SQLCODE.
      *
           IF  OK-ON-REC
           THEN
               CONTINUE
           ELSE
               EXEC CICS ABEND  ABCODE ('DFAX') END-EXEC
           END-IF.
      *
      *----------------------------------------------------------------*
       800-INSERT-TINFDFAX-X.
           EXIT.
      *
      ******************************************************************
      * OPERAZIONI DL1
      ******************************************************************
      *
      *
      *
       862-GU-CLDRAC.
      *----------------------------------------------------------------*
      *
           EXEC DLI GU  USING PCB         (3)
                              SEGMENT     (CLDRAC)
                              WHERE       (CDNODO=KEY-CLDRAC)
                              FIELDLENGTH (LENGTH OF KEY-CLDRAC)
                              SEGLENGTH   (LENGTH OF CRACLIEN)
                              INTO        (CRACLIEN)
           END-EXEC.
      *
           IF   DIBSTAT NOT = SPACE AND 'GE'
           THEN
                INITIALIZE DCLT-INF-DFAX
                MOVE FAX-NUM-PRA    TO DFAX-NUM-PRA
                STRING  'ERRORE GU CLDRAC  '
                        DIBSTAT
                        DELIMITED BY SIZE
                        INTO DFAX-ERRORE
                END-STRING
                PERFORM 800-INSERT-TINFDFAX
                   THRU 800-INSERT-TINFDFAX-X
                PERFORM 030-FINE THRU 030-FINE-X
           END-IF.
      *
      *----------------------------------------------------------------*
       862-GU-CLDRAC-X.
           EXIT.
      *
      *
       861-GU-CPDRAC.
      *----------------------------------------------------------------*
      *
           EXEC DLI GU  USING PCB         (1)
                              SEGMENT     (CPDRAC)
                              WHERE       (RDNODO=KEY-CPDRAC)
                              FIELDLENGTH (LENGTH OF KEY-CPDRAC)
                              SEGLENGTH   (LENGTH OF BASCARTE)
                              INTO        (BASCARTE)
           END-EXEC.
      *
           IF   DIBSTAT NOT = SPACE AND 'GE'
           THEN
                INITIALIZE DCLT-INF-DFAX
                MOVE FAX-NUM-PRA    TO DFAX-NUM-PRA
                STRING  'ERRORE GU CPDRAC  '
                        DIBSTAT
                        DELIMITED BY SIZE
                        INTO DFAX-ERRORE
                END-STRING
                PERFORM 800-INSERT-TINFDFAX
                   THRU 800-INSERT-TINFDFAX-X
                PERFORM 030-FINE THRU 030-FINE-X
           END-IF.
      *
      *----------------------------------------------------------------*
       861-GU-CPDRAC-X.
           EXIT.
      *
       851-GNP-CPDCOM.
      *----------------------------------------------------------------*
      *
           EXEC DLI GNP USING PCB         (1)
                              SEGMENT     (CPDCOM)
                              INTO        (BASCAR2)
           END-EXEC.
      *
           IF   DIBSTAT NOT = SPACE
           THEN
                INITIALIZE DCLT-INF-DFAX
                MOVE FAX-NUM-PRA    TO DFAX-NUM-PRA
                STRING  'ERRORE GNP CPDCOM  '
                        DIBSTAT
                        DELIMITED BY SIZE
                        INTO DFAX-ERRORE
                END-STRING
                PERFORM 800-INSERT-TINFDFAX
                   THRU 800-INSERT-TINFDFAX-X
                PERFORM 030-FINE THRU 030-FINE-X
           END-IF.
      *
      *----------------------------------------------------------------*
       851-GNP-CPDCOM-X.
           EXIT.
      *
       862-GNP-CPDBQE.
      *----------------------------------------------------------------*
      *
           EXEC DLI GNP USING PCB         (1)
                              SEGMENT     (CPDBQE)
                              INTO        (BASCAR1)
           END-EXEC.
      *
           IF   DIBSTAT NOT = SPACE
           AND  DIBSTAT NOT = 'GE'
           THEN
                INITIALIZE DCLT-INF-DFAX
                MOVE FAX-NUM-PRA    TO DFAX-NUM-PRA
                STRING  'ERRORE GNP CPDBQE '
                        DIBSTAT
                        DELIMITED BY SIZE
                        INTO DFAX-ERRORE
                END-STRING
                PERFORM 800-INSERT-TINFDFAX
                   THRU 800-INSERT-TINFDFAX-X
                PERFORM 030-FINE THRU 030-FINE-X
           END-IF.
      *
           IF   DIBSTAT = SPACE
           THEN
                MOVE BC1CODNAZ     TO WK-NAZ
                MOVE BC1CHECKDIGIT TO WK-CHECKDIGIT
                MOVE BC1CIN        TO WK-CIN
                MOVE BC1CBQUE      TO WK-ABICLI
                MOVE BC1CGUIC      TO WK-CABCLI
                MOVE BC1NCPTE      TO WK-CONTOCLI
           END-IF.
      *
      *----------------------------------------------------------------*
       862-GNP-CPDBQE-X.
           EXIT.
      *
       860-GU-DODRAC.
      *----------------------------------------------------------------*
      *
           EXEC DLI GU  USING PCB         (2)
                              SEGMENT     (DODRAC)
                              WHERE       (DDNODO=KEY-DODRAC)
                              INTO        (BASDOSDIR)
           END-EXEC.
      *
           IF   DIBSTAT NOT = SPACE AND 'GE'
           THEN
                INITIALIZE DCLT-INF-DFAX
                MOVE FAX-NUM-PRA    TO DFAX-NUM-PRA
                STRING  'ERRORE GU DODRAC  '
                        DIBSTAT
                        DELIMITED BY SIZE
                        INTO DFAX-ERRORE
                END-STRING
                PERFORM 800-INSERT-TINFDFAX
                   THRU 800-INSERT-TINFDFAX-X
                PERFORM 030-FINE THRU 030-FINE-X
           END-IF.
      *
      *----------------------------------------------------------------*
       860-GU-DODRAC-X.
           EXIT.
      *
       850-GNP-DODCOM.
      *----------------------------------------------------------------*
      *
           EXEC DLI GNP USING PCB         (2)
                              SEGMENT     (DODCOM)
                              INTO        (COMPDOSDIR)
           END-EXEC.
      *
           IF   DIBSTAT NOT = SPACE
           THEN
                INITIALIZE DCLT-INF-DFAX
                MOVE FAX-NUM-PRA    TO DFAX-NUM-PRA
                STRING  'ERRORE GNP DODCOM '
                        DIBSTAT
                        DELIMITED BY SIZE
                        INTO DFAX-ERRORE
                END-STRING
                PERFORM 800-INSERT-TINFDFAX
                   THRU 800-INSERT-TINFDFAX-X
                PERFORM 030-FINE THRU 030-FINE-X
           END-IF.
      *
      *----------------------------------------------------------------*
       850-GNP-DODCOM-X.
           EXIT.
      *
       852-GNP-DODBQE.
      *----------------------------------------------------------------*
      *
           EXEC DLI GNP USING PCB         (2)
                              SEGMENT     (DODBQE)
                              INTO        (BQDOSDIR)
           END-EXEC.
      *
           IF   DIBSTAT NOT = SPACE
           AND  DIBSTAT NOT = 'GE'
           THEN
                INITIALIZE DCLT-INF-DFAX
                MOVE FAX-NUM-PRA    TO DFAX-NUM-PRA
                STRING  'ERRORE GNP DODBQE '
                        DIBSTAT
                        DELIMITED BY SIZE
                        INTO DFAX-ERRORE
                END-STRING
                PERFORM 800-INSERT-TINFDFAX
                   THRU 800-INSERT-TINFDFAX-X
                PERFORM 030-FINE THRU 030-FINE-X
           END-IF.
      *
           IF   DIBSTAT = SPACE
           THEN
                MOVE DKCODNAZ     TO WK-NAZ
                MOVE DKCHECKDIGIT TO WK-CHECKDIGIT
                MOVE DKCIN        TO WK-CIN
                MOVE DKCBQUE      TO WK-ABICLI
                MOVE DKCGUIC      TO WK-CABCLI
                MOVE DKNCPTE      TO WK-CONTOCLI
           END-IF.
      *
      *----------------------------------------------------------------*
       852-GNP-DODBQE-X.
           EXIT.
      *
       PREPARA-ESITO.
      *----------------------------------------------------------------*
      *
           MOVE WK-CODSOC           TO SOCI-CODSOC
           PERFORM SELECT-TGENSOCI   THRU SELECT-TGENSOCI-X
      *
           IF WK-CODMAXI NOT = SPACE AND LOW-VALUE AND '9'
                                     AND '7'                            SL121111
                                     AND 'B'                            NO220715
                                     AND 'E'                            NO261115
           THEN
              MOVE WK-NUMPRA                TO TFXNUMPRA
              PERFORM SELECT-TFINMAXI
                 THRU SELECT-TFINMAXI-X

              IF  OK-ON-REC
              THEN
                  MOVE TFXIMPMAXI               TO WK-IMPMAXI
              ELSE
                INITIALIZE DCLT-INF-DFAX
                MOVE FAX-NUM-PRA    TO DFAX-NUM-PRA
                STRING  'PRATICA DI MAXI NON IN T_FIN_MAXI '
                        DELIMITED BY SIZE
                        INTO DFAX-ERRORE
                END-STRING
                PERFORM 800-INSERT-TINFDFAX
                   THRU 800-INSERT-TINFDFAX-X
                PERFORM 030-FINE THRU 030-FINE-X
              END-IF
           ELSE                                                         NO220715
              IF  WK-CODMAXI = 'B'                                      NO220715
              OR  WK-CODMAXI = 'E'                                      NO261115
                  MOVE WK-NUMPRA            TO TFXNUMPRA                NO220715
                  MOVE ZEROES               TO TFXDUR                   NO220715
                  MOVE ZEROES               TO TFXMENS                  NO220715
                  MOVE WK-CODMAXI           TO TFXFL-MAXI               NO220715
                  MOVE WK-IMPMAXI           TO TFXIMPMAXI               NO220715
                  MOVE ZEROES               TO TFXBMENS-OLD             NO220715
                  MOVE ZEROES               TO TFXMMENS-OLD             NO220715
                  MOVE SPACES               TO TFXFL-RIFI               NO220715
              END-IF                                                    NO220715
           END-IF
      *
           PERFORM 460-TBLO-MESS-ESITO
              THRU 460-TBLO-MESS-ESITO-X
      *
           INITIALIZE FAXC0002
      *
      **** PREPARA CODA TS  PER ESITO
      *
           PERFORM SELECT-SNUMDFAX
              THRU SELECT-SNUMDFAX-X
      *

           MOVE WK-VALUE       TO TS-NOME-CODA
           MOVE TS-NOME-CODA   TO DF1X-NOME-CODA
      *
           PERFORM PREPARA-TESTATA-JOB
              THRU PREPARA-TESTATA-JOB-X
      *
           PERFORM PREPARA-CODA-ESITO
              THRU PREPARA-CODA-ESITO-X
      *
           PERFORM PREPARA-CODA-JOB
              THRU PREPARA-CODA-JOB-X
      *
           PERFORM 060-START-TRANSID
              THRU 060-START-TRANSID
      *
           INITIALIZE DCLT-INF-DFAX
           MOVE FAX-NUM-PRA    TO DFAX-NUM-PRA
           STRING  'RICHIESTA ESITO INOLTRATA '
                        DIBSTAT
                        DELIMITED BY SIZE
                        INTO DFAX-ERRORE
           END-STRING
           IF  WK-FAX
           THEN
               MOVE WK-NUMFAX   TO DFAX-NUM-FAX
           END-IF
           IF  WK-MAIL
           THEN
               MOVE WK-INDMAIL  TO DFAX-DES-MAIL
           END-IF
           PERFORM 800-INSERT-TINFDFAX
              THRU 800-INSERT-TINFDFAX-X.
      *
      *----------------------------------------------------------------*
       PREPARA-ESITO-X.
           EXIT.
      *
       PREPARA-BONIF.
      *----------------------------------------------------------------*
      *
           MOVE WK-CODSOC           TO SOCI-CODSOC
           PERFORM SELECT-TGENSOCI   THRU SELECT-TGENSOCI-X
      *
      *  AL PF11, SCRIVO I MESSAGGI NEL TBLO
      *
           PERFORM 460-TBLO-MESS-BONIF
              THRU 460-TBLO-MESS-BONIF-X
      *
      **** PREPARA CODA TS  PER BONIF
      *
           PERFORM SELECT-SNUMDFAX
              THRU SELECT-SNUMDFAX-X
      *
           MOVE WK-VALUE       TO TS-NOME-CODA
           MOVE TS-NOME-CODA   TO DF1X-NOME-CODA
      *
           PERFORM PREPARA-TESTATA-JOB
              THRU PREPARA-TESTATA-JOB-X
      *
           PERFORM PREPARA-CODA-BONIF
              THRU PREPARA-CODA-BONIF-X
      *
           PERFORM PREPARA-CODA-JOB
              THRU PREPARA-CODA-JOB-X
      *
           PERFORM 060-START-TRANSID
              THRU 060-START-TRANSID
      *
           INITIALIZE DCLT-INF-DFAX
           MOVE FAX-NUM-PRA    TO DFAX-NUM-PRA
           STRING  'RICHIESTA BONIFICO INOLTRATA '
                        DIBSTAT
                        DELIMITED BY SIZE
                        INTO DFAX-ERRORE
           END-STRING
           IF  WK-FAX
           THEN
               MOVE WK-NUMFAX   TO DFAX-NUM-FAX
           END-IF
           IF  WK-MAIL
           THEN
               MOVE WK-INDMAIL  TO DFAX-DES-MAIL
           END-IF
           PERFORM 800-INSERT-TINFDFAX
              THRU 800-INSERT-TINFDFAX-X
           PERFORM 030-FINE THRU 030-FINE-X.
      *
      *----------------------------------------------------------------*
       PREPARA-BONIF-X.
           EXIT.
      *
       PREPARA-TESTATA-JOB.
      *----------------------------------------------------------------*
      *
           IF  K001-CICS-PROD
           THEN
               MOVE 'U'             TO RJ1-LETT
               MOVE 'PRODAOP'       TO RJ1-SCHENV
           ELSE
               MOVE 'P'             TO RJ1-LETT
               MOVE 'TESTAOP'       TO RJ1-SCHENV
           END-IF
      *
           MOVE WK-AGE              TO RJ1-AGE
           MOVE RIGA-JOB1           TO AREA-CODA
           PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X.
      *
           MOVE RIGA-JOB2           TO AREA-CODA
           PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X.
      *
           MOVE RIGA-JOB3           TO AREA-CODA
           PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X.
      *
           MOVE RIGA-JOB4           TO AREA-CODA
           PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X.
      *
      *----------------------------------------------------------------*
       PREPARA-TESTATA-JOB-X.
           EXIT.
      *
       PREPARA-CODA-ESITO.
      *----------------------------------------------------------------*
      *
           MOVE SPACE               TO AREA-CODA
           PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X
      *
      **** RIGA CON MODELLO
           MOVE SOCI-COD-FOB        TO SOC-ST.
           IF  WK-DRBE-OK
               MOVE 'FX04'          TO MODELLO-ST
           ELSE
               MOVE 'FX01'      TO MODELLO-ST
           END-IF
           MOVE RIGA-MODELLO        TO AREA-CODA
           PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X.

           EVALUATE TRUE
             WHEN  MODELLO-ST = 'FX04'
             WHEN  MODELLO-ST = 'FX01'
                   PERFORM PREPARA-ESITO-FX01-FX04
                      THRU PREPARA-ESITO-FX01-FX04
           END-EVALUATE.
      *
      *----------------------------------------------------------------*
       PREPARA-CODA-ESITO-X.
           EXIT.
      *
      *
       PREPARA-ESITO-FX01-FX04.
      *----------------------------------------------------------------*
      *
      **** DESTINATARIO - VDR
           MOVE WK-TITOLARE         TO RJI1-INSEGNA
           MOVE RJOB-INT1           TO AREA-CODA
           PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X.
      *
           MOVE WK-INDIR-VDR        TO RJI2-INDIR
           MOVE RJOB-INT2           TO AREA-CODA
           PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X.
      *
           MOVE WK-CAP-VDR          TO RJI3-CAP
           MOVE WK-CITTA-VDR        TO RJI3-CITTA
           MOVE RJOB-INT3           TO AREA-CODA
           PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X.
      *
           IF   WK-PRODOTTO = 'VEI'                                     SL090609
           AND (WK-FOVE NOT = SPACE)                                    SL090609
           THEN                                                         SL090609
                MOVE 'REF: '      TO RJI8-DESCR                         SL090609
                MOVE WK-FOVE      TO RJI8-FOVE                          SL090609
           ELSE                                                         SL090609
                MOVE SPACE        TO RJI8-DESCR                         SL090609
                                     RJI8-FOVE                          SL090609
           END-IF                                                       SL090609
           MOVE RJOB-INT8         TO AREA-CODA                          SL090609
           PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X                 SL090609
      *
           PERFORM VARYING IND FROM 1 BY 1
      *SL090609    UNTIL   IND > 6
                   UNTIL   IND > 5                                      SL090609
              MOVE SPACE               TO AREA-CODA
              PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X
           END-PERFORM
      *
      **** DATA E RICHIEDENTE
           MOVE WJJMMAAAADB2        TO RJE1-DATA
           MOVE WK-NOMCLI           TO RJE1-NOMCLI
           MOVE RJOB-ESITO1         TO AREA-CODA
           PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X.
      *
           MOVE SPACE               TO AREA-CODA
           PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X
      *
           MOVE SPACE               TO AREA-CODA
           PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X
      *
      **** NUMERO PRATICA
      **** IMPORTO FINANZIATO
           MOVE WK-NUMPRA           TO RJE2-PRATICA
      *
           IF  FAX-FLG-ESITO = 'S'
           THEN
               EVALUATE  WK-APP-RIF
               WHEN 'R'
                  MOVE 'RIFIUTATA'     TO RJE2-ESITO
               WHEN 'S'
                  MOVE 'SOSPESA  '     TO RJE2-ESITO
               WHEN 'A'
                  MOVE 'APPROVATA'     TO RJE2-ESITO
               WHEN OTHER
                  MOVE SPACE           TO RJE2-ESITO
               END-EVALUATE
           ELSE
               MOVE 'VEDI NOTE'        TO RJE2-ESITO
           END-IF
      *
           MOVE SPACE               TO RJE3-DESCR-IMP
           MOVE WK-IMPFIN           TO RJE3-IMPFIN
      *
           MOVE RJOB-ESITO2         TO AREA-CODA
           PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X.
      *
           MOVE SPACE               TO AREA-CODA
           PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X
      *
           MOVE SPACE               TO AREA-CODA
           PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X
      *
           IF  WK-MOD-PAG = 0
           THEN
               MOVE 'POSTA'         TO RJEA2-MOD-PAG
           ELSE
               MOVE 'BANCA'         TO RJEA2-MOD-PAG
           END-IF
           MOVE WK-PROROGA          TO RJEA2-PROROGA
           MOVE WK-SCAD(7:2)        TO RJEA2-SCAD
           MOVE RJOB-ESITA2         TO AREA-CODA
           PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X
      *
           MOVE SPACE               TO AREA-CODA
           PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X
      *
           MOVE RJOB-ESITO3         TO AREA-CODA
           PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X.
      *
           PERFORM VARYING IND FROM 1 BY 1
                   UNTIL   IND > 4
              MOVE SPACE               TO AREA-CODA
              PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X
           END-PERFORM.
      *
      *** RIGHE PER RATE (NO SE "RIFIUTATA")
           IF  WK-APP-RIF = 'R'
           OR  WK-APP-RIF = 'S'
           THEN
               PERFORM VARYING IND FROM 1 BY 1
                       UNTIL   IND > 9
                    MOVE SPACE               TO AREA-CODA
                    PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X
               END-PERFORM
           ELSE
             MOVE 1                      TO RJE4-PROG
             IF  CLASSICO
             THEN
      ************ MAXIRATA O NORMALE
               IF  WK-CODMAXI NOT = '9'
               THEN
      **** NO MAXIRATA
                   IF  WK-CODMAXI = SPACE OR LOW-VALUE
                                          OR '7'                        SL190412
                   THEN
                       MOVE WK-NUMDUR           TO RJE4-N-RATE-CL
                       MOVE WK-IMPMENS          TO RJE4-IMPRATA-CL
                       MOVE RJOB-ESITO4-CLASS   TO AREA-CODA
                       PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X
                       PERFORM VARYING IND FROM 1 BY 1
                               UNTIL   IND > 8
                          MOVE SPACE               TO AREA-CODA
                          PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X
                       END-PERFORM
                   END-IF
      **** MAXIRATA
                   IF  WK-CODMAXI NOT = SPACE AND LOW-VALUE
                                          AND '7'                       SL240412
                   THEN
                       COMPUTE WK-DUR-APP = WK-NUMDUR - 1
                       MOVE WK-DUR-APP          TO RJE4-N-RATE-MX1
                       MOVE WK-IMPMENS          TO RJE4-IMPRATA-MX1
      *                MOVE WK-IMPMAXI          TO RJE4-IMPRESI-MX1
                       MOVE RJOB-ESITO4-MAXR1   TO AREA-CODA
                       PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X

                       MOVE WK-IMPMAXI          TO RJE4-IMPRESI-MX1
                       MOVE RJOB-ESITO4-MAXR1-BIS TO AREA-CODA
                       PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X

                      IF  WK-CODMAXI = 'B'                              NO220715
                      OR  WK-CODMAXI = 'E'                              NO261115
                       MOVE SPACES              TO AREA-CODA            NO220715
                      ELSE                                              NO220715
                       MOVE TFXDUR              TO RJE4-N-RATE-MX2
                       MOVE TFXMENS             TO RJE4-IMPRATA-MX2
                       MOVE RJOB-ESITO4-MAXR2   TO AREA-CODA
                      END-IF                                            NO220715
                       PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X

                       PERFORM VARYING IND FROM 1 BY 1
                               UNTIL   IND > 6
                          MOVE SPACE               TO AREA-CODA
                          PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X
                       END-PERFORM
                   END-IF
               ELSE
      **********  RATA VARIABILE
                   INITIALIZE SW-RATAVAR
      *
                   MOVE WK-NUMPRA    TO SOTP-NUM-PRA
                   PERFORM OPEN-CURS02
                      THRU OPEN-CURS02-X
      *
                   PERFORM FETCH-CURS02
                      THRU FETCH-CURS02-X
      *
                   PERFORM UNTIL FINE-RATAVAR
                       MOVE SOTP-NUM-INIZ-MENS
                                           TO RJE4-RATA-DA
                       COMPUTE WK-DUR-APP = SOTP-NUM-INIZ-MENS +
                                            SOTP-NUM-MENS - 1
                       MOVE WK-DUR-APP     TO RJE4-RATA-A
                       MOVE SOTP-IMP-MENS  TO RJE4-IMPRATA
                       MOVE SPACE          TO RJE4-DESCR-MAXI
                       MOVE ZERO           TO RJE4-IMPMAXI
                       MOVE RJOB-ESITO4    TO AREA-CODA
                       PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X
      *
                       PERFORM FETCH-CURS02
                          THRU FETCH-CURS02-X
                       ADD 1               TO RJE4-PROG
                   END-PERFORM
      *
                   PERFORM CLOSE-CURS02
                      THRU CLOSE-CURS02-X
      *
                   PERFORM VARYING IND FROM RJE4-PROG BY 1
                           UNTIL   IND > 9
                        MOVE SPACE               TO AREA-CODA
                        PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X
                   END-PERFORM
               END-IF
             ELSE
               PERFORM VARYING IND FROM 1 BY 1
                       UNTIL   IND > 9
                    MOVE SPACE               TO AREA-CODA
                    PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X
               END-PERFORM
             END-IF
           END-IF.
      *
           PERFORM VARYING IND FROM 1 BY 1
                   UNTIL   IND > 4
                 MOVE SPACE               TO AREA-CODA
                 PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X
           END-PERFORM.
      *
      *** LE RIGHE PER LE CONDIZIONI ACCESSORIE
      *??????????????
      *
           PERFORM VARYING IND FROM 1 BY 1
      *            UNTIL   IND > 4                                      IS100615
                   UNTIL   IND > 8                                      IS100615
                 MOVE WK-ELE-TESTO(IND)   TO RJE5-MESSAGGIO
                 MOVE RJOB-ESITO5         TO AREA-CODA
                 PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X
           END-PERFORM.
      *
      *----------------------------------------------------------------*
       PREPARA-ESITO-FX01-FX04-X.
           EXIT.
      *
       PREPARA-CODA-BONIF.
      *----------------------------------------------------------------*
      *
           MOVE SPACE               TO AREA-CODA
           PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X
      *
      **** RIGA CON MODELLO
           MOVE SOCI-COD-FOB        TO SOC-ST.
           IF  WK-DRBE-OK
           THEN
               MOVE 'FX05'          TO MODELLO-ST
           ELSE
               IF  WK-VDRFIN = 1000025
                            OR 3365822                                  RD251111
               THEN
                   MOVE 'FX03'          TO MODELLO-ST
               ELSE
                   MOVE 'FX02'          TO MODELLO-ST
               END-IF
           END-IF
           MOVE RIGA-MODELLO        TO AREA-CODA
           PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X.

           EVALUATE TRUE
             WHEN  MODELLO-ST = 'FX05'
                   PERFORM PREPARA-BONIF-FX05
                      THRU PREPARA-BONIF-FX05-X
             WHEN  MODELLO-ST = 'FX03'
                   PERFORM PREPARA-BONIF-FX03
                      THRU PREPARA-BONIF-FX03-X
             WHEN  MODELLO-ST = 'FX02'
                   PERFORM PREPARA-BONIF-FX02
                      THRU PREPARA-BONIF-FX02-X
           END-EVALUATE.
      *
      *
      *----------------------------------------------------------------*
       PREPARA-CODA-BONIF-X.
           EXIT.
      *
       PREPARA-BONIF-FX05.
      *----------------------------------------------------------------*
      *
      **** DESTINATARIO - VDR
           MOVE WK-TITOLARE         TO RJI1-INSEGNA
           MOVE RJOB-INT1           TO AREA-CODA
           PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X.
      *
           MOVE WK-INDIR-VDR        TO RJI2-INDIR
           MOVE RJOB-INT2           TO AREA-CODA
           PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X.
      *
           MOVE WK-CAP-VDR          TO RJI3-CAP
           MOVE WK-CITTA-VDR        TO RJI3-CITTA
           MOVE RJOB-INT3           TO AREA-CODA
           PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X.
      *
           IF   WK-PRODOTTO = 'VEI'                                     SL090609
           AND (WK-FOVE NOT = SPACE)                                    SL090609
           THEN                                                         SL090609
                MOVE 'REF: '      TO RJI8-DESCR                         SL090609
                MOVE WK-FOVE      TO RJI8-FOVE                          SL090609
           ELSE                                                         SL090609
                MOVE SPACE        TO RJI8-DESCR                         SL090609
                                     RJI8-FOVE                          SL090609
           END-IF                                                       SL090609
           MOVE RJOB-INT8         TO AREA-CODA                          SL090609
           PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X                 SL090609
      *
           PERFORM VARYING IND FROM 1 BY 1
      *SL090609    UNTIL   IND > 9
                   UNTIL   IND > 8                                      SL090609
              MOVE SPACE               TO AREA-CODA
              PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X
           END-PERFORM
      *
      **** DATA E RICHIEDENTE
           MOVE WJJMMAAAADB2        TO RJE1-DATA
           MOVE WK-NOMCLI           TO RJE1-NOMCLI
           MOVE RJOB-ESITO1         TO AREA-CODA
           PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X.
      *
           MOVE SPACE               TO AREA-CODA
           PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X
      *
           MOVE SPACE               TO AREA-CODA
           PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X
      *
      **** INDIRIZZO CLIENTE
           MOVE WK-INDCLI    TO  RJB5-IND-CLI
           MOVE  RJOB-BONIF5        TO AREA-CODA
           PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X
      *
      **** CAP E CITTA' CLIENTE
           MOVE WK-CAPCLI    TO  RJB6-CAP-CLI
           MOVE WK-CITTACLI  TO  RJB6-CITTA-CLI
           MOVE  RJOB-BONIF6        TO AREA-CODA
           PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X
      *
      **** IBAN CLIENTE
           MOVE WK-IBAN      TO  RJB7-IBAN
           MOVE  RJOB-BONIF7        TO AREA-CODA
           PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X
      *
           MOVE SPACE               TO AREA-CODA
           PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X
      *
      **** NUMERO PRATICA
      **** IMPORTO EROGATO
           MOVE WK-NUMPRA           TO RJE2-PRATICA
           MOVE SPACE               TO RJE2-ESITO
           MOVE SPACE               TO RJE3-DESCR-IMP
           MOVE WK-IMPEROG          TO RJE3-IMPFIN
           MOVE 'IMPORTO EROGATO :           E'  TO RJE3-DESCR-IMP      FC260811
      *
           MOVE RJOB-ESITO2         TO AREA-CODA
           PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X.
      *
           MOVE SPACE               TO AREA-CODA
           PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X
      *
           MOVE SPACE               TO AREA-CODA
           PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X
      *
           MOVE RJOB-ESITO3         TO AREA-CODA
           PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X.
      *
           PERFORM VARYING IND FROM 1 BY 1
                   UNTIL   IND > 3
              MOVE SPACE               TO AREA-CODA
              PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X
           END-PERFORM.
      *
           MOVE WK-IMPFIN                      TO RJB1-IMPORTO
           MOVE RJOB-BONIF1     TO AREA-CODA
           PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X
      *
           MOVE SPACE           TO AREA-CODA
           PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X
      *
      *** SIP
           MOVE WK-IMSIP                           TO RJB1-IMPORTO
           MOVE RJOB-BONIF1         TO AREA-CODA
           PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X
      *
           MOVE SPACE           TO AREA-CODA
           PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X
      *
           PERFORM VARYING IND FROM 1 BY 1
                   UNTIL   IND > 7
              MOVE SPACE               TO AREA-CODA
              PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X
           END-PERFORM.
      *
      *----------------------------------------------------------------*
       PREPARA-BONIF-FX05-X.
           EXIT.
      *
       PREPARA-BONIF-FX03.
      *----------------------------------------------------------------*
      *
      **** DESTINATARIO - VDR
           MOVE WK-TITOLARE         TO RJI1-INSEGNA
           MOVE RJOB-INT1           TO AREA-CODA
           PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X.
      *
           MOVE WK-INDIR-VDR        TO RJI2-INDIR
           MOVE RJOB-INT2           TO AREA-CODA
           PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X.
      *
           MOVE WK-CAP-VDR          TO RJI3-CAP
           MOVE WK-CITTA-VDR        TO RJI3-CITTA
           MOVE RJOB-INT3           TO AREA-CODA
           PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X.
      *
           IF   WK-PRODOTTO = 'VEI'                                     SL090609
           AND (WK-FOVE NOT = SPACE)                                    SL090609
           THEN                                                         SL090609
                MOVE 'REF: '      TO RJI8-DESCR                         SL090609
                MOVE WK-FOVE      TO RJI8-FOVE                          SL090609
           ELSE                                                         SL090609
                MOVE SPACE        TO RJI8-DESCR                         SL090609
                                     RJI8-FOVE                          SL090609
           END-IF                                                       SL090609
           MOVE RJOB-INT8         TO AREA-CODA                          SL090609
           PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X                 SL090609
      *
           PERFORM VARYING IND FROM 1 BY 1
      *SL090609    UNTIL   IND > 9
                   UNTIL   IND > 8                                      SL090609
              MOVE SPACE               TO AREA-CODA
              PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X
           END-PERFORM
      *
      **** DATA E RICHIEDENTE
           MOVE WJJMMAAAADB2        TO RJE1-DATA
           MOVE WK-NOMCLI           TO RJE1-NOMCLI
           MOVE RJOB-ESITO1         TO AREA-CODA
           PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X.
      *
           MOVE SPACE               TO AREA-CODA
           PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X
      *
           MOVE SPACE               TO AREA-CODA
           PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X
      *
      **** NUMERO PRATICA
      **** IMPORTO EROGATO
           MOVE WK-NUMPRA           TO RJE2-PRATICA
           MOVE SPACE               TO RJE2-ESITO
           MOVE SPACE               TO RJE3-DESCR-IMP
           MOVE WK-IMPEROG          TO RJE3-IMPFIN
           MOVE 'IMPORTO EROGATO :           E'  TO RJE3-DESCR-IMP      FC260811
      *
           MOVE RJOB-ESITO2         TO AREA-CODA
           PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X.
      *
           MOVE SPACE               TO AREA-CODA
           PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X
      *
           MOVE SPACE               TO AREA-CODA
           PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X
      *
           MOVE RJOB-ESITO3         TO AREA-CODA
           PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X.
      *
           PERFORM VARYING IND FROM 1 BY 1
                   UNTIL   IND > 3
              MOVE SPACE               TO AREA-CODA
              PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X
           END-PERFORM.
      *
           MOVE WK-IMPFIN                      TO RJB1-IMPORTO
           MOVE RJOB-BONIF1     TO AREA-CODA
           PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X
      *
      *** INTERESSI VDR
           MOVE WK-INTVDR                      TO RJB1-IMPORTO
           MOVE RJOB-BONIF1     TO AREA-CODA
           PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X
      *
      *** SIP
           MOVE WK-IMSIP                           TO RJB1-IMPORTO
           MOVE RJOB-BONIF1         TO AREA-CODA
           PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X
      *
      *** ASSICURAZIONE
           MOVE WK-IMPASS                          TO RJB1-IMPORTO
           MOVE RJOB-BONIF1         TO AREA-CODA
           PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X
      *
           PERFORM VARYING IND FROM 1 BY 1
                   UNTIL   IND > 7
              MOVE SPACE               TO AREA-CODA
              PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X
           END-PERFORM.
      *
      *----------------------------------------------------------------*
       PREPARA-BONIF-FX03-X.
           EXIT.
      *
       PREPARA-BONIF-FX02.
      *----------------------------------------------------------------*
      *
      **** DESTINATARIO - VDR
           MOVE WK-TITOLARE         TO RJI1-INSEGNA
           MOVE RJOB-INT1           TO AREA-CODA
           PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X.
      *
           MOVE WK-INDIR-VDR        TO RJI2-INDIR
           MOVE RJOB-INT2           TO AREA-CODA
           PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X.
      *
           MOVE WK-CAP-VDR          TO RJI3-CAP
           MOVE WK-CITTA-VDR        TO RJI3-CITTA
           MOVE RJOB-INT3           TO AREA-CODA
           PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X.
      *
           IF   WK-PRODOTTO = 'VEI'                                     SL090609
           AND (WK-FOVE NOT = SPACE)                                    SL090609
           THEN                                                         SL090609
                MOVE 'REF: '      TO RJI8-DESCR                         SL090609
                MOVE WK-FOVE      TO RJI8-FOVE                          SL090609
           ELSE                                                         SL090609
                MOVE SPACE        TO RJI8-DESCR                         SL090609
                                     RJI8-FOVE                          SL090609
           END-IF                                                       SL090609
           MOVE RJOB-INT8         TO AREA-CODA                          SL090609
           PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X                 SL090609
      *
           PERFORM VARYING IND FROM 1 BY 1
      *SL090609    UNTIL   IND > 9
                   UNTIL   IND > 8                                      SL090609
              MOVE SPACE               TO AREA-CODA
              PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X
           END-PERFORM
      *
      **** DATA E RICHIEDENTE
           MOVE WJJMMAAAADB2        TO RJE1-DATA
           MOVE WK-NOMCLI           TO RJE1-NOMCLI
           MOVE RJOB-ESITO1         TO AREA-CODA
           PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X.
      *
           MOVE SPACE               TO AREA-CODA
           PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X
      *
           MOVE SPACE               TO AREA-CODA
           PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X
      *
      **** NUMERO PRATICA
      **** IMPORTO EROGATO
           MOVE WK-NUMPRA           TO RJE2-PRATICA
           MOVE SPACE               TO RJE2-ESITO
           MOVE SPACE               TO RJE3-DESCR-IMP
           MOVE WK-IMPEROG          TO RJE3-IMPFIN
           MOVE 'IMPORTO EROGATO :           E'  TO RJE3-DESCR-IMP      FC260811
      *
           MOVE RJOB-ESITO2         TO AREA-CODA
           PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X.
      *
           MOVE SPACE               TO AREA-CODA
           PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X
      *
           MOVE SPACE               TO AREA-CODA
           PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X
      *
           MOVE RJOB-ESITO3         TO AREA-CODA
           PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X.
      *
           PERFORM VARYING IND FROM 1 BY 1
                   UNTIL   IND > 3
              MOVE SPACE               TO AREA-CODA
              PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X
           END-PERFORM.
      *
           MOVE WK-IMPFIN                      TO RJB1-IMPORTO
           MOVE RJOB-BONIF1     TO AREA-CODA
           PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X
      *
      *** INTERESSI VDR
           MOVE WK-INTVDR                      TO RJB1-IMPORTO
           MOVE RJOB-BONIF1     TO AREA-CODA
           PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X
      *
      *** SIP
           MOVE WK-IMSIP                           TO RJB1-IMPORTO
           MOVE RJOB-BONIF1         TO AREA-CODA
           PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X
      *
      *** ASSICURAZIONE
           MOVE WK-IMPASS                          TO RJB1-IMPORTO
           MOVE RJOB-BONIF1         TO AREA-CODA
           PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X
      *
           PERFORM VARYING IND FROM 1 BY 1
                   UNTIL   IND > 4
              MOVE SPACE               TO AREA-CODA
              PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X
           END-PERFORM.
      *
      *** COORDINATE BANCARIE
           MOVE WK-CONTO                           TO RJB2-CONTO
           MOVE RJOB-BONIF2         TO AREA-CODA
           PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X
      *
           MOVE WK-ABI                             TO RJB3-ABI
           MOVE RJOB-BONIF3         TO AREA-CODA
           PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X
      *
           MOVE WK-CAB                             TO RJB4-CAB
           MOVE RJOB-BONIF4         TO AREA-CODA
           PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X.
      *
      *----------------------------------------------------------------*
       PREPARA-BONIF-FX02-X.
           EXIT.
      *
       PREPARA-CODA-JOB.
      *----------------------------------------------------------------*
           MOVE RIGA-JOB5           TO AREA-CODA
           PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X.
      *
      ***  RIGA  CON INDIRIZZO MAIL O FAX
           IF  WK-FAX

               INITIALIZE TAB-INDIRIZZO
               MOVE WK-GRAFFA-OP    TO ELE-TAB-IND(1)
               MOVE ''''            TO ELE-TAB-IND(2)
               MOVE 1               TO IND1
               MOVE 3   TO IND
               PERFORM VARYING IND1 FROM 1  BY 1
                       UNTIL IND1 > 12
                       OR    WK-NUMFAX(IND1:1) = SPACE
                           IF  WK-NUMFAX(IND1:1) NUMERIC
                           THEN
                             MOVE WK-NUMFAX(IND1:1)  TO ELE-TAB-IND(IND)
                             ADD 1    TO IND
                           END-IF
               END-PERFORM
               MOVE WK-CHIOCCIOLA       TO ELE-TAB-IND(IND)
               ADD 1                    TO IND
      *
               PERFORM VARYING I   FROM 1  BY 1
                       UNTIL I > 12
                           MOVE FAX-SERVER(I:1)  TO ELE-TAB-IND(IND)
                           ADD 1    TO IND
               END-PERFORM
      *
               IF  IND < 40
                   MOVE ''''            TO ELE-TAB-IND(IND)
                   ADD 1                TO IND
                   MOVE WK-GRAFFA-CL    TO ELE-TAB-IND(IND)
               END-IF
           END-IF
      *
           IF  WK-MAIL
               INITIALIZE  TAB-INDIRIZZO
               MOVE WK-GRAFFA-OP    TO ELE-TAB-IND(1)
               MOVE ''''            TO ELE-TAB-IND(2)
               MOVE 1               TO IND1
               PERFORM VARYING IND FROM 3  BY 1
                       UNTIL IND > 37
                       OR    WK-INDMAIL(IND1:1) = SPACE
                    IF  WK-INDMAIL(IND1:1)  = '§' OR '@'
                        MOVE WK-CHIOCCIOLA       TO ELE-TAB-IND(IND)
                    ELSE
                        MOVE WK-INDMAIL(IND1:1)  TO ELE-TAB-IND(IND)
                    END-IF
                    ADD 1    TO IND1
               END-PERFORM
      *
               IF  IND < 40
                   MOVE ''''            TO ELE-TAB-IND(IND)
                   ADD 1                TO IND
                   MOVE WK-GRAFFA-CL    TO ELE-TAB-IND(IND)
               END-IF
           END-IF
      *
           MOVE TAB-INDIRIZZO       TO RJ6-INDIRIZZO
           MOVE RIGA-JOB6           TO AREA-CODA
           PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X.
      *
      ***  RIGA  CON DESCRIZIONE MITTENTE
           MOVE SOCI-DESCRIZIONE    TO RJ7-NAME
           MOVE RIGA-JOB7           TO AREA-CODA
           PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X.
      *
      *
      ***  RIGA  CON NOME DEL FILE
      *****IF WK-PF10-OK
              MOVE '"ESITO"'        TO RJ9-FILE-NAME
      *****END-IF
      *****IF WK-PF11-OK
      *****   MOVE '"EROGAZIONE"'   TO RJ9-FILE-NAME
      *****END-IF
           MOVE RIGA-JOB9           TO AREA-CODA
           PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X.
      *
      ***  RIGA  DESCRIZIONE
           IF WK-MAIL
      *****   IF WK-PF10-OK
      *SL100913  MOVE '"ESITO DELLA RICHIESTA DI FINANZIAMENTO"'
      *SL100913                     TO RJ10-DESCR
                 STRING '"ESITO: ' CRLNOMP ' "'  DELIMITED BY SIZE      SL100913
                                  INTO RJ10-DESCR                       SL100913
      *****   END-IF
      *****   IF WK-PF11-OK
      *****      MOVE '"COMUNICAZIONE DI AVVENUTA EROGAZIONE"'
      *****                         TO RJ10-DESCR
      *****   END-IF
              MOVE RIGA-JOB10          TO AREA-CODA
              PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X
           END-IF
      *
           IF WK-FAX
               INITIALIZE TAB-INDIRIZZO
               MOVE ''''            TO ELE-TAB-IND(1)
               MOVE 1               TO IND1
               PERFORM VARYING IND FROM 2  BY 1
                       UNTIL IND > 40
                       OR    WK-NUMFAX(IND1:1) = SPACE
                    MOVE WK-NUMFAX(IND1:1)  TO ELE-TAB-IND(IND)
                    ADD 1    TO IND1
               END-PERFORM
      *
               IF  IND < 40
                   MOVE ''''            TO ELE-TAB-IND(IND)
               END-IF

              MOVE TAB-INDIRIZZO       TO RJ10-DESCR
              MOVE RIGA-JOB10          TO AREA-CODA
              PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X
           END-IF
      *
      ***  RIGA  DI CHIUSURA
           MOVE RIGA-JOB11          TO AREA-CODA
           PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X.
      *
           MOVE RIGA-JOB12          TO AREA-CODA
           PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X.
           MOVE RIGA-JOB13          TO AREA-CODA
           PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X.
           MOVE RIGA-JOB14          TO AREA-CODA
           PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X.
           MOVE RIGA-JOB15          TO AREA-CODA
           PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X.
           MOVE RIGA-JOB16          TO AREA-CODA
           PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X.
           MOVE RIGA-JOB17          TO AREA-CODA
           PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X.
           MOVE RIGA-JOB18          TO AREA-CODA
           PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X.
           MOVE RIGA-JOB19          TO AREA-CODA
           PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X.
           MOVE RIGA-JOB20          TO AREA-CODA
           PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X.
           MOVE RIGA-JOB21          TO AREA-CODA
           PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X.
           MOVE RIGA-JOB22          TO AREA-CODA
           PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X.
           MOVE RIGA-JOB23          TO AREA-CODA
           PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X.
           MOVE RIGA-JOB24          TO AREA-CODA
           PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X.
           MOVE RIGA-JOB25          TO AREA-CODA
           PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X.
           MOVE RIGA-JOB26          TO AREA-CODA
           PERFORM WRITE-TSCODA     THRU WRITE-TSCODA-X.
      *----------------------------------------------------------------*
       PREPARA-CODA-JOB-X.
           EXIT.
      *
       WRITE-TSCODA.
      *----------------------------------------------------------------*
      *
           ADD 1     TO ITEM-TS
      *
           EXEC CICS WRITEQ TS QUEUE  (TS-NOME-CODA)
                               FROM   (AREA-CODA)
                               LENGTH (LEN-TS)
                               ITEM   (ITEM-TS)
                               RESP   (K001-RESP)
           END-EXEC
      *
           IF   K001-RESP NOT = DFHRESP (NORMAL)
           THEN
                INITIALIZE DCLT-INF-DFAX
                MOVE FAX-NUM-PRA    TO DFAX-NUM-PRA
                STRING  'ERRORE WRITE TS  '
                        DELIMITED BY SIZE
                        INTO DFAX-ERRORE
                END-STRING
                PERFORM 800-INSERT-TINFDFAX
                   THRU 800-INSERT-TINFDFAX-X
                PERFORM 030-FINE THRU 030-FINE-X
           END-IF.
      *
      *----------------------------------------------------------------*
       WRITE-TSCODA-X.
           EXIT.
      *
       849-CALL-STORE-PROC.
      *----------------------------------------------------------------*
      *
           EXEC SQL
                CALL ROUTPROV (:RWP-PGM-CHIAM-INP
                              ,:RWP-FLG-CHIAM-INP
                              ,:RWP-COD-CAP-INP
                              ,:RWP-COD-PROV-INP
                              ,:RWP-DES-CAPOLUOGO-INP
                              ,:RWP-NUM-PROG-INP
                              ,:RWP-MSG-ESITO-OUT
                              ,:RWP-COD-CAP-OUT
                              ,:RWP-COD-PROV-OUT
                              ,:RWP-DES-CAPOLUOGO-OUT
                              ,:RWP-NUM-PROG-OUT
                              ,:RWP-SQLCODE
                              ,:RWP-SQLSTATE
                              ,:RWP-SQLERRMC-VAR)
           END-EXEC
      *
           MOVE SQLCODE TO W-ABD-SQLCODE
      *
           IF   NOT SQLCODE = ZERO
           THEN
                INITIALIZE DCLT-INF-DFAX
                MOVE FAX-NUM-PRA    TO DFAX-NUM-PRA
                STRING  'ERRORE ROUTPROV   '
                        W-ABD-SQLCODE
                        DELIMITED BY SIZE
                        INTO DFAX-ERRORE
                END-STRING
                PERFORM 800-INSERT-TINFDFAX
                   THRU 800-INSERT-TINFDFAX-X
                PERFORM 030-FINE THRU 030-FINE-X
           ELSE
                IF   RWP-MSG-ESITO-OUT NOT = SPACE
                THEN
                     IF   RWP-SQLCODE NOT = ZERO
                     THEN
                          INITIALIZE DCLT-INF-DFAX
                          MOVE FAX-NUM-PRA    TO DFAX-NUM-PRA
                          STRING  'ERRORE ROUTPROV 2  '
                                  RWP-MSG-ESITO-OUT
                                  DELIMITED BY SIZE
                                  INTO DFAX-ERRORE
                          END-STRING
                          PERFORM 800-INSERT-TINFDFAX
                             THRU 800-INSERT-TINFDFAX-X
                          PERFORM 030-FINE THRU 030-FINE-X
                     END-IF
                END-IF
           END-IF.
      *
      *----------------------------------------------------------------*
       849-CALL-STORE-PROC-X.
           EXIT.
      *
       CONTROLLO-INDIRIZZI.
      *----------------------------------------------------------------*
      *
           IF  WK-FAX
           THEN
               IF  WK-NUMFAX(1:7) = '0552701'  OR '0552703'
               THEN
                   CONTINUE
               ELSE
                   SET  INDIRIZZO-KO   TO TRUE
               END-IF
           END-IF
      *
           IF  WK-MAIL
           THEN
               PERFORM VARYING IND FROM 1  BY 1
                       UNTIL IND > 35
                       OR   (WK-INDMAIL(IND:1) = '§' OR '@')
               END-PERFORM
               IF  (WK-INDMAIL(IND:1) = '§' OR '@')
               THEN
                  ADD 1    TO IND
                  IF WK-INDMAIL(IND:15) = 'FINDOMESTIC.COM'
                  THEN
                     CONTINUE
                  ELSE
                     SET INDIRIZZO-KO   TO TRUE
                  END-IF
               END-IF
           END-IF.
      *----------------------------------------------------------------*
       CONTROLLO-INDIRIZZI-X.
           EXIT.
      *
       060-START-TRANSID.
      *----------------------------------------------------------------*
      *
           MOVE 'D05223A0'   TO DF1X-PGM-CHIAMANTE
           MOVE WK-CODCLI    TO DF1X-CODCLI
           MOVE WK-NUMPRA    TO DF1X-NUMPRA
           MOVE ITEM-TS      TO DF1X-MAX-ITEM
      *
           EXEC CICS START  TRANSID  (K001-T-05220)
                            FROM     (FAXC0002)
                            LENGTH   (LENGTH OF FAXC0002)
           END-EXEC.
      *
      *----------------------------------------------------------------*
       060-START-TRANSID-X.
           EXIT.

       CALCOLA-DLCORSERFIN.                                             SL241018
      *----------------------------------------------------------------*SL241018
           IF  DJASSIC = 'LR'                                           SL241018
           THEN                                                         SL241018
               PERFORM 803-CALCOLA-IMPORTI-LR                           SL241018
                  THRU 803-CALCOLA-IMPORTI-LR-X                         SL241018
           ELSE                                                         SL241018
               MOVE ZERO   TO WK-IMP-ASSIC-IF                           SL241018
                              WK-IMP-ASSIC-GAP-RDP                      SL241018
           END-IF                                                       SL241018
                                                                        SL241018
           PERFORM 802-SELECT-TCAMCAMP                                  SL241018
              THRU 802-SELECT-TCAMCAMP-X                                SL241018
                                                                        SL241018
           IF  CAMP-TIPO-CONTR OF DCLT-CAM-CAMP = 'F'                   SL241018
           THEN                                                         SL241018
               MOVE SOTC-CONTR OF DCLT-SOTT-CAMP   TO DLCORSERFIN       SL241018
           ELSE                                                         SL241018
      *                                                                 SL241018
      *  INTERESSI VENDITORE X PERCENTUALE                              SL241018
      *                                                                 SL241018
               COMPUTE DLCORSERFIN = PRAT-IMP-INT-VDR  *                SL241018
                                 SOTC-CONTR OF DCLT-SOTT-CAMP / 100     SL241018
      *                                                                 SL241018
               IF  DLCORSERFIN < ZERO                                   SL241018
               THEN                                                     SL241018
                   MOVE ZERO     TO DLCORSERFIN                         SL241018
               END-IF                                                   SL241018
           END-IF.                                                      SL241018
      *----------------------------------------------------------------*SL241018
       CALCOLA-DLCORSERFIN-X.                                           SL241018
           EXIT.                                                        SL241018
                                                                        SL241018
       802-SELECT-TCAMCAMP.                                             SL241018
      *---------------------------------------------------------------- SL241018
      *                                                                 SL241018
           MOVE DJCSTE        TO CAMP-CODSOC  OF DCLT-CAM-CAMP          SL241018
           MOVE DJIDEN        TO CAMP-CODCAMP OF DCLT-CAM-CAMP          SL241018
                                 W-MSG-COD-CAMP                         SL241018
      *                                                                 SL241018
           MOVE DJBMENS       TO WK-DUR1.                               SL241018
           MOVE DJMDECO       TO WK-DECOU.                              SL241018
      *                                                                 SL241018
           COMPUTE WK-DECOU =  WK-DECOU - WK-IMP-ASSIC-IF               SL241018
                                        - WK-IMP-ASSIC-GAP-RDP          SL241018
      *                                                                 SL241018
           MOVE DJCGRAT       TO SOTC-CODGRAT OF DCLT-SOTT-CAMP         SL241018
           MOVE DLRIPORTI     TO SOTC-PROROGA OF DCLT-SOTT-CAMP         SL241018
      *                                                                 SL241018
           EXEC SQL                                                     SL241018
           SELECT CAMP_CODSOC                                           SL241018
                 ,CAMP_CODCAMP                                          SL241018
                 ,CAMP_TIPO_CONTR                                       SL241018
                 ,CAMP_FLG_MAXI                                         SL241018
                 ,SOTC_CONTR                                            SL241018
                 ,SOTC_MOD_RIP                                          SL241018
                 ,SOTC_PARTECOS                                         SL241018
           INTO   :DCLT-CAM-CAMP.CAMP-CODSOC                            SL241018
                 ,:DCLT-CAM-CAMP.CAMP-CODCAMP                           SL241018
                 ,:DCLT-CAM-CAMP.CAMP-TIPO-CONTR                        SL241018
                 ,:DCLT-CAM-CAMP.CAMP-FLG-MAXI                          SL241018
                 ,:DCLT-SOTT-CAMP.SOTC-CONTR                            SL241018
                 ,:DCLT-SOTT-CAMP.SOTC-MOD-RIP                          SL241018
                 ,:DCLT-SOTT-CAMP.SOTC-PARTECOS                         SL241018
           FROM T_CAM_CAMP,T_CAM_SOTC                                   SL241018
           WHERE CAMP_CODSOC  = :DCLT-CAM-CAMP.CAMP-CODSOC              SL241018
             AND CAMP_CODCAMP = :DCLT-CAM-CAMP.CAMP-CODCAMP             SL241018
             AND SOTC_CODSOC  = :DCLT-CAM-CAMP.CAMP-CODSOC              SL241018
             AND SOTC_CODCAMP = :DCLT-CAM-CAMP.CAMP-CODCAMP             SL241018
             AND SOTC_PROROGA = :DCLT-SOTT-CAMP.SOTC-PROROGA            SL241018
             AND SOTC_CODGRAT = :DCLT-SOTT-CAMP.SOTC-CODGRAT            SL241018
             AND SOTC_DADUR  <= :WK-DUR1                                SL241018
             AND SOTC_ADUR   >= :WK-DUR1                                SL241018
             AND SOTC_IMPMIN <= :WK-DECOU                               SL241018
             AND SOTC_IMPMAX >= :WK-DECOU                               SL241018
           END-EXEC.                                                    SL241018
      *                                                                 SL241018
           MOVE SQLCODE TO DB2-RETURN W-ABD-SQLCODE                     SL241018
      *                                                                 SL241018
           IF   NOT OK-ON-REC                                           SL241018
           THEN                                                         SL241018
                INITIALIZE DCLT-INF-DFAX                                SL241018
                MOVE FAX-NUM-PRA    TO DFAX-NUM-PRA                     SL241018
                STRING  'ERRORE SELECT T_cAM_CAMP'                      SL241018
                        W-ABD-SQLCODE                                   SL241018
                        DELIMITED BY SIZE                               SL241018
                        INTO DFAX-ERRORE                                SL241018
                END-STRING                                              SL241018
                PERFORM 800-INSERT-TINFDFAX                             SL241018
                   THRU 800-INSERT-TINFDFAX-X                           SL241018
                PERFORM 030-FINE THRU 030-FINE-X                        SL241018
           END-IF.                                                      SL241018
      *                                                                 SL241018
      *---------------------------------------------------------------- SL241018
       802-SELECT-TCAMCAMP-X.                                           SL241018
           EXIT.                                                        SL241018
                                                                        SL241018
       803-CALCOLA-IMPORTI-LR.                                          SL241018
      *---------------------------------------------------------------- SL241018
      *                                                                 SL241018
           MOVE DJNDOS   TO DGL1-NUM-PRA                                SL241018
                            W-MSG-DGL1-PRA                              SL241018
           MOVE DJCSTE   TO DGL1-COD-SOC                                AR311219
      *                                                                 SL241018
           EXEC SQL                                                     SL241018
           SELECT VALUE(SUM(DGL1_IMPORTO),0)                            SL241018
           INTO   :WK-IMP-ASSIC-IF                                      SL241018
           FROM T_INF_DGL1,T_INF_ASSIC, T_INF_DESC                      SL241018
                WHERE DGL1_NUM_PRA  = :DGL1-NUM-PRA                     SL241018
                AND   DGL1_COD_ASS  = ASSIC_COD_ASS                     SL241018
                AND   DGL1_COD_SOC  = ASSIC_COD_SOC                     SL241018
                AND   ASSIC_TIP_ASS = DESC_TIP_ASS                      SL241018
                AND   DGL1_COD_SOC  = :DGL1-COD-SOC                     AR311219
                AND   ASSIC_COD_PROD <> 'PRO'                           SL241018
                AND   DESC_FLG_TIPO = 'C'                               SL241018
           END-EXEC.                                                    SL241018
      *                                                                 SL241018
           MOVE SQLCODE TO DB2-RETURN W-ABD-SQLCODE                     SL241018
      *                                                                 SL241018
           IF   NOT OK-ON-REC                                           SL241018
           THEN                                                         SL241018
                INITIALIZE DCLT-INF-DFAX                                SL241018
                MOVE FAX-NUM-PRA    TO DFAX-NUM-PRA                     SL241018
                STRING  'ERRORE SELECT T_INF_DGL1'                      SL241018
                        W-ABD-SQLCODE                                   SL241018
                        DELIMITED BY SIZE                               SL241018
                        INTO DFAX-ERRORE                                SL241018
                END-STRING                                              SL241018
                PERFORM 800-INSERT-TINFDFAX                             SL241018
                   THRU 800-INSERT-TINFDFAX-X                           SL241018
                PERFORM 030-FINE THRU 030-FINE-X                        SL241018
           END-IF.                                                      SL241018
      *                                                                 SL241018
           EXEC SQL                                                     SL241018
           SELECT VALUE(SUM(DGL1_IMPORTO),0)                            SL241018
           INTO   :WK-IMP-ASSIC-GAP-RDP                                 SL241018
           FROM T_INF_DGL1,T_INF_ASSIC                                  SL241018
                WHERE DGL1_NUM_PRA  = :DGL1-NUM-PRA                     SL241018
                AND   DGL1_COD_ASS  = ASSIC_COD_ASS                     SL241018
                AND   DGL1_COD_SOC  = ASSIC_COD_SOC                     SL241018
                AND   DGL1_COD_SOC  = :DGL1-COD-SOC                     AR311219
                AND   ASSIC_TIP_ASS IN ('GAP' , 'RDP' )                 SL241018
                AND   ASSIC_COD_PROD <> 'PRO'                           SL241018
           END-EXEC                                                     SL241018
      *                                                                 SL241018
           MOVE SQLCODE TO DB2-RETURN W-ABD-SQLCODE                     SL241018
      *                                                                 SL241018
           IF   NOT OK-ON-REC                                           SL241018
           THEN                                                         SL241018
                INITIALIZE DCLT-INF-DFAX                                SL241018
                MOVE FAX-NUM-PRA    TO DFAX-NUM-PRA                     SL241018
                STRING  'ERRORE SELECT T_INF_DGL1-2'                    SL241018
                        W-ABD-SQLCODE                                   SL241018
                        DELIMITED BY SIZE                               SL241018
                        INTO DFAX-ERRORE                                SL241018
                END-STRING                                              SL241018
                PERFORM 800-INSERT-TINFDFAX                             SL241018
                   THRU 800-INSERT-TINFDFAX-X                           SL241018
                PERFORM 030-FINE THRU 030-FINE-X                        SL241018
           END-IF.                                                      SL241018
      *                                                                 SL241018
      *----------------------------------------------------------------*SL241018
       803-CALCOLA-IMPORTI-LR-X.                                        SL241018
           EXIT.                                                        SL241018
      *                                                                 SL241018
      *
      ******************************************************************
      * COPY ESEGUIBILI
      ******************************************************************
      *
      *    TASTO ERRATO
           COPY VARIP963.
      *    IDENTIFICAZIONE PRATICA CL/CP
      *    COPY VARIX967.                                               RP161018
           COPY VARIP967.                                               RP161018
      *    CONTROLLO CAMPO NUMERICO
           COPY VARIP968.
      *    CONTROLLO CARATTERI
           COPY CTRCARAP.

      *
      ************************* EOM D05223A0 ***************************
