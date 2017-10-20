 
 /*------------------------------------------------------------------------
    File        : bePatient
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : demo
    Created     : Tue Oct 17 11:38:23 EEST 2017
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS bePatient: 
    DEFINE PRIVATE VARIABLE rdaPatient AS CLASS daPatient NO-UNDO.
    
    CONSTRUCTOR PUBLIC bePatient ( ):
        ASSIGN 
           /* Create an instance of the objects */ 
            rdaPatient = NEW daPatient ( ).
    END CONSTRUCTOR.
    
    METHOD PUBLIC VOID bePatientRun ():
        rdaPatient:FetchData().
        
        IF rdaPatient:FindFirst() = TRUE THEN
            rdaPatient:StoreData().
        ELSE MESSAGE "Not available"
             VIEW-AS ALERT-BOX.
    END METHOD.
    
    METHOD PUBLIC INTEGER beBloodType(INPUT beParam AS CHARACTER):
        RETURN rdaPatient:daBloodType(beParam).
    END METHOD.
END CLASS.