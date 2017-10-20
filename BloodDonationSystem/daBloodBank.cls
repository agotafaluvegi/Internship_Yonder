 
 /*------------------------------------------------------------------------
    File        : daBloodBank
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : demo
    Created     : Tue Oct 17 11:36:13 EEST 2017
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS daBloodBank INHERITS daGeneric:
    {dsBloodBank.i} 
    
    DEFINE DATA-SOURCE dsBloodBank FOR BloodBank.
    DEFINE PRIVATE VARIABLE rGeneric AS CLASS daGeneric NO-UNDO.
    
    CONSTRUCTOR PUBLIC daBloodBank ( ):
        BUFFER ttBloodBank:ATTACH-DATA-SOURCE(DATA-SOURCE dsBloodBank:HANDLE,?,?).
        rGeneric = NEW daGeneric ( ).         
    END CONSTRUCTOR. 
        
    
    METHOD PUBLIC VOID FetchData ():        
        DEFINE VARIABLE hdsBloodBank AS HANDLE NO-UNDO.
        hdsBloodBank = DATASET dBloodBank:HANDLE.
        
        rGeneric:FetchData(hdsBloodBank, "ttBloodBank,WHERE ttBloodBank.ID < 20"). 
    END METHOD.
    
    METHOD PUBLIC LOGICAL FindFirst():
        FIND FIRST ttBloodBank WHERE ttBloodBank.ID = 20 NO-LOCK NO-ERROR.
        IF AVAILABLE ttBloodBank THEN
            RETURN TRUE.
        ELSE RETURN FALSE.
    END METHOD.
    
    METHOD PUBLIC VOID StoreData ():
        DEFINE VARIABLE hdsBloodBank AS HANDLE NO-UNDO.
        hdsBloodBank = DATASET dBloodBank:HANDLE.
        TEMP-TABLE ttBloodBank:TRACKING-CHANGES = TRUE.
        
        rGeneric:StoreData(hdsBloodBank).
        
        TEMP-TABLE ttBloodBank:TRACKING-CHANGES = FALSE.
    END METHOD.
END CLASS.