 
 /*------------------------------------------------------------------------
    File        : beDonor
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : demo
    Created     : Tue Oct 17 11:38:08 EEST 2017
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS beDonor: 
    DEFINE PRIVATE VARIABLE rdaDonor AS CLASS daDonor NO-UNDO.
    
    CONSTRUCTOR PUBLIC beDonor ( ):
        ASSIGN 
           /* Create an instance of the objects */ 
            rdaDonor = NEW daDonor ( ).
    END CONSTRUCTOR.
    
    METHOD PUBLIC VOID beDonorRun ():
        rdaDonor:FetchData().
        
    IF rdaDonor:FindFirst() = TRUE THEN
            rdaDonor:StoreData().
        ELSE MESSAGE "Not available"
             VIEW-AS ALERT-BOX.
    END METHOD.
    
    METHOD PUBLIC LOGICAL beValidate(INPUT beParam1 AS CHARACTER, INPUT beParam2 AS CHARACTER):
        RETURN rdaDonor:daSearchUser(beParam1, beParam2).
    END METHOD.
    
    METHOD PUBLIC LOGICAL beVerify(INPUT beParam1 AS CHARACTER, INPUT beParam2 AS CHARACTER):
        RETURN rdaDonor:daVerify(beParam1, beParam2).
    END METHOD.
    
    METHOD PUBLIC CHARACTER beBloodType(INPUT beParam1 AS CHARACTER, INPUT beParam2 AS CHARACTER):
        RETURN rdaDonor:daBloodType(beParam1, beParam2).
    END METHOD.
END CLASS.