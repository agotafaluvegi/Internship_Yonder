 
 /*------------------------------------------------------------------------
    File        : dsDonor
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : demo
    Created     : Tue Oct 17 11:36:46 EEST 2017
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS daDonor: 
    {dsDonor.i} 
    
    DEFINE DATA-SOURCE dsDonor FOR Donor.
    DEFINE PRIVATE VARIABLE rGeneric AS CLASS daGeneric NO-UNDO.
    DEFINE VARIABLE v-datetime    AS DATE    NO-UNDO.    
    
    CONSTRUCTOR PUBLIC daDonor ( ):
        BUFFER ttDonor:ATTACH-DATA-SOURCE(DATA-SOURCE dsDonor:HANDLE,?,?).
        rGeneric = NEW daGeneric ( ).         
    END CONSTRUCTOR. 
        
    
    METHOD PUBLIC VOID FetchData ():        
        DEFINE VARIABLE hdsDonor AS HANDLE NO-UNDO.
        hdsDonor = DATASET dDonor:HANDLE.
        
        rGeneric:FetchData(hdsDonor, "ttDonor,WHERE ttDonor.ID < 6").
    END METHOD.
    
    METHOD PUBLIC LOGICAL FindFirst():
        FIND FIRST ttDonor WHERE ttDonor.ID = 3 NO-LOCK NO-ERROR.
        IF AVAILABLE ttDonor THEN
            RETURN TRUE.
        ELSE RETURN FALSE.
    END METHOD.
    
    METHOD PUBLIC VOID StoreData ():
        DEFINE VARIABLE hdsDonor AS HANDLE NO-UNDO.
        hdsDonor = DATASET dDonor:HANDLE.
        TEMP-TABLE ttDonor:TRACKING-CHANGES = TRUE.
        
        rGeneric:StoreData(hdsDonor).
        
        TEMP-TABLE ttDonor:TRACKING-CHANGES = FALSE.
    END METHOD.
    
    METHOD PUBLIC LOGICAL daSearchUser(INPUT param1 AS CHARACTER, INPUT param2 AS CHARACTER):
        FIND FIRST ttDonor WHERE ttDonor.Username = param1 AND ttDonor.Password = param2 NO-LOCK NO-ERROR.
        IF AVAILABLE ttDonor THEN
            RETURN TRUE.
        ELSE RETURN FALSE.
    END METHOD.
    
    METHOD PUBLIC LOGICAL daVerify(INPUT param1 AS CHARACTER, INPUT param2 AS CHARACTER):
        ASSIGN v-datetime    = NOW.
        FIND FIRST ttDonor WHERE ttDonor.Username = param1 AND ttDonor.Password = param2 NO-LOCK NO-ERROR.
        IF AVAILABLE ttDonor AND v-datetime - ttDonor.LastDonation > 90 THEN
            RETURN TRUE.
        ELSE RETURN FALSE.
    END METHOD.
    
    METHOD PUBLIC CHARACTER daBloodType(INPUT param1 AS CHARACTER, INPUT param2 AS CHARACTER):
        FIND FIRST ttDonor WHERE ttDonor.Username = param1 AND ttDonor.Password = param2 NO-LOCK NO-ERROR.
        IF AVAILABLE ttDonor THEN
            RETURN ttDonor.BloodGroup.
    END METHOD.
END CLASS.