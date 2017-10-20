
/*------------------------------------------------------------------------
    File        : populate.p
    Purpose     : 

    Syntax      :

    Description : 

    Author(s)   : 
    Created     : Tue Oct 17 11:47:48 EEST 2017
    Notes       :
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

BLOCK-LEVEL ON ERROR UNDO, THROW.

/* ********************  Preprocessor Definitions  ******************** */


/* ***************************  Main Block  *************************** */
{dsBloodBank.i}
{dsDonor.i}
{dsPatient.i}
{dsDonation.i}
DEFINE QUERY qBloodBank FOR BloodBank SCROLLING.
DEFINE DATA-SOURCE dsBloodBank FOR QUERY qBloodBank.
BUFFER ttBloodBank:ATTACH-DATA-SOURCE(DATA-SOURCE dsBloodBank:HANDLE,?,?).
QUERY qBloodBank:QUERY-PREPARE("FOR EACH BloodBank").
DATASET dBloodBank:FILL().
//DEFINE DATA-SOURCE dsBloodBank FOR BloodBank.
//BUFFER ttBloodBank:ATTACH-DATA-SOURCE(DATA-SOURCE dsBloodBank:HANDLE,?,?). 
TEMP-TABLE ttBloodBank:TRACKING-CHANGES = TRUE.

/*  Add a Record */
/*FIND FIRST ttBloodBank WHERE ttBloodBank.ID = 1 NO-ERROR.

IF AVAILABLE ttBloodBank THEN 
    MESSAGE "It already exists."
    VIEW-AS ALERT-BOX.
ELSE DO:*/
/*    CREATE ttBloodBank.
    ASSIGN
        ttBloodBank.ID = CURRENT-VALUE(NextBloodBank)
        ttBloodBank.Name = "Coco"
        ttBloodBank.Address = "Crisan"
        ttBloodBank.ContactNr = "5975312674"
        ttBloodBank.DonorID = 3.*/
//END.

/*DEFINE QUERY qDonor FOR Donor SCROLLING.                          */
/*DEFINE DATA-SOURCE dsDonor FOR QUERY qDonor.                      */
/*BUFFER ttDonor:ATTACH-DATA-SOURCE(DATA-SOURCE dsDonor:HANDLE,?,?).*/
/*QUERY qDonor:QUERY-PREPARE("FOR EACH Donor").                     */
DEFINE DATA-SOURCE dsDonor FOR Donor.
BUFFER ttDonor:ATTACH-DATA-SOURCE(DATA-SOURCE dsDonor:HANDLE,?,?).
DATASET dDonor:FILL(). 
TEMP-TABLE ttDonor:TRACKING-CHANGES = TRUE.

/*  Add a Record */
/*CREATE ttDonor.
ASSIGN
    ttDonor.ID = CURRENT-VALUE(NextDonor)
    ttDonor.Address = "Clinicilor"
    ttDonor.BloodGroup = "AB"
    ttDonor.ContactNr = "1234567890"
    ttDonor.Height = 180
    ttDonor.LastDonation = 9/29/2017
    ttDonor.MedicalReport = "T98H5"
    ttDonor.MemorableWord = "blind"
    ttDonor.Name = "Sasha"
    ttDonor.Password = "r99y8"
    ttDonor.Sex = "M"
    ttDonor.TotalDonation = 7
    ttDonor.Username = "s1995"
    ttDonor.Weight = 80.*/
    
DEFINE DATA-SOURCE dsPatient FOR Patient.
BUFFER ttPatient:ATTACH-DATA-SOURCE(DATA-SOURCE dsPatient:HANDLE,?,?).
DATASET dPatient:FILL(). 
TEMP-TABLE ttPatient:TRACKING-CHANGES = TRUE.

/*  Add a Record */
/*CREATE ttPatient.
ASSIGN
    ttPatient.ID = CURRENT-VALUE(NextPatient)
    ttPatient.Address = "Eminescu"
    ttPatient.BloodGroup = "B"
    ttPatient.ContactNr = "0235698741"
    ttPatient.Disease = "Injury"
    ttPatient.DonationDate = 09/25/2017
    ttPatient.Name = "Andre"
    ttPatient.NeedAmount = 0.12
    ttPatient.NeedDate = 09/19/2017.*/
    
