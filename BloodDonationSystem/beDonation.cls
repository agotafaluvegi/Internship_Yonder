 
 /*------------------------------------------------------------------------
    File        : beDonation
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : demo
    Created     : Tue Oct 17 11:37:57 EEST 2017
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS beDonation: 
    DEFINE PRIVATE VARIABLE rdaDonation AS CLASS daDonation NO-UNDO.
    
    CONSTRUCTOR PUBLIC beDonation ( ):
        ASSIGN 
           /* Create an instance of the objects */ 
            rdaDonation = NEW daDonation ( ).
    END CONSTRUCTOR.
    
    METHOD PUBLIC VOID beDonationRun ():
        rdaDonation:FetchData().
        
    IF rdaDonation:FindFirst() = TRUE THEN
            rdaDonation:StoreData().
        ELSE MESSAGE "Not available"
             VIEW-AS ALERT-BOX.
    END METHOD.
END CLASS.