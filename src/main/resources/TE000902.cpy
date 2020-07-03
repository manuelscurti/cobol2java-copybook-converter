                                                                                
      *                         ****************                                
      *                         *              *                                
      *                         *   TE000902   *                                
      *                         *              *                                
      *                         ****************                                
                                                                                
      *# ARCHIVIO INFORMAZIONI DEL CONTRATTO                                    
      *# AD USO PROCEDURA INFORMATIVA                                           
                                                                                
000001 01 TE000902.                                                             
                                                                                
000001    05 TE000902-HEADER.                                                   
000001       10 TE000902-CODIST          PIC X(002).                            
      *           codice istituto                                               
000003       10 TE000902-CODKTR          PIC X(013).                            
      *           codice contratto                                              
000016       10 TE000902-CODSIA          PIC X(005).                            
      *           codice sia                                                    
000021       10 TE000902-CODRAP          PIC X(013).                            
      *           codice rapporto                                               
000034       10 TE000902-CODCNL          PIC X(004).                            
      *           codice canale                                                 
000038       10 TE000902-CODABI          PIC X(005).                            
      *           codice abi                                                    
000043       10 TE000902-YNDGCL          PIC X(012).                            
      *           ndg cliente                                                   
000055       10 TE000902-DFIRKR          PIC X(008).                            
      *           data firma contratto                                          
000063       10 TE000902-DCHIKR          PIC X(008).                            
      *           data chiusura contratto                                       
000071       10 TE000902-YCTRAL          PIC X(005).                            
      *           codice centro applicativo                                     
000076       10 TE000902-CBCALE          PIC X(005).                            
      *           codice banca leader                                           
000081       10 TE000902-YITSCL          PIC X(040).                            
      *           descrizione cliente                                           
000121       10 TE000902-CODPTZ          PIC X(005).                            
      *           codice postazione                                             
000126       10 TE000902-CKTRPR          PIC X(013).                            
      *           contratto principale                                          
000139       10 TE000902-CODAID          PIC X(006).                            
      *           codice aid quercia                                            
000145       10 TE000902-FABLCF          PIC X(001).                            
      *           flag abilitazione crittografia quercia                        
000146       10 TE000902-YKEYCF          PIC X(008).                            
      *           chiave crittografia quercia                                   
000154       10 TE000902-CABIQU          PIC X(005).                            
      *           codice abi quercia                                            
000159       10 TE000902-TCUTML          PIC X(001).                            
      *           tipo codice utente multitel                                   
000160       10 TE000902-CPTZR8          PIC X(004).                            
      *           codice rb8 multitel                                           
000164       10 TE000902-CPTZR2          PIC X(008).                            
      *           codice rb2000 multitel                                        
000172       10 TE000902-CALSR2          PIC X(030).                            
      *           codice alias rb2000 multitel                                  
000202       10 TE000902-CODCTG          PIC X(004).                            
      *           categoria del contratto                                       
000206       10 TE000902-CODSTG          PIC X(004).                            
      *           sottocategoria del contratto                                  
000210       10 TE000902-EBTPDI          PIC X(003).                            
      *           tipo contratto                                                
000213       10 TE000902-CODCAB          PIC X(005).                            
      *           codice cab                                                    
000218       10 TE000902-YCONCT          PIC X(012).                            
      *           codice conto                                                  
000230       10 TE000902-CCINAB          PIC X(001).                            
      *           cin bban                                                      
000231       10 TE000902-CODDIV          PIC X(001).                            
      *           bytleu                                                        
000232       10 TE000902-CDIVIS          PIC X(003).                            
      *           divisa                                                        
000235       10 TE000902-CISTLE          PIC X(002).                            
      *           codice istituto banca leader                                  
000237       10 TE000902-CODLIN          PIC X(001).                            
      *           codice lingua                                                 
000238       10 TE000902-CPAVEF          PIC X(012).                            
      *           codice postazione per avvisatura effetti                      
000250       10 TE000902-YISEML          PIC X(016).                            
      *           identificativo setif multitel                                 
000266       10 TE000902-CODPDT          PIC X(008).                            
      *           codice prodotto                                               
000274       10 TE000902-CCNLCB          PIC X(002).                            
      *           canale cbi bpel                                               
000276       10 TE000902-CSIAPR          PIC X(005).                            
      *           codice sia principale bpel                                    
000281       10 TE000902-CODPAE          PIC X(002).                            
      *           codice paese                                                  
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