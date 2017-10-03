
/*------------------------------------------------------------------------
    File        : w2Tuesday.p
    Purpose     : 

    Syntax      :

    Description : 

    Author(s)   : 
    Created     : Tue Oct 03 12:23:55 EEST 2017
    Notes       :
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

BLOCK-LEVEL ON ERROR UNDO, THROW.

DEFINE VARIABLE cWord AS CHARACTER NO-UNDO INITIAL "Yonder".
DEFINE VARIABLE iTemp AS INTEGER NO-UNDO INITIAL 0.
DEFINE VARIABLE iCount AS INTEGER NO-UNDO INITIAL 0.
DEFINE VARIABLE cTemp AS CHARACTER NO-UNDO INITIAL "".
DEFINE VARIABLE cWordList AS CHARACTER NO-UNDO
    INITIAL "apple, pear, Yonder, strawberry, Yonder, blueberry, peach, Yonder, banana".

DEFINE TEMP-TABLE ttCustomer NO-UNDO LIKE-SEQUENTIAL Customer.
DEFINE TEMP-TABLE ttOrder NO-UNDO LIKE-SEQUENTIAL Order FIELD RepName LIKE Salesrep.RepName.
DEFINE TEMP-TABLE ttOline NO-UNDO LIKE-SEQUENTIAL OrderLine.

DEFINE DATASET dsCustomer FOR ttCustomer, ttOrder, ttOline
    DATA-RELATION OrderLine FOR ttOrder, ttOline
        RELATION-FIELDS(OrderNum, OrderNum)
    DATA-RELATION Order FOR ttOrder, ttCustomer
        RELATION-FIELDS(CustNum, CustNum).

/* ********************  Preprocessor Definitions  ******************** */


/* ***************************  Main Block  *************************** */
/*Fill dataset with data from Customer, Order & Order lines for a specific customer using datasets*/
/*DEFINE QUERY qOrder FOR Order, Salesrep.
DEFINE QUERY qCustomer FOR Customer.

DEFINE DATA-SOURCE srcOrder FOR QUERY qOrder Order KEYS(OrderNum), SalesRep KEYS(SalesRep).
DEFINE DATA-SOURCE srcOline FOR OrderLine KEYS(OrderNum).
DEFINE DATA-SOURCE srcCustomer FOR Customer KEYS(CustNum).

//QUERY qOrder:QUERY-PREPARE("FOR EACH Order WHERE Order.OrderNum = 1, " + "FIRST Customer OF Order, FIRST SalesRep OF Order").
QUERY qOrder:QUERY-PREPARE("FOR EACH Order WHERE Order.OrderNum < 10, " + "FIRST SalesRep OF Order").

BUFFER ttOrder:ATTACH-DATA-SOURCE(DATA-SOURCE srcOrder:HANDLE
//,"Customer.Name, CustName"
).

BUFFER ttOline:ATTACH-DATA-SOURCE(DATA-SOURCE srcOline:HANDLE).
BUFFER ttCustomer:ATTACH-DATA-SOURCE(DATA-SOURCE srcCustomer:HANDLE).

DATASET dsCustomer:FILL().

BUFFER ttOrder:DETACH-DATA-SOURCE().
BUFFER ttOline:DETACH-DATA-SOURCE().
BUFFER ttCustomer:DETACH-DATA-SOURCE().

FOR EACH ttOrder:
    DISPLAY
        ttOrder.OrderNum
        ttOrder.OrderDate
        ttOrder.RepName FORMAT "X(15)".
END.
FOR EACH ttOline:
    DISPLAY
        ttOline.OrderNum
        ttOline.Linenum.
END.
FOR EACH ttCustomer:
    DISPLAY ttCustomer.CustNum ttCustomer.Name.
END.

/*Update/delete data on Customer, Order & Order lines using data-sets*/
FOR EACH ttOline WHERE ttOline.LineNum = 2:
    DELETE ttOline.
END.

FOR EACH ttOline:
    DISPLAY
        ttOline.OrderNum
        ttOline.Linenum.
END.*/

/**************************************************************************************************************/
/*Creati o functie care sa extraga primele 3 caractere dintrun string primit ca input parameter si sa intoarca rezultatul ca si ouput*/
/*FUNCTION extract3 RETURNS CHARACTER (INPUT cString AS CHARACTER) FORWARD.

DISPLAY extract3(cWord).
FUNCTION extract3 RETURNS CHARACTER (INPUT cString AS CHARACTER):
    REPEAT iTemp = 1 TO 3:
        cTemp = cTemp + SUBSTRING(cString, iTemp, 1).
    END.
    RETURN cTemp.
END FUNCTION.*/

/**************************************************************************************************************/
/*Creati o functie care sa primeasca un input string ca si input parameter si sa intoarca numarul vocalelor din acel string*/
/*FUNCTION vowels RETURNS INTEGER (INPUT cString AS CHARACTER) FORWARD.

DISPLAY vowels(cWord).
FUNCTION vowels RETURNS INTEGER (INPUT cString AS CHARACTER):
    REPEAT iTemp = 1 TO LENGTH(cString):
        IF INDEX("aeiou", SUBSTRING(cString, iTemp, 1)) NE 0 THEN
            iCount = iCount + 1.
    END.
    RETURN iCount.
END FUNCTION.*/

/**************************************************************************************************************/
/*Creati o functie care sa primeasca ca si input parameter 2 stringuri, primul sa fie o lista de cuvinte separate prin separatorul “,” al doilea parametru este un singur cunvat , functia trebuie sa afle sis a returneze numarul apartiilor cuvantului din parametru 2 in lista de cuvinte parametrul 1*/
/*FUNCTION noTimes RETURNS INTEGER (INPUT cList AS CHARACTER, cString AS CHARACTER) FORWARD.

DISPLAY noTimes(cWordList, cWord).
FUNCTION noTimes RETURNS INTEGER (INPUT cList AS CHARACTER, cString AS CHARACTER):
    REPEAT iTemp = 1 TO NUM-ENTRIES(cList):
        DISPLAY ENTRY(iTemp, cList) FORMAT "X(15)".
        IF INDEX(ENTRY(iTemp, cList), cWord) NE 0 THEN
            iCount = iCount + 1.
    END.
    RETURN iCount.
END FUNCTION.*/

/**************************************************************************************************************/
/*Creati o functie care sa primeasca ca si input parameter 2 stringuri, primul sa fie o lista de cuvinte separate prin separatorul “,” al doilea parametru este un singur cunvat , functia trebuie sa gaseasca toate aparitiile cuvantului in lista si sa le stearga din lista , apoi sa returneze rezultatul stergerii*/
FUNCTION delDup RETURNS CHARACTER (INPUT cList AS CHARACTER, cString AS CHARACTER) FORWARD.

DISPLAY delDup(cWordList, cWord) FORMAT "X(75)".
FUNCTION delDup RETURNS CHARACTER (INPUT cList AS CHARACTER, cString AS CHARACTER):
    REPEAT iTemp = 1 TO NUM-ENTRIES(cList):
        DISPLAY ENTRY(iTemp, cList) FORMAT "X(15)".
        IF INDEX(ENTRY(iTemp, cList), cWord) = 0 THEN DO:
            cTemp = cTemp + ENTRY(iTemp, cList) + ",".
        DISPLAY ENTRY(iTemp, cList) FORMAT "X(15)". END.
    END.
    RETURN cTemp.
END FUNCTION.