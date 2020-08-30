                                                                        00000010
                                                                        00000020
                                                                        00000030
      *                         ****************                        00000040
      *                         *              *                        00000050
      *                         *   AN006012   *                        00000060
      *                         *              *                        00000070
      *                         ****************                        00000080
                                                                        00000090
                                                                        00000100
                                                                        00000110
      * NOMECOPY............: AN006012                                  00000120
      * BIBLIOTECA..........: ANR                                       00000130
      * SESSIONE............: 4686                                      00000140
      * TIPO-SESSIONE.......: Z                                         00000150
      * DATA GENERAZIONE....: 17/03/98                                  00000160
      * ORA GENERAZIONE.....: 11:48:26.84                               00000170
      * SEGMENTI............: AN9S                                      00000180
      * ....................:                                           00000190
      * ....................:                                           00000200
      * ....................:                                           00000210
      * ....................:                                           00000220
      * ....................:                                           00000230
      * ....................:                                           00000240
      * ....................:                                           00000250
      * ....................:                                           00000260
      * ....................:                                           00000270
      * OPZIONI GENERAZIONE.: 2S                                        00000280
                                                                        00000290
                                                                        00000300
                                                                        00000310
      *#IL TRACCIATO DELLA TABELLA 012 CORRISPONDE ALLA COPY AN006012   00000320
      *#                                                                00000330
      *#TABELLA DEGLI NNCG CON RELATIVE DESCRIZIONI.                    00000340
       01  AN6012-REC.                                                  00000350
000001     05 AN6012-CHIAVE.                                            00000360
      *           CHIAVE                                                00000370
      *           Livello superiore della parte contenente la chiave.   00000380
040001      06 AN6012-PROCED                     PIC X(004).            00000390
      *           CODICE PROCEDURA                                      00000400
030005      06 AN6012-TABELLA                    PIC X(003).            00000410
      *           CODICE TABELLA                                        00000420
040008      06 AN6012-CDPOLO                     PIC X(004).            00000430
      *           CODICE POLO                                           00000440
020012      06 AN6012-CDISTC                     PIC S9(003)     COMP-3.00000450
      *           CODICE ISTITUTO CEDACRI                               00000460
060014      06 AN6012-CDISTI                     PIC X(006).            00000470
      *           CODICE ABI                                            00000480
000020      06 AN6012-KTABELLA.                                         00000490
      *           KTABELLA                                              00000500
      *           Livello superiore della chiave della tabella.         00000510
030020       07 AN6012-NNCG                      PIC X(003).            00000520
      *           Natura nominativo + codice giuridico                  00000530
420023       07 FILLER                           PIC X(042).            00000540
010065      06 AN6012-FSEGUI                     PIC X(001).            00000550
      *           FLAG SEGUITO                                          00000560
000066     05 AN6012-DATI.                                              00000570
      *           DATI                                                  00000580
      *           Livello superiore parte dati della tabella.           00000590
600066      06 AN6012-DESCR-NNCG                 PIC X(060).            00000600
      *           DESCRIZIONE NATURA NOMINATIVO CODICE GIURIDICO        00000610
600066      06 AN6012-SOC-DI-CAPITALE            PIC X(001).            00000611
      *           SOCIETA' DI CAPITALE                                  00000612
030072      06 AN6012-PROG-ZEB                   PIC 9(003).            00000613
      *        PROGRESSIVO PER PROCEDURA ZEB                            00000614
000126      06 FILLER                            PIC X(190).            00000620
080320     05 AN6012-DATA                        PIC X(008).            00000630
      *           Data ultimo aggiornamento.                            00000640
080328     05 AN6012-UTEAGG                      PIC X(008).            00000650
      *           Utente ultimo aggiornamento.                          00000660
                                                                        00000670
                                                                        00000680
                                                                        00000690
      * CODICE DI CONTROLLO.: 19831286                                  00000700
