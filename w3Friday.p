
/*------------------------------------------------------------------------
    File        : w3Friday.p
    Purpose     : 

    Syntax      :

    Description : 

    Author(s)   : 
    Created     : Fri Oct 13 12:18:04 EEST 2017
    Notes       :
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

BLOCK-LEVEL ON ERROR UNDO, THROW.
{dsW3Friday.i}

/* ********************  Preprocessor Definitions  ******************** */


/* ***************************  Main Block  *************************** */
TEMP-TABLE ttEmployee:TRACKING-CHANGES = TRUE.

/*  Add a Record */
FIND FIRST ttEmployee WHERE ttEmployee.EmpNum = 98 NO-ERROR.

IF AVAILABLE ttEmployee THEN 
    MESSAGE "It already exists."
    VIEW-AS ALERT-BOX.
ELSE DO:
    CREATE ttEmployee.
    ASSIGN ttEmployee.EmpNum = 98
        ttEmployee.FirstName = "Cata".
END.

/* Update a Record */
FIND ttEmployee WHERE ttEmployee.EmpNum = 8 NO-ERROR.
IF AVAILABLE ttEmployee THEN 
    ASSIGN ttEmployee.FirstName = "Updated Name".

/* Delete a Record */
FIND ttEmployee WHERE ttEmployee.EmpNum = 9 NO-ERROR.
IF AVAILABLE ttEmployee THEN
    DELETE ttEmployee.

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

DEFINE VARIABLE hdsEmployee AS HANDLE     NO-UNDO.
hdsEmployee = DATASET dEmployee:HANDLE.

/* Turn OFF Tracking-Changes */
TEMP-TABLE ttEmployee:TRACKING-CHANGES = FALSE.

FOR EACH btEmployee:
     IF ROW-STATE(ttEmployee) NE 0 THEN DO:
            BUFFER btEmployee:SAVE-ROW-CHANGES . //().
     END.
END.
