      *#COMMAREA PROCEDURA ANAGRAFE GENERALE
      *****************************************************************
      *              C O P Y     A N 0 0 0 2 3 3
      *****************************************************************
      * TRACCIATO COMMAREA PROGRAMMI
      *
      * PROCEDURA :  ANAGRAFE GENERALE ( RICERCA ANAGRAFICA     - AN1 )
      *
      * LUNGHEZZA AREA             : +6600
      *    DI CUI PARTE COMUNE     : +0200
      *    DI CUI PARTE VARIABILE  : +6400
      *****************************************************************
      *
         05  AN0233-STEPEL                     PIC  9(01).
         05  AN0233-NRPAG1                     PIC  9(05).
         05  AN0233-NRPAG2                     PIC  9(05).
         05  AN0233-NRPAG3                     PIC  9(05).
         05  AN0233-FIRITE                     PIC  9(04).
         05  AN0233-NRIT01                     PIC  9(05).
         05  AN0233-NRIT02                     PIC  9(05).
         05  AN0233-NRIT03                     PIC  9(05).
         05  AN0233-NRIT04                     PIC  9(05).
         05  AN0233-NRIT05                     PIC  9(05).
         05  AN0233-CODA01                     PIC  X(08).
         05  AN0233-CODA02                     PIC  X(08).
         05  AN0233-CODA03                     PIC  X(08).
         05  AN0233-CODA04                     PIC  X(08).
         05  AN0233-CODA05                     PIC  X(08).
         05  AN0233-ERRORE                     PIC  X(01).
         05  AN0233-NRSEOK                     PIC  9(02).
         05  AN0233-NRSEER                     PIC  9(02).
         05  AN0233-NRITSE                     PIC  9(05).
         05  AN0233-TRAATT                     PIC  X(04).
         05  AN0233-CDFUNZ                     PIC  X(01).
         05  AN0233-FVARIA                     PIC  X(01).
         05  AN0233-CHIAMA                     PIC  X(08).
         05  AN0233-FIRDET                     PIC  9(05).
         05  AN0233-LASDET                     PIC  9(05).
         05  AN0233-FIRPAG                     PIC  9(05).
         05  AN0233-PAGSD                      PIC  9(01).

         05  AN0233-MPCONF                     PIC  X(01).
         05  AN0233-MAPSEL                     PIC  9(02).
         05  AN0233-TIPSEL                     PIC  X(01).
         05  AN0233-TIPRIC                     PIC  9(03).
         05  AN0233-NDG-NOTAUTH                PIC  X(01).
         05  AN0233-NDG-ONBOARDING             PIC  X(01).

   05  FILLER                            PIC  X(86).


       05  AN0233-AREAEL.
             10  TAB-RIGA.
                 15  AN0233-MAPRIG  OCCURS 17.
                     20  AN0233-MPSEL          PIC  X(01).
                     20  AN0233-MPRIGA         PIC  X(79).
                     20  AN0233-NRITEM         PIC  9(04).
             10 FILLER                         PIC  X(72).

      05  AN0233-MAP024.
             10  AN0233-MPCOGN                 PIC  X(40).
             10  AN0233-SWCOGN                 PIC  X(01).
             10  AN0233-MPNOME                 PIC  X(40).
             10  AN0233-SWNOME                 PIC  X(01).
             10  AN0233-MPNNCG                 PIC  X(03).
             10  AN0233-SWNNCG                 PIC  X(01).
             10  AN0233-MPCOIN                 PIC  9(03).
             10  AN0233-MPDATA.
                 15  AN0233-MPDAGG             PIC  9(02).
                 15  AN0233-MPDAMM             PIC  9(02).
                 15  AN0233-MPDAAA             PIC  9(04).
             10  AN0233-MPPROV                 PIC  X(02).
             10  AN0233-MPCOMU                 PIC  X(30).
             10  AN0233-TAB-CHIAVI.
                 15 AN0233-EL-CHIAVE OCCURS 6.
                    20 AN0233-EL-CDDATO        PIC  9(05).
                    20 AN0233-EL-LAYOUT        PIC  X(30).
                    20 AN0233-EL-DATO          PIC  X(20).
             10  AN0233-MPNDG                  PIC  9(12).
             10  AN0233-RAPPORTO.
                 15 AN0233-MPSIT               PIC  X(01).
                 15 AN0233-MPSER               PIC  X(02).
                 15 AN0233-MPDIP               PIC  X(03).
                 15 AN0233-MPNUM               PIC  X(08).
             10  AN0233-KEYCOD                 PIC  X(01).
             10  AN0233-NUMF                   PIC  9(04).
             10  AN0233-NUMS                   PIC  9(04).
             10  AN0233-FLRICM                 PIC  X(01).
             10  AN0233-MPKEYAN                PIC  X(01).
             10  FILLER                        PIC  X(04).

       05  AN0233-MAP026.
             10  AN0233-MPPROG                 PIC  9(03).
             10  AN0233-MPCMDT                 PIC  X(03).
             10  FILLER                        PIC  X(94).

       05  AN0233-MAP024-2.
            10 AN0233-TAB-CHIAVI2.
               15 AN0233-EL-FORMIN   OCCURS 6  PIC  X(01) VALUE 'A'.
            10 AN0233-SWFORM                   PIC  X(01).
            10 AN0233-TAB-DENOM.
               15 AN0233-EL-DENOM OCCURS 8.
                  20 AN0233-TABCOGN            PIC  X(40).
                  20 AN0233-SWTABCOGN          PIC  X(01).
                  20 AN0233-TABNOME            PIC  X(40).
                  20 AN0233-SWTABNOME          PIC  X(01).
            10  AN0233-MPCDFIS                 PIC  X(16).
            10  AN0233-SWCDFIS                 PIC  X(01).
            10  FILLER                         PIC  X(36).
            10  AN0233-MPGERA                  PIC  9(08).
            10  AN0233-GESTORI                 PIC  X(01).
            10  FILLER                         PIC  X(05).
            10 AN0233-TAB-CHIAVI3.
               15 AN0233-EL-CHIAVI3  OCCURS 6.
                  20 AN0233-EL-LUNGH           PIC  9(05).
                  20 AN0233-EL-MINUS           PIC  X(01).
                  20 AN0233-EL-LUNGDE          PIC  9(03).
      10 AN0233-HOLDING                  PIC  X(01).
      10 AN0233-POLO                     PIC  X(01).
      10 AN0233-PEP                      PIC  X(01).
      10 AN0233-NS                       PIC  X(01).
      10 AN0233-CALCOLA-PESO-NEG         PIC  X(01).
      10 AN0233-SOPRA-SOGLIA-NEG         PIC  X(01).
      10 AN0233-SOLO-NEG                 PIC  X(01).
      10 AN0233-DATI-PESO.
         15 AN0233-PESO-DTNAS            PIC  9(08).
         15 AN0233-PESO-CAB-NAS          PIC  9(09).
         15 AN0233-PESO-PROV-NAS         PIC  X(02).
         15 AN0233-PESO-COMU-NAS         PIC  X(30).
         15 AN0233-PESO-CODFIS           PIC  X(16).
         15 AN0233-PESO-SESSO            PIC  X(01).
         15 FILLER                       PIC  X(20).
      10 AN0233-DA-BONIF                 PIC  X(01).

   05  FILLER                            PIC  X(3750).