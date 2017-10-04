
/*------------------------------------------------------------------------
    File        : w2Wednesday.p
    Purpose     : 

    Syntax      :

    Description : 

    Author(s)   : 
    Created     : Wed Oct 04 11:15:42 EEST 2017
    Notes       :
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

BLOCK-LEVEL ON ERROR UNDO, THROW.

/* Temp-table definitions */
/*DEFINE TEMP-TABLE ttCustomer BEFORE-TABLE btCustomer
    FIELD CustNum LIKE Customer.CustNum
    FIELD Name LIKE Customer.Name.
    //INDEX CustNum IS UNIQUE PRIMARY CustNum.
    
DEFINE TEMP-TABLE ttOrder BEFORE-TABLE btOrder
    FIELD CustNum LIKE Order.CustNum
    FIELD OrderNum AS INTEGER FORMAT "zzzzzzzzz9"
    FIELD OrderDate AS DATE FORMAT "99/99/99"
    FIELD ShipDate AS DATE FORMAT "99/99/99" 
    FIELD PromiseDate AS DATE FORMAT "99/99/99"
    FIELD OrderTotal AS DECIMAL FORMAT "->,>>>,>>9.99"
    INDEX OrderNum IS UNIQUE PRIMARY OrderNum.
    
/* ProDataSet definition */
DEFINE DATASET dsCustomer FOR ttCustomer, ttOrder
    DATA-RELATION drCustomerOrder FOR ttCustomer, ttOrder
    RELATION-FIELDS (CustNum, CustNum).
    
/* Data-Source Definitions */
DEFINE QUERY qCustomer FOR Customer.

DEFINE DATA-SOURCE srcCustomer FOR QUERY qCustomer.
DEFINE DATA-SOURCE srcOrder FOR Order.*/

DEFINE TEMP-TABLE ttCustomer2 LIKE Customer BEFORE-TABLE btCustomer2.
DEFINE TEMP-TABLE ttOrder2 LIKE Order BEFORE-TABLE btOrder2.
DEFINE DATASET dCustomer2 FOR ttCustomer2.
DEFINE DATASET dOrder2 FOR ttOrder2.
DEFINE QUERY qCustomer2 FOR Customer SCROLLING.
DEFINE QUERY qOrder2 FOR Order SCROLLING.
DEFINE DATA-SOURCE dsCustomer2 FOR QUERY qCustomer2.
DEFINE DATA-SOURCE dsOrder2 FOR QUERY qOrder2.
/* ********************  Preprocessor Definitions  ******************** */


/* ***************************  Main Block  *************************** */
/* Attach Data Sources */
/*BUFFER ttCustomer:ATTACH-DATA-SOURCE(DATA-SOURCE srcCustomer:HANDLE).
BUFFER ttOrder:ATTACH-DATA-SOURCE(DATA-SOURCE srcOrder:HANDLE,?,?).

/* Prepare Query */
QUERY qCustomer:QUERY-PREPARE("FOR EACH Customer WHERE CustNum < 10").

MESSAGE 
    TEMP-TABLE btCustomer:AFTER-TABLE:PRIMARY
    TEMP-TABLE ttCustomer:BEFORE-TABLE:PRIMARY
    TEMP-TABLE btOrder:AFTER-TABLE:NAME
    TEMP-TABLE ttOrder:BEFORE-TABLE:NAME
    BUFFER btOrder:AFTER-BUFFER:NAME
    BUFFER ttCustomer:BEFORE-BUFFER:NAME
    BUFFER btOrder:AFTER-BUFFER:NAME
    BUFFER ttOrder:BEFORE-BUFFER:NAME

    VIEW-AS ALERT-BOX INFO BUTTONS OK.

DATASET dsCustomer:FILL().

FOR EACH ttCustomer:
        DISPLAY ttCustomer.CustNum
                ttCustomer.Name.
END.
                
FOR EACH ttOrder:
        DISPLAY ttOrder.OrderNum
                ttOrder.OrderDate
                ttOrder.ShipDate    
                ttOrder.PromiseDate
                ttOrder.OrderTotal WITH FRAME ttOrderFrame 
                                        1 COL
                                        TITLE "Order".
        UPDATE ttOrder.OrderTotal WITH FRAME ttOrderFrame.
END.

    MESSAGE 

    TEMP-TABLE btCustomer:AFTER-TABLE:HAS-RECORDS
    TEMP-TABLE ttCustomer:BEFORE-TABLE:PRIMARY
    TEMP-TABLE btOrder:AFTER-TABLE:NAME
    TEMP-TABLE ttOrder:BEFORE-TABLE:NAME
    BUFFER btCustomer:AFTER-BUFFER:NAME
    BUFFER ttCustomer:BEFORE-BUFFER:NAME
    BUFFER btOrder:AFTER-BUFFER:NAME
    BUFFER ttOrder:BEFORE-BUFFER:NAME

    VIEW-AS ALERT-BOX INFO BUTTONS OK.

    FOR EACH btOrder:
        DISPLAY btOrder. END.
        
TEMP-TABLE ttCustomer:TRACKING-CHANGES = TRUE.

