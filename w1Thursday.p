
/*------------------------------------------------------------------------
    File        : w1Thursday.p
    Purpose     : 

    Syntax      :

    Description : 

    Author(s)   : 
    Created     : Thu Sep 28 12:51:07 EEST 2017
    Notes       :
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

BLOCK-LEVEL ON ERROR UNDO, THROW.

DEFINE VARIABLE cMonthList AS CHARACTER NO-UNDO
    INITIAL "JAN, FEB, MAR, APR, MAY, JUN, JUL, AUG, SEP, OCT, NOV, DEC".
DEFINE VARIABLE iDays AS INTEGER NO-UNDO.

DEFINE VARIABLE dTemp AS DECIMAL NO-UNDO.
DEFINE VARIABLE hFuncProc AS HANDLE NO-UNDO.

DEFINE BUFFER bCustomer FOR Customer.

/* ********************  Preprocessor Definitions  ******************** */


/* ***************************  Main Block  *************************** */
//----------------------------  PROCEDURES  ---------------------------
//First display each Customer from New Hampshire:
/*FOR EACH Customer NO-LOCK WHERE Customer.State = "NH" BY Customer.City:
    DISPLAY Customer.CustNum Customer.Name Customer.City.
    //Show the Orders unless the Credit Limit iss less than twice the balance
    IF Customer.CreditLimit < 2 * Customer.Balance THEN
        DISPLAY "Credit Ratio:" Customer.CreditLimit / Customer.Balance.
    ELSE
        FOR EACH Order OF Customer NO-LOCK:
            DISPLAY 
                Order.OrderNum LABEL "Order"
                Order.OrderDate 
                Order.ShipDate FORMAT "99/99/99" WITH CENTERED.
                //Show the month as a three-letter abbreviation, along with the number of days since the order was shipped
                 IF Order.ShipDate NE ? THEN
                     DISPLAY ENTRY(MONTH(Order.ShipDate), cMonthList) LABEL "Month". 
                RUN calcDays (INPUT Order.ShipDate, OUTPUT iDays).
                DISPLAY iDays LABEL "Days" FORMAT "ZZZ9".
        END.
END. 

PROCEDURE calcDays:
    /*This calculates the number of days since the Order was shipped.*/
    DEFINE INPUT PARAMETER pdaShip AS DATE NO-UNDO.
    DEFINE OUTPUT PARAMETER piDays AS INTEGER NO-UNDO.
    
    piDays = IF pdaShip = ? THEN 0 ELSE TODAY - pdaShip.
END PROCEDURE.*/

//----------------------------  FUNCTIONS  ---------------------------
/*_______________________IN THE SAME PROCEDURE____________________*/
/*h-ConvTemp1.p -- convert temperatures and demonstrate functions*/
/*FUNCTION CtoF RETURNS DECIMAL (INPUT dCelsius AS DECIMAL) FORWARD.

REPEAT dTemp = 0 TO 100:
    DISPLAY
        dTemp LABEL "Celsius"
        CtoF(dTemp) LABEL "Fahrenheit"
        WITH FRAME f 10 DOWN.
END.

FUNCTION CtoF RETURNS DECIMAL (INPUT dCelsius AS DECIMAL):
    RETURN (dCelsius * 1.8) + 32.
END FUNCTION.*/

/*_____________________________IN ANOTHER PROCEDURE__________________*/
/*h-ConvTemp1.p -- convert temperatures and demonstrate functions*/
/*FUNCTION CtoF RETURNS DECIMAL (INPUT dCelsius AS DECIMAL) IN hFuncProc.

RUN h-FuncProc.p PERSISTENT SET hFuncProc.

REPEAT dTemp = 0 TO 100:
    DISPLAY
        dTemp LABEL "Celsius"
        CtoF(dTemp) LABEL "Fahrenheit"
        WITH FRAME f 10 DOWN.
END.

DELETE PROCEDURE hFuncProc.*/

/*----------------------------EXCLUSIVE LOCK-------------------------*/
/*FIND Customer 1. //EXCLUSIVE-LOCK.
DISPLAY "User 1 has locked:" NAME.
WAIT-FOR CLOSE OF THIS-PROCEDURE.*/

/*-----------------------------EXERCISE 1-----------------------------*/
/* Mutati primul client din Boston in Florida.*/
/*DO TRANSACTION ON ERROR UNDO, LEAVE:
    FIND FIRST bCustomer WHERE bCustomer.State = "MA".
        DISPLAY bCustomer.City bCustomer.State.
        bCustomer.State = "FL".
        DISPLAY bCustomer.City bCustomer.State.
END.*/
    
/*-----------------------------EXERCISE 2-----------------------------*/
/*Adaugati un Client nou cu urmatoarele date:
Country: Romania
Name: <numele vostru>
Address: 77, 21 Decembrie 1989 St., The Office
City: Cluj-Napoca
State: CJ
PostalCode: 400604
EmailAddress: <numelevostruintreg separat prin puncte>@tss-yonder.com*/    
/* Inserts a new row with default values set */
/*DO TRANSACTION ON ERROR UNDO, LEAVE:
    CREATE bCustomer.
    bCustomer.Country = "Romania".
    bCustomer.Name = "Agota".
    bCustomer.Address = "77, 21 Decembrie 1989 St., The Office".
    bCustomer.City = "Cluj-Napoca".
    bCustomer.State = "CJ".
    bCustomer.PostalCode = "400604".
    bCustomer.EmailAddress = "faluvegi.agota@tss-yonder.com".
END.*/

/*FOR EACH bCustomer WHERE bCustomer.State = "CJ":
    DISPLAY bCustomer.Address bCustomer.CustNum.
END.*/

/*-----------------------------EXERCISE 3-----------------------------*/
/*stergeti ultimul client din Newark, precum si comenzile lui*/
/*FIND LAST bCustomer WHERE bCustomer.City = "Newark".
    DISPLAY bCustomer.City bCustomer.State bCustomer.Name.
    DO TRANSACTION ON ERROR UNDO, LEAVE:
    DELETE bCustomer.
    END.
    FOR EACH Order WHERE Order.CustNum = bCustomer.CustNum:
        DISPLAY Order.OrderNum Order.OrderDate Order.ShipDate.
        DO TRANSACTION ON ERROR UNDO, LEAVE:
        DELETE Order.
        END.
    END.
/*Cehck if it was truly deleted*/    
/*FIND LAST bCustomer WHERE bCustomer.City = "Newark".
    DISPLAY bCustomer.City bCustomer.State bCustomer.Name.
    FOR EACH Order WHERE Order.CustNum = bCustomer.CustNum:
        DISPLAY Order.OrderNum Order.OrderDate Order.ShipDate.
END.
*/

/*-----------------------------EXERCISE 4-----------------------------*/
/* Use exclusive lock on a table and try to access that table from another session with exclusive lock.

Build procedural Business layer – ABL Essentials:
-   Running ABL Procedures
-   Defining functions */*/

FIND Customer 1 EXCLUSIVE-LOCK.
DISPLAY "User 1 has locked:" NAME.
WAIT-FOR CLOSE OF THIS-PROCEDURE.