DEFINE DATA-SOURCE dsDonation FOR Donation.
BUFFER ttDonation:ATTACH-DATA-SOURCE(DATA-SOURCE dsDonation:HANDLE,?,?).
DATASET dDonation:FILL(). 
TEMP-TABLE ttDonation:TRACKING-CHANGES = TRUE.

/*  Add a Record */
CREATE ttDonation.
ASSIGN
    ttDonation.ID = CURRENT-VALUE(NextDonation)
    ttDonation.BloodBankID = 17
    ttDonation.DonatorID = 1
    ttDonation.Patient = 5.

/*
/* Update a Record */
FIND FIRST ttBloodBank WHERE ttBloodBank.Name = "Ana" NO-ERROR.
IF AVAILABLE ttBloodBank THEN 
MESSAGE ttBloodBank.ID
VIEW-AS ALERT-BOX.
ELSE MESSAGE "Something"
     VIEW-AS ALERT-BOX.
    //ASSIGN ttBloodBank.ID = 2.*/
/*
/* Delete a Record */
FIND FIRST ttBloodBank WHERE ttBloodBank.ID = 0 NO-ERROR.
IF AVAILABLE ttBloodBank THEN
    DELETE ttBloodBank.*/
/*
FOR EACH ttEmployee:  
    DISPLAY 
        STRING(BUFFER ttEmployee:ROWID) LABEL "ROWID" FORMAT "x(5)"
        ttEmployee.EmpNum FORMAT ">>>9"
        ttEmployee.FirstName FORMAT "x(15)"
        BUFFER ttEmployee:ROW-STATE LABEL "ROW-STATE"
        STRING(BUFFER ttEmployee:BEFORE-ROWID) LABEL "BEFORE-ROWID" FORMAT "x(5)"
               WITH FRAME A TITLE "DataSet After-Table" 10 DOWN WIDTH 90. 
END.

DEFINE VARIABLE i AS INTEGER    NO-UNDO.

FOR EACH btEmployee:
    ASSIGN i = BUFFER btEmployee:ROW-STATE.
    DISPLAY 
        STRING(BUFFER btEmployee:ROWID) LABEL "ROWID" FORMAT "x(5)"
        btEmployee.EmpNum 
        btEmployee.FirstName FORMAT "x(10)"
        BUFFER btEmployee:ROW-STATE LABEL "ROW-STATE"
        i
        STRING(BUFFER btEmployee:AFTER-ROWID) LABEL "AFTER-ROWID" FORMAT "x(5)"
        WITH FRAME B TITLE "DataSet Before-Table" 4 DOWN.
END.
*/
DEFINE VARIABLE hdsBloodBank AS HANDLE     NO-UNDO.
hdsBloodBank = DATASET dBloodBank:HANDLE.

/* Turn OFF Tracking-Changes */
TEMP-TABLE ttBloodBank:TRACKING-CHANGES = FALSE.

FOR EACH btBloodBank:
     IF ROW-STATE(ttBloodBank) NE 0 THEN DO:
            BUFFER btBloodBank:SAVE-ROW-CHANGES . //().
     END.
END.

/* Turn OFF Tracking-Changes */
TEMP-TABLE ttDonor:TRACKING-CHANGES = FALSE.

FOR EACH btDonor:
     IF ROW-STATE(ttDonor) NE 0 THEN DO:
            BUFFER btDonor:SAVE-ROW-CHANGES . //().
     END.
END.

/* Turn OFF Tracking-Changes */
TEMP-TABLE ttPatient:TRACKING-CHANGES = FALSE.

FOR EACH btPatient:
     IF ROW-STATE(ttPatient) NE 0 THEN DO:
            BUFFER btPatient:SAVE-ROW-CHANGES . //().
     END.
END.

/* Turn OFF Tracking-Changes */
TEMP-TABLE ttDonation:TRACKING-CHANGES = FALSE.

FOR EACH btDonation:
     IF ROW-STATE(ttDonation) NE 0 THEN DO:
            BUFFER btDonation:SAVE-ROW-CHANGES . //().
     END.
END.

