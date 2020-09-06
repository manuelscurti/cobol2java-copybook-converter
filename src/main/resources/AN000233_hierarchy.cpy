         05  AN0233-NDG-ONBOARDING             PIC  X(01).

   05  FILLER                            PIC  X(86).


       05  AN0233-AREAEL.
             10  TAB-RIGA.
                 15  AN0233-MAPRIG  OCCURS 17.
                     20  AN0233-MPSEL          PIC  X(01) VALUE '0'.
                     20  AN0233-MPRIGA         PIC  X(79).
                     20  AN0233-NRITEM         PIC  9(04) VALUE 5.
             10 FILLER                         PIC  X(72).