/*  Add a Record */
CREATE ttCustomer.
ASSIGN ttCustomer.custnum = 99999
    ttCustomer.NAME = "Agota".

/* Update a Record */
FIND ttCustomer WHERE ttCustomer.custnum = 3.
ASSIGN ttCustomer.NAME = "Faluvegi".

/* Delete a Record */
FIND ttCustomer WHERE ttCustomer.custnum = 1.
DELETE ttCustomer.

FOR EACH ttCustomer:  
    DISPLAY 
        STRING(BUFFER ttCustomer:ROWID) LABEL "ROWID" FORMAT "x(10)"
        ttcustomer.custnum FORMAT ">>>>9"
        ttcustomer.NAME FORMAT "x(15)"
        BUFFER ttCustomer:ROW-STATE LABEL "ROW-STATE"
        STRING(BUFFER ttCustomer:BEFORE-ROWID) LABEL "BEFORE-ROWID" FORMAT "x(10)"
               WITH FRAME A TITLE "DataSet After-Table" 4 DOWN WIDTH 90. 
END.

DEFINE VARIABLE i AS INTEGER    NO-UNDO.

FOR EACH btCustomer:
    ASSIGN i = BUFFER btCustomer:ROW-STATE.
    DISPLAY 
        STRING(BUFFER btCustomer:ROWID) LABEL "ROWID" FORMAT "x(10)"
        btcustomer.custnum 
        btcustomer.NAME FORMAT "x(10)"
        BUFFER btCustomer:ROW-STATE LABEL "ROW-STATE"
        i
        STRING(BUFFER btCustomer:AFTER-ROWID) LABEL "AFTER-ROWID" FORMAT "x(10)"
        WITH FRAME B TITLE "DataSet Before-Table" 4 DOWN.
END.

DEFINE VARIABLE hChangeDataSet AS HANDLE     NO-UNDO.
DEFINE VARIABLE hdsCustomer AS HANDLE     NO-UNDO.
hdsCustomer = DATASET dsCustomer:HANDLE.
CREATE DATASET hChangeDataSet.
hChangeDataSet:CREATE-LIKE(hdsCustomer).

/* Turn OFF Tracking-Changes */
TEMP-TABLE ttcustomer:TRACKING-CHANGES = FALSE.

/* Process Get-Changes to extract Changes at DataSet Level */
hChangeDataSet:GET-CHANGES(hdsCustomer).*/

/********************************************************************** */
/*Creati o functie care primeste ca si input un temp-table Customer apoi 
parcurce recordurile care au fost sterse din temp-table , pentru fiecare 
customer sters sa se verifice daca exista recorduri in tabela Order pentru 
acel customer , daca exista sa se puna un mesaj de eroare pe ecran:  
Customer “X” has active orders and cannot be deleted*/
FUNCTION tempCust RETURNS LOGICAL (INPUT TABLE btCustomer2) FORWARD.

BUFFER ttCustomer2:ATTACH-DATA-SOURCE(DATA-SOURCE dsCustomer2:HANDLE,?,?).
QUERY qCustomer2:QUERY-PREPARE("FOR EACH Customer ").
DATASET dCustomer2:FILL().

BUFFER ttOrder2:ATTACH-DATA-SOURCE(DATA-SOURCE dsOrder2:HANDLE,?,?).
QUERY qOrder2:QUERY-PREPARE("FOR EACH Order ").
DATASET dOrder2:FILL().

TEMP-TABLE ttCustomer2:TRACKING-CHANGES = TRUE.

/* Delete a Record */
FOR EACH ttCustomer2 WHERE ttCustomer2.custnum < 50:
DELETE ttCustomer2. END.

FOR EACH btCustomer2:
    IF tempCust(TABLE btCustomer2) THEN
    MESSAGE tempCust(TABLE btCustomer2)
    VIEW-AS ALERT-BOX.
        DISPLAY btCustomer2.CustNum btCustomer2.Name "Customer “X” has active orders and cannot be deleted".
        /*MESSAGE "Customer “X” has active orders and cannot be deleted"
        VIEW-AS ALERT-BOX.*/
END.

DEFINE VARIABLE hChangeDataSet2 AS HANDLE     NO-UNDO.
DEFINE VARIABLE hdsCustomer2 AS HANDLE     NO-UNDO.
hdsCustomer2 = DATASET dCustomer2:HANDLE.

CREATE DATASET hChangeDataSet2.
hChangeDataSet2:CREATE-LIKE(hdsCustomer2).

/* Turn OFF Tracking-Changes */
TEMP-TABLE ttCustomer2:TRACKING-CHANGES = FALSE.

/* Process Get-Changes to extract Changes at DataSet Level */
hChangeDataSet2:SAVE-ROW-CHANGES() NO-ERROR.

FUNCTION tempCust RETURNS LOGICAL (INPUT TABLE btCustomer2):
    IF BUFFER btCustomer2:ROW-STATE = ROW-DELETED THEN DO:
        FOR EACH ttOrder2: 
            IF ttOrder2.CustNum = btCustomer2.CustNum THEN
                RETURN TRUE.
            ELSE RETURN FALSE.
        END.
    END.
END FUNCTION.