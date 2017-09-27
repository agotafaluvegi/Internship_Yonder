
/*------------------------------------------------------------------------
    File        : recordBuffers_recordScope.p
    Purpose     : 

    Syntax      :

    Description : 

    Author(s)   : 
    Created     : Wed Sep 27 08:49:50 EEST 2017
    Notes       :
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

BLOCK-LEVEL ON ERROR UNDO, THROW.

DEFINE VARIABLE dOrderDate AS DATE NO-UNDO.
DEFINE VARIABLE iSum AS INTEGER NO-UNDO INITIAL 0.

DEFINE BUFFER Customer FOR Customer.
DEFINE BUFFER OtherCust FOR Customer.

DEFINE QUERY ex1 FOR Customer, Order.
DEFINE QUERY ex2 FOR Employee.
DEFINE QUERY ex3 FOR Customer, Order, OrderLine.

/* ********************  Preprocessor Definitions  ******************** */


/* ***************************  Main Block  *************************** */
/*FOR EACH Customer NO-LOCK WHERE Customer.Country = "USA":
        FIND FIRST OtherCust NO-LOCK
            WHERE Customer.State = OtherCust.State
                AND Customer.City = OtherCust.City
                AND SUBSTRING(Customer.PostalCode, 1, 3) NE
                    SUBSTRING(OtherCust.PostalCode, 1, 3)
                AND Customer.CustNum < OtherCust.CustNum NO-ERROR.
        IF AVAILABLE OtherCust THEN
            DISPLAY
                Customer.CustNum
                Customer.City FORMAT "x(12)"
                Customer.State FORMAT "xx"
                Customer.PostalCode
                OtherCust.CustNum
                OtherCust.PostalCode.
END.*/

/*FOR EACH Customer NO-LOCK BY Customer.CreditLimit DESCENDING:
    DISPLAY "Highest:" Customer.CustNum Customer.Name Customer.CreditLimit
        WITH 1 DOWN.
    LEAVE.
END.

FOR EACH Customer NO-LOCK WHERE Customer.State = "NH"
    BY Customer.CreditLimit DESCENDING:
    DISPLAY Customer.CustNum Customer.Name Customer.CreditLImit.
END.*/

/*DO FOR Customer:
    FIND FIRST Customer NO-LOCK WHERE Customer.CreditLimit > 60000.
    DISPLAY Customer.CustNum Customer.Name Customer.CreditLimit.
END.

FOR EACH Customer NO-LOCK WHERE Customer.State = "NH"
    BY Customer.CreditLimit DESCENDING:
    DISPLAY Customer.CustNum Customer.Name Customer.CreditLImit.
END.6
*/

//EXERCISE1
/*OPEN QUERY ex1 FOR EACH Customer, EACH Order OF Customer.
GET FIRST ex1.

DO WHILE NOT QUERY-OFF-END("ex1"):
    dOrderDate = Order.OrderDate + 1.
    IF MONTH(dOrderDate) NE MONTH(Order.OrderDate)THEN
    DISPLAY Customer.Name Order.OrderDate WEEKDAY(Order.OrderDate)
        //NUM-RESULTS("ex1") LABEL "Rows" 
        WITH FRAME ex1 20 DOWN.
    GET NEXT ex1.
    
    DOWN WITH FRAME ex1.
END.*/

//EXERCISE2
/*OPEN QUERY ex2 FOR EACH Employee WHERE INDEX(Employee.Address, "Springs Rd") NE 0.
GET FIRST ex2.

DO WHILE NOT QUERY-OFF-END("ex2"):
    DISPLAY Employee.FirstName Employee.LastName Employee.Address
        //NUM-RESULTS("ex1") LABEL "Rows" 
        WITH FRAME ex2 5 DOWN.
    GET NEXT ex2.
    
    DOWN WITH FRAME ex2.
END.*/

//EXERCISE3
ETIME(YES).
OPEN QUERY ex3 FOR EACH Customer WHERE Customer.State NE "FL", EACH ORDER OF Customer, EACH OrderLine OF Order.
GET FIRST ex3.
DO WHILE NOT QUERY-OFF-END("ex3"):
    iSum = iSum + OrderLine.ExtendedPrice.
    GET NEXT ex3.
END.
DISPLAY iSum LABEL "Total".
ETIME(NO).
MESSAGE ETIME
VIEW-AS ALERT-BOX.
