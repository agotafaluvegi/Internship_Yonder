 
 /*------------------------------------------------------------------------
    File        : beBloodBank
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : demo
    Created     : Tue Oct 17 11:37:45 EEST 2017
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS beBloodBank: 
    DEFINE PRIVATE VARIABLE rdaBloodBank AS CLASS daBloodBank NO-UNDO.
    
    CONSTRUCTOR PUBLIC beBloodBank ( ):
        ASSIGN 
           /* Create an instance of the objects */ 
            rdaBloodBank = NEW daBloodBank ( ).
    END CONSTRUCTOR.
    
    METHOD PUBLIC VOID beBloodBankRun ():
        rdaBloodBank:FetchData().
        
        IF rdaBloodBank:FindFirst() = TRUE THEN
            rdaBloodBank:StoreData().
        ELSE MESSAGE "Not available"
             VIEW-AS ALERT-BOX.
    END METHOD.
END CLASS.