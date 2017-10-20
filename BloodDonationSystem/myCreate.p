
/*------------------------------------------------------------------------
    File        : myCreate.p
    Purpose     : 

    Syntax      :

    Description : 

    Author(s)   : 
    Created     : Fri Oct 20 12:35:47 EEST 2017
    Notes       :
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

BLOCK-LEVEL ON ERROR UNDO, THROW.
DEFINE INPUT PARAMETER cAddress AS CHARACTER NO-UNDO.
DEFINE INPUT PARAMETER cBloodGroup AS CHARACTER NO-UNDO.
DEFINE INPUT PARAMETER cContactNr AS CHARACTER NO-UNDO.
DEFINE INPUT PARAMETER dHeight AS DECIMAL NO-UNDO.
DEFINE INPUT PARAMETER dLastDonation AS DATE NO-UNDO.
DEFINE INPUT PARAMETER cMemorableWord AS CHARACTER NO-UNDO.
DEFINE INPUT PARAMETER cName AS CHARACTER NO-UNDO.
DEFINE INPUT PARAMETER cPassword AS CHARACTER NO-UNDO.
DEFINE INPUT PARAMETER cSex AS CHARACTER NO-UNDO.
DEFINE INPUT PARAMETER cUsername AS CHARACTER NO-UNDO.
DEFINE INPUT PARAMETER dWeight AS DECIMAL NO-UNDO.

/* ********************  Preprocessor Definitions  ******************** */


/* ***************************  Main Block  *************************** */
{dsDonor.i}

DEFINE DATA-SOURCE dsDonor FOR Donor.
BUFFER ttDonor:ATTACH-DATA-SOURCE(DATA-SOURCE dsDonor:HANDLE,?,?).
DATASET dDonor:FILL(). 
TEMP-TABLE ttDonor:TRACKING-CHANGES = TRUE.

/*  Add a Record */
CREATE ttDonor. 
ASSIGN
    ttDonor.ID = CURRENT-VALUE(NextDonor)
    ttDonor.Address = cAddress
    ttDonor.BloodGroup = cBloodGroup
    ttDonor.ContactNr = cContactNr
    ttDonor.Height = dHeight
    ttDonor.LastDonation = dLastDonation
    ttDonor.MemorableWord = cMemorableWord
    ttDonor.Name = cName
    ttDonor.Password = cPassword
    ttDonor.Sex = cSex
    ttDonor.Username = cUsername
    ttDonor.Weight = dWeight
    ttDonor.MedicalReport = "T98H5"
    ttDonor.TotalDonation = 7.
    
/* Turn OFF Tracking-Changes */
TEMP-TABLE ttDonor:TRACKING-CHANGES = FALSE.

FOR EACH btDonor:
     IF ROW-STATE(ttDonor) NE 0 THEN DO:
            BUFFER btDonor:SAVE-ROW-CHANGES . //().
     END.
     
     MESSAGE cName + " was created"
     VIEW-AS ALERT-BOX.
END.