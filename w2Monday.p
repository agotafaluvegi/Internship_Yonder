
/*------------------------------------------------------------------------
    File        : w2Monday.p
    Purpose     : 

    Syntax      :

    Description : 

    Author(s)   : 
    Created     : Mon Oct 02 12:33:39 EEST 2017
    Notes       :
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

BLOCK-LEVEL ON ERROR UNDO, THROW.

/*Build a summary report of customer invoices*/
DEFINE TEMP-TABLE ttInvoice
    FIELD iCustNum LIKE Invoice.CustNum LABEL "Cust#" FORMAT "ZZ9"
    FIELD cCustName LIKE Customer.NAME FORMAT "x(20)"
    FIELD iNumInvs AS INTEGER LABEL "# Inv's" FORMAT "Z9"
    FIELD dInvTotal AS DECIMAL LABEL "Inv Total " FORMAT ">>,>>9.99"
    FIELD dMaxAmount AS DECIMAL LABEL "Max Amount " FORMAT ">>,>>9.99"
    FIELD iInvNum LIKE Invoice.InvoiceNum LABEL "Inv#" FORMAT "ZZ9"
    INDEX idxCustNum IS PRIMARY iCustNum
    INDEX idxInvTotal dInvTotal.
    
/*DEFINE VARIABLE cFieldMapping       AS CHARACTER NO-UNDO.
DEFINE VARIABLE cDataBaseFieldName  AS CHARACTER NO-UNDO.
DEFINE VARIABLE cLocalFieldName     AS CHARACTER NO-UNDO.
DEFINE VARIABLE httMember           AS HANDLE NO-UNDO.*/

{dsOrderTT.i}
{dsOrder.i}

DEFINE QUERY qOrder FOR Order, Customer, Salesrep.
DEFINE QUERY qItem FOR ITEM.

DEFINE DATA-SOURCE srcOrder FOR QUERY qOrder Order KEYS(OrderNum), Customer KEYS(CustNum), SalesRep KEYS(SalesRep).
DEFINE DATA-SOURCE srcOline FOR OrderLine KEYS(OrderNum).
DEFINE DATA-SOURCE srcItem FOR Item KEYS(ItemNum).

//QUERY qOrder:QUERY-PREPARE("FOR EACH Order WHERE Order.OrderNum = 1, " + "FIRST Customer OF Order, FIRST SalesRep OF Order").
QUERY qOrder:QUERY-PREPARE("FOR EACH Order WHERE Order.OrderNum < 10, " + "FIRST Customer OF Order, FIRST SalesRep OF Order").

MESSAGE "1"
VIEW-AS ALERT-BOX.

BUFFER ttOrder:ATTACH-DATA-SOURCE(DATA-SOURCE srcOrder:HANDLE
//,"Customer.Name, CustName"
).
MESSAGE "2"
VIEW-AS ALERT-BOX.
BUFFER ttOline:ATTACH-DATA-SOURCE(DATA-SOURCE srcOline:HANDLE).
BUFFER ttItem:ATTACH-DATA-SOURCE(DATA-SOURCE srcItem:HANDLE).


DATASET dsOrder:FILL().

MESSAGE "3"
VIEW-AS ALERT-BOX.
BUFFER ttOrder:DETACH-DATA-SOURCE().
BUFFER ttOline:DETACH-DATA-SOURCE().
BUFFER ttItem:DETACH-DATA-SOURCE().

/* ********************  Preprocessor Definitions  ******************** */


/* ***************************  Main Block  *************************** */
/* ***************************  Temp Table  *************************** */
/*Retriece each invoice along with its Customer record, to get the Name*/
/*FOR EACH Invoice, Customer OF Invoice:
    FIND FIRST ttInvoice WHERE ttInvoice.iCustNum = Invoice.CustNum NO-ERROR.
    /*If there isnt't already a temp-table record for the Customer, create it and save the Customer # and Name.*/
    IF NOT AVAILABLE ttInvoice THEN DO:
        CREATE ttInvoice.
        ASSIGN
            ttInvoice.iCustNum = Invoice.CustNum
            ttInvoice.cCustName = Customer.Name.
    END.
    
    /*Save off the Invoice amount if it's a new high for this Customer.*/
    IF Invoice.Amount > dMaxAmount THEN
        ASSIGN 
            dMaxAmount = Invoice.Amount
            iInvNum = Invoice.Invoicenum.
            
    /*Increment the Invoice total and Invoice count for the Customer. */
    ASSIGN 
        ttInvoice.dInvTotal = ttInvoice.dInvTotal + Invoice.Amount
        ttInvoice.iNumInvs = ttInvoice.iNumInvs + 1.
END.
            
/*Now display the rsults in descending order by invoice total. */
FOR EACH ttInvoice BY dInvTotal DESCENDING:
    DISPLAY iCustNum cCustName iNumInvs dInvTotal iInvNum dMaxAmount.
END.*/

FOR EACH ttOrder:
    DISPLAY
        ttOrder.OrderNum
        ttOrder.OrderDate
        ttOrder.CustName FORMAT "X(15)"
        ttOrder.RepName FORMAT "X(15)".
END.
FOR EACH ttOline:
    DISPLAY
        ttOline.OrderNum
        ttOline.Linenum.
END.
FOR EACH ttItem:
    DISPLAY ttItem.ItemNum ttItem.ItemName.
END.
