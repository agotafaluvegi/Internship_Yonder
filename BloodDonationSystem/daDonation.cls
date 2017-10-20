 
 /*------------------------------------------------------------------------
    File        : daDonation
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : demo
    Created     : Tue Oct 17 11:36:34 EEST 2017
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS daDonation: 
    {dsDonation.i} 
    
    DEFINE DATA-SOURCE dsDonation FOR Donation.
    DEFINE PRIVATE VARIABLE rGeneric AS CLASS daGeneric NO-UNDO.
    
    CONSTRUCTOR PUBLIC daDonation ( ):
        BUFFER ttDonation:ATTACH-DATA-SOURCE(DATA-SOURCE dsDonation:HANDLE,?,?).
        rGeneric = NEW daGeneric ( ).         
    END CONSTRUCTOR. 
        
    
    METHOD PUBLIC VOID FetchData ():        
        DEFINE VARIABLE hdsDonation AS HANDLE NO-UNDO.
        hdsDonation = DATASET dDonation:HANDLE.
        
        rGeneric:FetchData(hdsDonation, "ttDonation,WHERE ttDonation.ID < 6").
    END METHOD.
    
    METHOD PUBLIC LOGICAL FindFirst():
        FIND FIRST ttDonation WHERE ttDonation.ID = 3 NO-LOCK NO-ERROR.
        IF AVAILABLE ttDonation THEN
            RETURN TRUE.
        ELSE RETURN FALSE.
    END METHOD.
    
    METHOD PUBLIC VOID StoreData ():
        DEFINE VARIABLE hdsDonation AS HANDLE NO-UNDO.
        hdsDonation = DATASET dDonation:HANDLE.
        TEMP-TABLE ttDonation:TRACKING-CHANGES = TRUE.
        
        rGeneric:StoreData(hdsDonation).
        
        TEMP-TABLE ttDonation:TRACKING-CHANGES = FALSE.
    END METHOD.
END CLASS.