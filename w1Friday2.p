
/*------------------------------------------------------------------------
    File        : w1Friday.p
    Purpose     : 

    Syntax      :

    Description : 

    Author(s)   : 
    Created     : Fri Sep 29 10:18:15 EEST 2017
    Notes       :
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

BLOCK-LEVEL ON ERROR UNDO, THROW.

DEFINE VARIABLE iSum AS INTEGER NO-UNDO INITIAL 0.
DEFINE VARIABLE iMaxNumber AS INTEGER NO-UNDO INITIAL 0.
DEFINE VARIABLE iMaxCity AS CHARACTER NO-UNDO INITIAL 0.

DEFINE BUFFER bCustomer1 FOR Customer.
DEFINE BUFFER bCustomer2 FOR Customer.
DEFINE BUFFER bOrder1 FOR Order.
DEFINE BUFFER bOrder2 FOR Order.


/* ********************  Preprocessor Definitions  ******************** */


/* ***************************  Main Block  *************************** */
/* ***************************  EXERCISE 1  *************************** */
/*Suma de plata pentru fiecare ultima comanda a Clientilor din Florida.*/
/*FOR EACH Customer NO-LOCK WHERE Customer.State = "FL":
    DISPLAY Customer.CustNum Customer.Name Customer.City.
    /*FOR EACH Order WHERE Order.CustNum = Customer.CustNum NO-LOCK:
        DISPLAY 
            Order.OrderNum LABEL "Order"
            Order.OrderDate 
            Order.ShipDate FORMAT "99/99/99" WITH CENTERED.
    END.*/
    FIND LAST Order WHERE Order.CustNum = Customer.CustNum.    
    DISPLAY 
            Order.OrderNum LABEL "Order" .
    iSum = 0.
    FOR EACH OrderLine WHERE Order.OrderNum = OrderLine.Ordernum NO-LOCK:
        iSum = iSum + OrderLine.ExtendedPrice.
        DISPLAY 
            OrderLine.ExtendedPrice.
    END.
    DISPLAY  iSum LABEL "Total".
END.*/

/* ***************************  EXERCISE 2  *************************** */
/*Strada si numarul  fiecarui client  din statele care incep cu N (folosind 2 functii pentru citirea strazii si citirea numarului)*/
/*FUNCTION readStreet RETURNS CHARACTER (INPUT cAddress AS CHARACTER, readNum AS INTEGER) FORWARD.
FUNCTION readNumber RETURNS CHARACTER (INPUT cAddress AS CHARACTER) FORWARD.

FOR EACH Customer NO-LOCK WHERE INDEX(Customer.State, "N") = 1:
    DISPLAY Customer.CustNum Customer.Address Customer.State.
    DISPLAY readNumber(Customer.Address) LABEL "Street Number".
    DISPLAY readStreet(Customer.Address, INTEGER(readNumber(Customer.Address))) LABEL "Street Name" FORMAT "x(20)".
END.

FUNCTION readStreet RETURNS CHARACTER (INPUT cAddress AS CHARACTER, readNum AS INTEGER):
    DEFINE VARIABLE iChar AS INTEGER NO-UNDO.
    DEFINE VARIABLE iAsc AS INTEGER NO-UNDO.

    DEFINE VARIABLE cTemp AS CHARACTER NO-UNDO.
    DEFINE VARIABLE cChar AS CHARACTER NO-UNDO.
    
    DEFINE VARIABLE iMark AS INTEGER NO-UNDO INITIAL 9999.

    DO iChar = 1 TO LENGTH(cAddress):
        ASSIGN cChar  = SUBSTRING(cAddress, iChar, 1)
                iAsc = ASC(cChar).
                
        IF ((iAsc = 32) OR (readNum = ?))THEN
            iMark = iChar.
        
        IF (iChar GT iMark - 1) THEN
            cTemp = cTemp + cChar.
    END.
    RETURN cTemp.
END FUNCTION.

FUNCTION readNumber RETURNS CHARACTER (INPUT cAddress AS CHARACTER):
    DEFINE VARIABLE iChar AS INTEGER NO-UNDO.
    DEFINE VARIABLE iAsc AS INTEGER NO-UNDO.

    DEFINE VARIABLE cTemp AS CHARACTER NO-UNDO.
    DEFINE VARIABLE cChar AS CHARACTER NO-UNDO.

    DO iChar = 1 TO LENGTH(cAddress):
        ASSIGN cChar  = SUBSTRING(cAddress, iChar, 1)
                iAsc = ASC(cChar).
                
        IF iAsc GT 47 AND iAsc LT 58 THEN
            cTemp = cTemp + cChar.
        ELSE IF (iAsc = 32) THEN
            IF (cTemp GT "") EQ TRUE THEN
                RETURN cTemp.
            ELSE RETURN ?. /* If no integers in the string return the unknown value. */
            
    END.
END FUNCTION.*/

/* ***************************  EXERCISE 3  *************************** */
/*Comenzile care nu au fost onorate in maxim o saptamana*/
/*FOR EACH Order NO-LOCK WHERE Order.ShipDate - Order.OrderDate > 7:
    DISPLAY Order.OrderNum LABEL "Order"
            Order.OrderDate 
            Order.ShipDate FORMAT "99/99/99" WITH CENTERED.
END.*/

/* ***************************  EXERCISE 4  *************************** */
/*Orasul din care s-au dat cele mai  multe comenzi.*/
FOR EACH bCustomer1 NO-LOCK BREAK BY bCustomer1.City:
    IF FIRST-OF(bCustomer1.City) THEN
        ASSIGN iSum = 0.
    FOR EACH bOrder1 WHERE bOrder1.CustNum = bCustomer1.CustNum NO-LOCK:
        IF bCustomer1.City NE "" THEN
            ASSIGN iSum = iSum + 1.
    END.
    IF iSum > iMaxNumber THEN DO:
        ASSIGN iMaxNumber = iSum
               iMaxCity = bCustomer1.City.
    END.
END.
DISPLAY bCustomer1.CustNum
        iSum
        iMaxNumber iMaxCity FORMAT "x(20)" WITH CENTERED.