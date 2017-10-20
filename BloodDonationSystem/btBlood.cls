 
 /*------------------------------------------------------------------------
    File        : btBlood
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : demo
    Created     : Wed Oct 18 11:17:56 EEST 2017
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS btBlood: 
    DEFINE PRIVATE VARIABLE rbeBloodBank AS CLASS beBloodBank NO-UNDO.
    DEFINE PRIVATE VARIABLE rbeDonor AS CLASS beDonor NO-UNDO.
    DEFINE PRIVATE VARIABLE rbePatient AS CLASS bePatient NO-UNDO.
    DEFINE PRIVATE VARIABLE rbeDonation AS CLASS beDonation NO-UNDO.
    DEFINE PRIVATE VARIABLE cUsername AS CHARACTER NO-UNDO.
    DEFINE PRIVATE VARIABLE cPassword AS CHARACTER NO-UNDO.
    DEFINE PRIVATE VARIABLE iPatient AS INTEGER NO-UNDO.

    CONSTRUCTOR PUBLIC btBlood ( ):
        RUN C-Win.w(OUTPUT cUsername, OUTPUT cPassword).
        ASSIGN 
            /* Create an instance of the objects */ 
            rbeBloodBank = NEW beBloodBank ( ).
            rbeDonor = NEW beDonor ( ).
            rbePatient = NEW bePatient ( ).
            rbeDonation = NEW beDonation ( ).
        myRun().
    END CONSTRUCTOR. 
    
    METHOD PUBLIC VOID myRun ():
        rbeBloodBank:beBloodBankRun(). 
        rbeDonor:beDonorRun().
        rbePatient:bePatientRun(). 
        rbeDonation:beDonationRun().
        iPatient = rbePatient:beBloodType(rbeDonor:beBloodType(cUsername, cPassword)).
        
        IF rbeDonor:beValidate(cUsername, cPassword) THEN DO:
            //IF iPatient > 0 THEN
                IF rbeDonor:beVerify(cUsername, cPassword) THEN 
                    RUN Donor-Page.w(INPUT cUsername, TRUE, iPatient).
                ELSE RUN Donor-Page.w(INPUT cUsername, FALSE, iPatient).
/*            ELSE IF rbeDonor:beVerify(cUsername, cPassword) THEN     */
/*                    RUN Donor-Page.w(INPUT cUsername, TRUE, FALSE).  */
/*                ELSE RUN Donor-Page.w(INPUT cUsername, FALSE, FALSE).*/
        END.
    END METHOD.
END CLASS.