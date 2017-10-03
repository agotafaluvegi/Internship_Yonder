/*{dsOrderTT.i}*/
/*------------------------------------------------------------------------
    File        : dsOrder.i
    Purpose     : 

    Syntax      :

    Description : 

    Author(s)   : 
    Created     : Tue Oct 03 10:19:48 EEST 2017
    Notes       :
  ----------------------------------------------------------------------*/
/*{dsOrderTT.i}*/
/* ***************************  Definitions  ************************** */
DEFINE DATASET dsOrder FOR ttOrder, ttOline, ttItem
    DATA-RELATION OrderLine FOR ttOrder, ttOline
        RELATION-FIELDS(OrderNum, OrderNum)
    DATA-RELATION LineItem FOR ttOline, ttItem
        RELATION-FIELDS(ItemNum, ItemNum).

/* ********************  Preprocessor Definitions  ******************** */


/* ***************************  Main Block  *************************** */
