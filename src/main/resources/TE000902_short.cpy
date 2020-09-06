000001 01 TE000902.

000001    05 TE000902-HEADER.
000283       10 TE000902-CCINIB          PIC 9(002).                            
      *           cin iban
000285       10 TE000902-FABLCB          PIC X.                                 
      *           flag abilitazione cbi                                         
000285       10 TE000902-FLGMBC          PIC X.                                 
      *           flag multibanca                                               
000286       10                          PIC X(262).
                                                                                
000549    05 TE000902-BPFLIN.                                                   
      *           tabella programmi per produzione flussi informativi           
000549       10 TE000902-NEBLIN          PIC 9(004) COMP.                       
      *           numero elementi tabella                                       
000551       10 TE000902-YEBFIN   OCCURS 0 TO 500                               
                                         DEPENDING ON TE000902-NEBLIN.          
000551          15 TE000902-YPPFIF       PIC X(008).                            
      *           programma produzione flusso informativo                       
000559          15 TE000902-FTIPFL       PIC X(001).                            
      *           flag tipo flusso                                              
                                                                                
