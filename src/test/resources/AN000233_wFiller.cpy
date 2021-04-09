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