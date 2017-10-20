 
 /*------------------------------------------------------------------------
    File        : daPatient
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : demo
    Created     : Tue Oct 17 11:37:01 EEST 2017
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS daPatient INHERITS daGeneric:
    {dsPatient.i} 
    
    DEFINE DATA-SOURCE dsPatient FOR Patient.
    DEFINE PRIVATE VARIABLE rGeneric AS CLASS daGeneric NO-UNDO.
    
    CONSTRUCTOR PUBLIC daPatient ( ):
        BUFFER ttPatient:ATTACH-DATA-SOURCE(DATA-SOURCE dsPatient:HANDLE,?,?).
        rGeneric = NEW daGeneric ( ).         
    END CONSTRUCTOR. 
        
    
    METHOD PUBLIC VOID FetchData ():        
        DEFINE VARIABLE hdsPatient AS HANDLE NO-UNDO.
        hdsPatient = DATASET dPatient:HANDLE.
        
        rGeneric:FetchData(hdsPatient, "ttPatient,WHERE ttPatient.ID < 6"). 
    END METHOD.
    
    METHOD PUBLIC LOGICAL FindFirst():
        FIND FIRST ttPatient WHERE ttPatient.ID = 3 NO-LOCK NO-ERROR.
        IF AVAILABLE ttPatient THEN
            RETURN TRUE.
        ELSE RETURN FALSE.
    END METHOD.
    
    METHOD PUBLIC VOID StoreData ():
        DEFINE VARIABLE hdsPatient AS HANDLE NO-UNDO.
        hdsPatient = DATASET dPatient:HANDLE.
        TEMP-TABLE ttPatient:TRACKING-CHANGES = TRUE.
        
        rGeneric:StoreData(hdsPatient).
        
        TEMP-TABLE ttPatient:TRACKING-CHANGES = FALSE.
    END METHOD. 
    
    METHOD PUBLIC INTEGER daBloodType(INPUT param1 AS CHARACTER):
        DEFINE VARIABLE iCount AS INTEGER INITIAL 0.
        FOR EACH ttPatient WHERE ttPatient.BloodGroup = param1:
            iCount = iCount + 1.
        END.
        RETURN iCount.
    END METHOD.
END CLASS.