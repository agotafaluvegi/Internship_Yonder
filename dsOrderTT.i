
/*------------------------------------------------------------------------
    File        : dsOrderTT.i
    Purpose     : 

    Syntax      :

    Description : 

    Author(s)   : 
    Created     : Tue Oct 03 10:12:21 EEST 2017
    Notes       :
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */
DEFINE TEMP-TABLE ttOrder NO-UNDO LIKE-SEQUENTIAL Order
    FIELD OrderTotal AS DECIMAL
    FIELD CustName LIKE Customer.Name
    FIELD RepName LIKE Salesrep.RepName.
DEFINE TEMP-TABLE ttOline NO-UNDO LIKE-SEQUENTIAL OrderLine.
DEFINE TEMP-TABLE ttItem NO-UNDO
    FIELD ItemNum   LIKE ITEM.ItemNum
    FIELD ItemName  LIKE ITEM.ItemName
    FIELD Price     LIKE ITEM.Price
    FIELD Weight    LIKE ITEM.Weight
    FIELD OnHand    LIKE ITEM.OnHand
    FIELD OnOrder   LIKE ITEM.OnOrder
    INDEX ItemNum   IS UNIQUE ItemNum.

/* ********************  Preprocessor Definitions  ******************** */


/* ***************************  Main Block  *************************** */
