
/*------------------------------------------------------------------------
    File        : challenge1.p
    Purpose     : 

    Syntax      :

    Description : 

    Author(s)   : 
    Created     : Thu Sep 28 11:09:28 EEST 2017
    Notes       :
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

BLOCK-LEVEL ON ERROR UNDO, THROW.

DEF VAR c AS CHARACTER NO-UNDO EXTENT 6 INITIAL [ 1, 2, 3, 4, 5, 6 ].
DEF VAR cMod AS CHARACTER NO-UNDO.
c[1] = "Las-Vegas - Los-Angeles".
c[2] = "Paris - New-York".
c[3] = "Cluj-Napoca - Berlin".
c[4] = "Sibiu - Bucuresti".
c[5] = "dej - dej".
c[6] = "Chicago - San Francisco".
DEF VAR cField1 AS CHAR NO-UNDO EXTENT 6 INITIAL [ 1, 2, 3, 4, 5, 6 ].
DEF VAR cField2 AS CHAR NO-UNDO EXTENT 6 INITIAL [ 1, 2, 3, 4, 5, 6 ].

DEF VAR i AS INTEGER NO-UNDO.

/* ********************  Preprocessor Definitions  ******************** */


/* ***************************  Main Block  *************************** */
DO i = 1 TO EXTENT( c ):
    cMod = REPLACE(c[i], " - ", "*").
    cField1[i] = ENTRY(1, cMod, "*").
    cField2[i] = ENTRY(2, cMod, "*").
    DISPLAY cField1[i] FORMAT "x(20)" LABEL "From" WITH SIDE-LABELS WITH FRAME i 20 DOWN.
    DISPLAY cField2[i] FORMAT "x(20)" LABEL "To" WITH SIDE-LABELS WITH FRAME i 20 DOWN.
    DOWN WITH FRAME i.
END.